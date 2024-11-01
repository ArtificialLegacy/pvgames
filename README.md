
# PVGames - ImgScal Plugin

This is a lua plugin built for my image processing tool: [ImgScal](https://github.com/ArtificialLegacy/imgscal).

It provides utility functions to work with the current generation of character assets from [PVGames](https://pvgames.itch.io/).

## Requirements

Any ImgScal workflow that imports this plugin must import the following built-in libraries:

* io
* collection
* spritesheet
* image

## Import

Within the `main()` function of a workflow:

```lua
local pvgames = require("pvgames")
```
