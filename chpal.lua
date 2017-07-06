--[[
MIT License

Copyright (c) 2017 CrazedProgrammer

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
]]

local args, pal = {...}, { }
local palmap = { 32768, 4096, 8192, 2, 2048, 1024, 512, 256,
                 128, 16384, 32, 16, 8, 4, 64, 1 }

if not args[1] then
    print("chpal <path>\nchpal --export <path>\nchpal --reset")
	return

elseif args[1] == "--export" then
	local path = shell.resolve(args[2])
	local handle = fs.open(path, "w")
	if not handle then
		printError("Failed to write to file \""..path.."\".")
		return
	end
	for i = 1, 16 do
		local palr, palg, palb = term.getPaletteColor(palmap[i])
		handle.writeLine("*.color"..(i - 1)..": #"..
		                 string.format("%02X%02X%02X", palr * 255, palg * 255, palb * 255))
	end
	handle.close()
	return

elseif args[1] == "--reset" then
    pal = { "#191919", "#7F664C", "#57A64E", "#F2B233", "#3366CC", "#B266E5", "#4C99B2", "#999999",
	        "#4C4C4C", "#CC4C4C", "#7FCC19", "#DEDE6C", "#99B2F2", "#E57FD8", "#F2B2CC", "#F0F0F0" }

else
	local path = shell.resolve(args[1])
	local handle = fs.open(path, "r")
	if not handle then
		printError("Palette file \""..path.."\" not found.")
		return
	end
	local line = handle.readLine()
	while line do
		line = line:gsub("^%s*(.-)%s*$", "%1") -- trim
		if line:find("%*%.color%d%d*: ") then
			index = tonumber(line:sub(8, (line:sub(9, 9) == ":") and 8 or 9)) + 1
			colour = line:sub(-7)
			pal[index] = colour
		end
		line = handle.readLine()
	end
	handle.close()
end

for i = 1, 16 do
	term.setPaletteColour(palmap[i], tonumber(pal[i]:sub(2), 16))
end
