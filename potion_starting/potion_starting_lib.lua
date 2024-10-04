---@diagnostic disable: undefined-global
dofile_once("data/scripts/lib/utilities.lua")
dofile_once("data/scripts/items/init_potion.lua")


---Default potion material
local potion_material = "water"

---Current UTC time
local UTC = {}
UTC.year, UTC.month, UTC.day, UTC.hour, UTC.minute, UTC.second = GameGetDateAndTimeUTC()

---Current Local time (includes jussi and mammi bools)
local LOCAL = {}
LOCAL.year, LOCAL.month, LOCAL.day, LOCAL.hour, LOCAL.minute, LOCAL.second, LOCAL.jussi, LOCAL.mammi = GameGetDateAndTimeLocal()


---Function that compares two tables to see if they are identical. Can be used to easily check between current date and desired date using tables. By Nahtan
local function compare_tables(a, b) 
    if type(a) ~= type(b) then
        return false
    end
    if type(a) == "table" then
        for k, v in pairs(a) do
            if not compare_tables(v, b[k]) then
                return false
            end
        end
        return true
    end
    return a == b
end --awesomium function grabbed from nathan (i was incompetent so he made the function for me)

---This function just corrects the tables that lack probability fields. Probability will default to 10 for all material tables
local function correct_tables()
	for index, value in ipairs({starterpotions, magicpotions, fail_list}) do
		for k, v in ipairs(value) do
			if v.probability == nil then v.probability = 10 end
		end
	end
end

---This function combines tables so you can easily merge your custom tables into the vanilla ones
local function combine_tables(base, addition)
	for i=1,#addition do
		base[#base+1] = addition[i]
	end
	return base
end



---starter potions, 70% chance to pull from this table
local starterpotions = {
	{	probability = 32.5, 	"water"			},
	{	probability = 6.5, 		"mud"			},
	{	probability = 6.5, 		"water_swamp"	},
	{ 	probability = 6.5, 		"water_salt"	},
	{	probability = 6.5, 		"swamp"			},
	{	probability = 6.5, 		"snow"			},
	{	probability = 5, 		"blood"			},
}

---magic potions, 29% chance to pull from this table
local magicpotions = {
	{	"acid"							},
	{	"magic_liquid_polymorph"		},
	{	"magic_liquid_random_polymorph"	},
	{	"magic_liquid_berserk"			},
	{	"magic_liquid_charm"			},
	{	"magic_liquid_movement_faster"	},
}

	-- 1/10,000,100 technically, lmao.
local one_in_millions = { -- "key" must be from 1 to 100000
	{	key = 666, 	"urine"},
	{	key = 79, 	"gold"}
}

---Material outcomes if the "one-in-a-million" doesnt hit anything
local failpotions = {
	{	"slime"					},
	{	"gunpowder_unstable"	}
}

---Table of custom functions potion_a_materials runs through before returning the chosen material
---@type fun(outcome: string, r_value: number, r_value2: number, data: table)[]
local functions = {
	function()
		if compare_tables({LOCAL.month, LOCAL.day}, {5, 1}) or compare_tables({LOCAL.month, LOCAL.day}, {4, 30}) and (Random( 0, 100 ) <= 20) then return "sima" end
	end
}

---Table of custom functions init runs through after potion_a_materials returns the chosen material
---@type fun(potion_material: string, data: table)[]
local functions2 = {
}

---Function that chooses the potion material
local function potion_a_materials(outcome, r_value, r_value2, data) --Variables are available as inputs in case you want to run with forced RNG. data lets you pass extra data if you want
    outcome = outcome or potion_material
	r_value = r_value or Random( 1, 100 )
	r_value2 = r_value2 or Random( 0, 100000 )
	data = data or {}

	local rnd = random_create(r_value, r_value2)
	if( r_value <= 70 ) then --70% chance for staterpotions
		outcome = pick_random_from_table_weighted(rnd, starterpotions)[1]
	elseif( r_value <= 99 ) then --29% chance for magicpotions
		r_value = Random( 0, 100 )
		outcome = pick_random_from_table_weighted(rnd, magicpotions)[1]
	else --1% chance to try for the one_in_millions
		outcome = pick_random_from_table_weighted(rnd, failpotions)[1]
		for k,v in pairs(one_in_millions) do
			if r_value2 == v.key then outcome = v[1] end --loop over one_in_millions
		end
	end

	if functions ~= nil then --in case someone empties the function to skip this step
		for index, value in pairs(functions) do
			 outcome = value(outcome, r_value, r_value2, data) or outcome
		end
	end
	
    return tostring(outcome)
end

---@diagnostic disable
function init( entity_id ) --mostly vanilla function
	local x,y = EntityGetTransform( entity_id )
	SetRandomSeed( x, y )
	correct_tables() --add default probabilities

	local n_of_deaths = tonumber( StatsGlobalGetValue("death_count") )
	if( n_of_deaths >= 1 ) then
		potion_material = potion_a_materials() or potion_material --if potion_a_materials returns nil or smth, default to potion_material
	end

	
	if functions2 ~= nil then
		for index, value in pairs(functions2) do
			potion_material = value(potion_material) or potion_material
   		end
	end

	init_potion( entity_id, potion_material )
end