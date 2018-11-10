return {
  version = "1.2",
  luaversion = "5.1",
  tiledversion = "1.2.0",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 60,
  height = 14,
  tilewidth = 128,
  tileheight = 128,
  nextlayerid = 13,
  nextobjectid = 175,
  properties = {},
  tilesets = {
    {
      name = "main_sheet",
      firstgid = 1,
      tilewidth = 128,
      tileheight = 128,
      spacing = 0,
      margin = 0,
      columns = 1,
      image = "tilesheets/sheet1.png",
      imagewidth = 128,
      imageheight = 128,
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 128,
        height = 128
      },
      properties = {},
      terrains = {},
      tilecount = 1,
      tiles = {}
    },
    {
      name = "3by3",
      firstgid = 2,
      tilewidth = 128,
      tileheight = 128,
      spacing = 0,
      margin = 4,
      columns = 3,
      image = "tilesheets/3by3_1.png",
      imagewidth = 392,
      imageheight = 392,
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 128,
        height = 128
      },
      properties = {},
      terrains = {},
      tilecount = 9,
      tiles = {}
    },
    {
      name = "darkCorners",
      firstgid = 11,
      tilewidth = 128,
      tileheight = 128,
      spacing = 0,
      margin = 4,
      columns = 2,
      image = "tilesheets/darkCorners_sheet.png",
      imagewidth = 264,
      imageheight = 264,
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 128,
        height = 128
      },
      properties = {},
      terrains = {},
      tilecount = 4,
      tiles = {}
    }
  },
  layers = {
    {
      type = "tilelayer",
      id = 12,
      name = "Main_Tiles",
      x = 0,
      y = 0,
      width = 60,
      height = 14,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "base64",
      data = "AQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAAAAAAAAAAAAAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAAAAAAAAAAAAAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAA"
    },
    {
      type = "objectgroup",
      id = 2,
      name = "Window_Size",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {}
    },
    {
      type = "objectgroup",
      id = 3,
      name = "Room",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 121,
          name = "main",
          type = "",
          shape = "rectangle",
          x = 128,
          y = 128,
          width = 7424,
          height = 1536,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      id = 4,
      name = "Walls",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 144,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 0,
          width = 1536,
          height = 256,
          rotation = 0,
          visible = true,
          properties = {
            ["down"] = true
          }
        },
        {
          id = 146,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2816,
          y = 0,
          width = 3712,
          height = 256,
          rotation = 0,
          visible = true,
          properties = {
            ["down"] = true
          }
        },
        {
          id = 147,
          name = "",
          type = "",
          shape = "rectangle",
          x = 6528,
          y = 0,
          width = 1152,
          height = 1024,
          rotation = 0,
          visible = true,
          properties = {
            ["down"] = true,
            ["left"] = true
          }
        },
        {
          id = 150,
          name = "",
          type = "",
          shape = "rectangle",
          x = 4352,
          y = 768,
          width = 1152,
          height = 1024,
          rotation = 0,
          visible = true,
          properties = {
            ["left"] = true,
            ["right"] = true,
            ["up"] = true
          }
        },
        {
          id = 152,
          name = "",
          type = "",
          shape = "rectangle",
          x = 5504,
          y = 1152,
          width = 384,
          height = 640,
          rotation = 0,
          visible = true,
          properties = {
            ["right"] = true,
            ["up"] = true
          }
        },
        {
          id = 153,
          name = "",
          type = "",
          shape = "rectangle",
          x = 5888,
          y = 1536,
          width = 1792,
          height = 256,
          rotation = 0,
          visible = true,
          properties = {
            ["up"] = true
          }
        },
        {
          id = 172,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1536,
          y = 0,
          width = 1280,
          height = 1152,
          rotation = 0,
          visible = true,
          properties = {
            ["down"] = true,
            ["left"] = true,
            ["right"] = true,
            ["up"] = false
          }
        },
        {
          id = 173,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1152,
          y = 1536,
          width = 3200,
          height = 256,
          rotation = 0,
          visible = true,
          properties = {
            ["up"] = true
          }
        },
        {
          id = 174,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 896,
          width = 1152,
          height = 896,
          rotation = 0,
          visible = true,
          properties = {
            ["down"] = false,
            ["left"] = false,
            ["right"] = true,
            ["up"] = true
          }
        }
      }
    },
    {
      type = "objectgroup",
      id = 5,
      name = "Transitions",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 131,
          name = "rm14",
          type = "",
          shape = "rectangle",
          x = 7552,
          y = 1024,
          width = 128,
          height = 512,
          rotation = 0,
          visible = true,
          properties = {
            ["relativeX"] = 0,
            ["relativeY"] = 0,
            ["spawnX"] = 200,
            ["spawnY"] = 0
          }
        },
        {
          id = 154,
          name = "rm16",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 256,
          width = 128,
          height = 640,
          rotation = 0,
          visible = true,
          properties = {
            ["relativeX"] = 0,
            ["relativeY"] = 0,
            ["spawnX"] = -200,
            ["spawnY"] = 0
          }
        }
      }
    },
    {
      type = "objectgroup",
      id = 6,
      name = "Pickups",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {}
    },
    {
      type = "objectgroup",
      id = 7,
      name = "Enemies",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 155,
          name = "bat",
          type = "bat",
          shape = "rectangle",
          x = 6144,
          y = 384,
          width = 128,
          height = 128,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 156,
          name = "bat",
          type = "bat",
          shape = "rectangle",
          x = 3200,
          y = 768,
          width = 128,
          height = 128,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 157,
          name = "bat",
          type = "bat",
          shape = "rectangle",
          x = 3328,
          y = 1280,
          width = 128,
          height = 128,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 158,
          name = "bat",
          type = "bat",
          shape = "rectangle",
          x = 3968,
          y = 1152,
          width = 128,
          height = 128,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 162,
          name = "spike",
          type = "spike",
          shape = "rectangle",
          x = 4992,
          y = 640,
          width = 128,
          height = 128,
          rotation = 0,
          visible = true,
          properties = {
            ["arg"] = "down"
          }
        },
        {
          id = 164,
          name = "spike",
          type = "spike",
          shape = "rectangle",
          x = 2048,
          y = 1408,
          width = 128,
          height = 128,
          rotation = 0,
          visible = true,
          properties = {
            ["arg"] = "down"
          }
        },
        {
          id = 170,
          name = "spike",
          type = "spike",
          shape = "rectangle",
          x = 2176,
          y = 1152,
          width = 128,
          height = 128,
          rotation = 0,
          visible = true,
          properties = {
            ["arg"] = "up"
          }
        },
        {
          id = 171,
          name = "spike",
          type = "spike",
          shape = "rectangle",
          x = 6400,
          y = 768,
          width = 128,
          height = 128,
          rotation = 0,
          visible = true,
          properties = {
            ["arg"] = "right"
          }
        }
      }
    },
    {
      type = "objectgroup",
      id = 8,
      name = "Breakables",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {}
    },
    {
      type = "objectgroup",
      id = 9,
      name = "Water",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {}
    },
    {
      type = "objectgroup",
      id = 10,
      name = "Vines",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {}
    }
  }
}
