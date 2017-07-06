# chpal
Palette changer for ComputerCraft 1.8 and later 

## Usage
`chpal <path>` Change palette to the palette in `path`.  
`chpal --export <path>` Exports the current palette to `path`.  
`chpal --reset` Resets the palette to the default ComputerCraft palette.  

## Palette format
The palette format chpal uses is a limited version of the .Xresources format.  
An example palette entry is `*.color0: #000000`.  
The only criterium for an entry is `*.color<n>: #<hex>`.  
You can find examples of this in the [palettes](palettes) directory.  

## pacpal
pacpal shows an image with all the colours, so you can get a quick look of all the colours.
