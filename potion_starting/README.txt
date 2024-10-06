This is a lib created to override the potion_starting.lua to be more appendable and have more options for mods to add their own materials without accidentally overwriting one another.

To use this, you just need to put the potion_starting.lua file at data/scripts/items/potion_starting.lua and then append it with your own tables and functions. Appending should look something like this:

	ModLuaFileAppend( "data/scripts/items/potion_starting.lua", "mods/your_mod/file/path/to/your/custom_starting_potion_appends.lua" )


For information on what the append file should look like, look to the example_append.lua file for more information. 
If you are still lost, I have also thrown in how I use it in Chemical Curiosities under chemical_curiosities_example.lua, so feel free to give that a look for a less comment-riddled experience


There is also a TEST() function commented out in the init function in case you want to see roughly how common your additions are alongside the vanilla tables
Uncomment that and input a value of your choosing (would recommend 100k or higher exponent of 10) and it will generate that many random potions and arrange them neatly into a console-printed table
I personally found 10 million to be a good number, but I have managed to render up to 1 Billion (albeit after 45 minutes of processing). It displays % so you know the progress through the current test


That is all, if you have any issues, questions, complaints or suggestions, ping me @userk on Discord in Noitacord, Chemical Curiosities Discord or just in DMs
