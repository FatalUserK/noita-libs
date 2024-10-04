---@diagnostic disable: undefined-global, lowercase-global
--[[

	-- UserK's Super Handy-Dandy Starting-Potion Lib! --

	--simply append the lib to "data/scripts/items/potion_starting.lua" and then append with your tables and merge functions. appending should be something like:


	ModLuaFileAppend( "data/scripts/items/potion_starting.lua", "mods/your_mod/file/path/to/your/potion_starting_lib.lua")
	ModLuaFileAppend( "data/scripts/items/potion_starting.lua", "mods/your_mod/file/path/to/your/custom_starting_potion_appends.lua")


	then your "custom_starting_potion_appends.lua" should have tables that you then merge into the tables found in the library. Examples can be found below:

]]



--append staterpotions:
local modded_starterpotions = {
	{	probability = 8,		"epic_modded_material"},
	{	probability = 4.5,		"less_epic_modded_material"},
	{							"honestly_kinda_crap_modded_material"} --probability is an optional field that will default to 10
}
starterpotions = combine_tables(starterpotions, modded_starterpotions) --format for combining tables should be lib_table = combine_tabless(lib_table, modded_table)


--append magicpotions:
local modded_magicpotions = {
	{"awesomium"}, --even if you arent using probability, each material should be contained within its own table
	{"lamium"},
	{"averagium", probability = 30}, --adding probability fields is optional for starterpotions, magicpotions, and failpotions
}
magicpotions = combine_tables(magicpotions, modded_magicpotions)

--this is basically all the average modder needs to care about. look below for some additional funny things



--append one_in_millions
local modded_one_in_millions = {
	{	key = 0,	"existium"}, --"key" can range from 0 to 100,000
	{	key = -1,	"non_existium"}, --anything outside this range cannot be found
}


--append failpotions
local modded_failpotions = {
	{"instant_deathium"} --idk i ran out of funnies, this just appends like any of the other functions, fairly self-explanatory
}



--append functions
local modded_functions = {
	function(outcome) --if christmas, 2024, then replace water outcome with santanium
		if compare_tables({UTC.year, UTC.month, UTC.day}, {2024, 12, 25}) and outcome == "water" then return "santanium" end
	end,
	function() --pretend to give deezium based on mod setting lmao
		if ModSettingGet(mysuperawesomemod.DEEZIUM_START) == true then return "not_deezium" end
	end,
	
	function(outcome, r_value)
		if compare_tables({UTC.month, UTC.day}, {4, 1}) then
			if r_value == 69 then return "super secret material" end 	--check r_value for 1% chance
			if outcome == "water" then return "liquid_goober" end 		--if water, replace with liquid_goober
		end
	end
}
functions = combine_tables(functions, modded_functions)


--append functions2
local modded_functions2 = {
	function()
		if LOCAL.jussi == true and (Random( 0, 100 ) <= 20) then return "sima" end
	end,
	function() --tbh technically not vanilla, but sure lmao.
		if LOCAL.mammi == true and (Random( 0, 100 ) <= 20) then return "mammi" end
	end
}
functions2 = combine_tables(functions2, modded_functions2)