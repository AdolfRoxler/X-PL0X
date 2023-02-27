return {
    esp = {
        enabled = false, tracers = false, head = false, 
        --chams = {enabled = false, throughWalls = false},  -- purged due to limitation of 31 objects. NOT GOOD.
        box = {enabled = false, healthbar = false, dynamic = false},
        nametag = {enabled = false, displayname = false, displayhealth = false, displayavatar = false, displaydistance = false,
            customization = {
                base = {color = {R=0,G=0,B=0}, opacity=1},
                secondaryLeft = {R=0,G=0,B=0}, opacity=1},
                secondaryRight = {R=0,G=0,B=0}, opacity=1},
            },
        },
    }
}