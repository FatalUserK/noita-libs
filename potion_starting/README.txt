This is a lib created to override the potion_starting.lua to be more appendable and have more options for mods to add their own materials without accidentally overwriting one another.

To use this, you just need to put the potion_starting.lua file at data/scripts/items/potion_starting.lua and then append it with your own tables and functions. Appending should look something like this:

	ModLuaFileAppend( "data/scripts/items/potion_starting.lua", "mods/your_mod/file/path/to/your/custom_starting_potion_appends.lua" )


For information on what the append file should look like, look to the example_append.lua file for more information. 
If you are still lost, I have also thrown in how I use it in Chemical Curiosities under chemical_curiosities_example.lua, so feel free to give that a look for a less comment-riddled experience


That is all, if you have any issues, questions, complaints or suggestions, ping me @userk on Discord in Noitacord, Chemical Curiosities Discord or just in DMs