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

local imgstr = [[ 1111  ccc   ddd   bbb   aaa   999 
111   c8c8c d8d8d b8b8b a8a8a 98989
11    cfcfc dfdfd bfbfb afafa 9f9f9
111   ccccc ddddd bbbbb aaaaa 99999
 1111 c c c d d d b b b a a a 9 9 9
                                   
 4444  eee   555   333   222   666 
444   e0e0e 50505 30303 20202 60606
44    e7e7e 57575 37373 27272 67676
444   eeeee 55555 33333 22222 66666
 4444 e e e 5 5 5 3 3 3 2 2 2 6 6 6]]
local imgwidth = 35
local imgheight = 11

-- oh god why
local imgpath = "/tmpimg"..math.random(1, 9999)
local handle = fs.open(imgpath, "w")
handle.write(imgstr)
handle.close()
local img = paintutils.loadImage(imgpath)
fs.delete(imgpath)

local twidth, theight = term.getSize()
local ocx, ocy = term.getCursorPos()
local tcx, tcy = math.floor((twidth - imgwidth) / 2) + 1, (ocy > (theight - imgheight)) and (theight - imgheight) or ocy

if ocy > tcy then
	term.scroll(ocy - tcy)
end

paintutils.drawImage(img, tcx, tcy)

term.setCursorPos(1, tcy + imgheight)
