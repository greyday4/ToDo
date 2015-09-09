Events:Subscribe("PlayerChat", function(args)

	local users = { -- Change to "all" if you want everyone to be able to use them. Else use SteamIDs.
					["STEAM_0:1:45324628"] = true, -- Tally
					["YOURSTEAMIDHERE"] = true
				}
	--local users = "all"

	local words = args.text:split(" ")
	if not users[tostring(args.player:GetSteamId())] then Chat:Send(args.player, "You don't have the permissions for that!", Color.Red) return end
	if words[1] == "/todo" and words[2] == nil then
		Chat:Send(args.player, "Use '/todo w [task here]' to leave a to-do.", Color.Aquamarine)
		Chat:Send(args.player, "Use '/todo d [task number]' to remove a to-do.", Color.Aquamarine)
		Chat:Send(args.player, "Use '/todo r' to read your to-dos.", Color.Aquamarine)
	elseif words[1] == "/todo" and words[2] == "w" then
		if words[3] == nil then Chat:Send(args.player, "Use '/todo w [task here]' to leave a to-do.", Color.Aquamarine) return end
		local f = io.open("todo.txt", "a")
		local string = string.format("%q %s", string.sub(args.text, 9), " - "..args.player:GetName().." ["..os.date().."]")
		f:write(string.."\n")
		f:close()
		Chat:Send(args.player, "To-do created: ", Color.Cyan, string, Color.White)
	elseif words[1] == "/todo" and words[2] == "d" and words[3] ~= nil then
		if string.find(words[3], "%D") ~= nil and string.find(words[3], "*") == nil then Chat:Send(args.player, "Use a number to select which to delete.", Color.Aquamarine) return end
		if words[3] == "*" then
			local f = io.open("todo.txt", "w")
			f:write("")
			f:close()
			Chat:Send(args.player, "All To-Dos deleted!", Color.Aquamarine)
		else
			local count = 1
			local t = {}
			for line in io.lines("todo.txt") do
				if count == tonumber(words[3]) then
					Chat:Send(args.player, "To-Do deleted: ", Color.Cyan, line, Color.White)
					count = count + 1
				else
    				table.insert(t, line)
    				count = count + 1
    			end
    		end
			local f = io.open("todo.txt", "w")
			f:write("")
			f:close()
			local f = io.open("todo.txt", "a")
			for k,line in pairs(t) do
				f:write(line.."\n")
			end
			f:close()
		end
	elseif words[1] == "/todo" and words[2] == "d" then
		Chat:Send(args.player, "Use a number to specify which to-do to delete, or * for all.", Color.Aquamarine)
	elseif words[1] == "/todo" and words[2] == "r" then
		Chat:Send(args.player, "--To-Do List--", Color.Aquamarine)
		local count = 1
    	for line in io.lines("todo.txt") do
    		Chat:Send(args.player, count..". ", Color.Cyan, line, Color.White)
    		count = count + 1
    	end
    	if count == 1 then
    		Chat:Send(args.player, "None.", Color.White)
    	end
    end
end)