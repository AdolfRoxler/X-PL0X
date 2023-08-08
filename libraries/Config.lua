return {
    esp = {
        enabled = false, precise = false, head = false, -- If precise is set to false it'll use bitwise operations, which are WAY FASTER.
        --chams = {enabled = false, throughWalls = false},  -- purged due to limitation of 31 objects. NOT GOOD.
        box = {enabled = true, healthbar = false, dynamic = false},
        tracers = {enabled = true, maxdistance = 200, thickness = 4},
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

    }
}