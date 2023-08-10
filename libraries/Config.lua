return {
    render = {
        esp = {
            enabled = true, precise = false, head = false, -- If precise is set to false it'll use bitwise operations, which are WAY FASTER.
             --chams = {enabled = false, throughWalls = false},  -- purged due to limitation of 31 objects. NOT GOOD.
              box = {enabled = true, healthbar = false, dynamic = false},
               tracers = {enabled = false, maxdistance = 200},
             data = {
               name = {enabled = false, displayname = false}
              },
              --[[nametag = {enabled = false, displayname = false, displayhealth = false, displayavatar = false, displaydistance = false,
                   customization = {
                       base = {color = {R=0,G=0,B=0}, opacity=1},
                        secondaryLeft = {color = {R=0,G=0,B=0}, opacity=1},
                      secondaryRight = {color = {R=0,G=0,B=0}, opacity=1},
                  },
             },]]

        },
        ui = {
            crosshair = {enabled = true, length = 15, thickness = 3, rgb = false, color = {r = 255, g = 255, b = 255}}
        },

    },



    movement = {
        walkspeed = {enabled = false, speed = 32, allowinertia = false},
        flight = {enabled = false, speed = 32},

    },
    spoof = {
        deep = false,
        manual = {username = "Roblox",displayname = "Roblox",userid = 1, enabled = false}

        gameowner = false,
        rank = false,
        assets = false,
    },
}