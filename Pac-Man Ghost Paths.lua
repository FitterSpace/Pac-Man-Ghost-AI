-- Pac-Man ghost AI viewer v1.1
-- Shows ghost target tiles and projected paths of ghosts

-- You can change this to make the paths shorter or longer:
PATHDIST = 25

--s = manager:machine().screens[":screen"]
--mem = manager:machine().devices[":maincpu"].spaces["program"]
--XMAX = s:width() - 1
--YMAX = s:height() - 1

function onframe()
    getvalues()
    draw()
end

function getvalues()
    pacmanX = memory.read_s8(0x4D39)
    pacmanY = memory.read_s8(0x4D3A)
    pacmanD = memory.read_s8(0x4D3C)
    blinkyX = memory.read_s8(0x4D0A)
    blinkyY = memory.read_s8(0x4D0B)
    blinkyD = memory.read_s8(0x4D2C)
    blinkyF = memory.read_s8(0x4DA7)
    blinkyE = memory.read_s8(0x4DAC)
    pinkyX = memory.read_s8(0x4D0C)
    pinkyY = memory.read_s8(0x4D0D)
    pinkyD = memory.read_s8(0x4D2D)
    pinkyF = memory.read_s8(0x4DA8)
    pinkyE = memory.read_s8(0x4DAD)
    inkyX = memory.read_s8(0x4D0E)
    inkyY = memory.read_s8(0x4D0F)
    inkyD = memory.read_s8(0x4D2E)
    inkyF = memory.read_s8(0x4DA9)
    inkyE = memory.read_s8(0x4DAE)
    clydeX = memory.read_s8(0x4D10)
    clydeY = memory.read_s8(0x4D11)
    clydeD = memory.read_s8(0x4D2F)
    clydeF = memory.read_s8(0x4DAA)
    clydeE = memory.read_s8(0x4DAF)
    chaseMode = memory.read_s8(0x4DC1)
    unknownTimer = memory.read_s8(0x4E04)
    fewDotsLeft = memory.read_s8(0x4DB6)
end

function draw()
    if (not disable_trail(blinkyX, blinkyY, blinkyF, blinkyE)) then
        draw_blinky_ai()
    end
    if (not disable_trail(pinkyX, pinkyY, pinkyF, pinkyE)) then
        draw_pinky_ai()
    end
    if (not disable_trail(inkyX, inkyY, inkyF, inkyE)) then
        draw_inky_ai()
    end
    if (not disable_trail(clydeX, clydeY, clydeF, clydeE)) then
        draw_clyde_ai()
    end
end

function draw_blinky_ai()
    g = tile_to_screen(blinkyX, blinkyY)
    t = {0x1D, 0x22}
    
    if (
        --(chaseMode & 1) == 1 or
        bit.band(chaseMode, 1) == 1 or
        unknownTimer ~= 3 or
        fewDotsLeft ~= 0
    ) then
        t = {pacmanX, pacmanY}
    end
    
    if (blinkyE == 1) then
        t = {0x2C, 0x2E}
    end
    
    draw_next_movements(blinkyX, blinkyY, blinkyD, blinkyE, t[1], t[2], blinkyE == 1, 0x40FF0000)
    
    t = tile_to_screen(t[1], t[2])
    gui.drawBox(g[1]-4, g[2]-4, g[1]+3, g[2]+3, 0x40FF0000, 0x40FF0000)
    gui.drawBox(t[1]-2, t[2]-2, t[1]+2, t[2]+2, 0xFFFF0000, 0)
end

function draw_pinky_ai()
    g = tile_to_screen(pinkyX, pinkyY)
    t = {0x1D, 0x39}
    
    if (
        --(chaseMode & 1) == 1 or
        bit.band(chaseMode, 1) == 1 or
        unknownTimer ~= 3
    ) then
        px = pacmanX
        py = pacmanY
        
        if (pacmanD == 0) then
            py = py - 4
        elseif (pacmanD == 1) then
            px = px + 4
        elseif (pacmanD == 2) then
            py = py + 4
        elseif (pacmanD == 3) then
            py = py + 4 -- oof
            px = px - 4
        end
        t = {px, py}
    end
    
    if (pinkyE == 1) then
        t = {0x2C, 0x2E}
    end
    
    draw_next_movements(pinkyX, pinkyY, pinkyD, pinkyE, t[1], t[2], pinkyE == 1, 0x40FFB8FF)
    
    t = tile_to_screen(t[1], t[2])
    gui.drawBox(g[1]-4, g[2]-4, g[1]+3, g[2]+3, 0x40FFB8FF, 0x40FFB8FF)
    gui.drawBox(t[1]-2, t[2]-2, t[1]+2, t[2]+2, 0xFFFFB8FF, 0)
end

function draw_inky_ai()
    g = tile_to_screen(inkyX, inkyY)
    t = {0x40, 0x20}
    
    if (
        --(chaseMode & 1) == 1 or
        bit.band(chaseMode, 1) == 1 or
        unknownTimer ~= 3
    ) then
        px = pacmanX
        py = pacmanY
        
        if (pacmanD == 0) then
            py = py - 2
        elseif (pacmanD == 1) then
            px = px + 2
        elseif (pacmanD == 2) then
            py = py + 2
        elseif (pacmanD == 3) then
            py = py + 2 -- oof
            px = px - 2
        end
        
        px = px + (px - blinkyX)
        py = py + (py - blinkyY)
        t = {px, py}
    end
    
    if (inkyE == 1) then
        t = {0x2C, 0x2E}
    end
    
    draw_next_movements(inkyX, inkyY, inkyD, inkyE, t[1], t[2], inkyE == 1, 0x4000FFFF)
    
    t = tile_to_screen(t[1], t[2])
    gui.drawBox(g[1]-4, g[2]-4, g[1]+3, g[2]+3, 0x4000FFFF, 0x4000FFFF)
    gui.drawBox(t[1]-2, t[2]-2, t[1]+2, t[2]+2, 0xFF00FFFF, 0)
end

function draw_clyde_ai()
    g = tile_to_screen(clydeX, clydeY)
    t = {0x40, 0x3B}
    
    if (
        dist2(pacmanX, pacmanY, clydeX, clydeY) >= 0x40 and
        (bit.band(chaseMode, 1) == 1 or --(chaseMode & 1) == 1 or
        unknownTimer ~= 3)
    ) then
        t = {pacmanX, pacmanY}
    end
    
    if (clydeE == 1) then
        t = {0x2C, 0x2E}
    end
    
    draw_next_movements(clydeX, clydeY, clydeD, clydeE, t[1], t[2], clydeE == 1, 0x40FFB851)
    
    t = tile_to_screen(t[1], t[2])
    gui.drawBox(g[1]-4, g[2]-4, g[1]+3, g[2]+3, 0x40FFB851, 0x40FFB851)
    gui.drawBox(t[1]-2, t[2]-2, t[1]+2, t[2]+2, 0xFFFFB851, 0)
end

function draw_next_movements(x, y, d, e, tx, ty, stop, c)
    if (d == 0) then
        y = y - 1
    elseif (d == 1) then
        x = x + 1
    elseif (d == 2) then
        y = y + 1
    else
        x = x - 1
    end
        
    local ll = {x, y, d}
    local i = 0
    bs = tile_to_screen(ll[1], ll[2])
    gui.drawBox(bs[1]-4, bs[2]-4, bs[1]+3, bs[2]+3, c, c)
    
    while (i < PATHDIST) and not ((ll[1] == pacmanX and ll[2] == pacmanY) or (stop and ll[1] == tx and ll[2] == ty)) do
        lll = get_next_movement(ll[1], ll[2], ll[3], e, tx, ty)
        bs = tile_to_screen(lll[1], lll[2])
        gui.drawBox(bs[1]-4, bs[2]-4, bs[1]+3, bs[2]+3, c, c)
        ll = {lll[1], lll[2], lll[3]}
        i = i + 1
    end
end

function get_next_movement(x, y, d, e, tx, ty) -- d = R D L U
    if (not ((e == 0) and (x == 0x2C or x == 0x38) and (y <= 0x30 and y >= 0x2B) and (d == 0 or d == 2))) then
        dirs = {{-1, 0}, {0, 1}, {1, 0}, {0, -1}}
        
        local minL = 99999
        local minI = 1
        local i = 1
        while (i <= 4) do
            if (not ((i == 1 and d == 1) or (i == 2 and d == 0) or (i == 3 and d == 3) or (i == 4 and d == 2))) then
                local nx = x + dirs[i][1]
                local ny = y + dirs[i][2]
                
                
                if (is_tile_empty(nx, ny)) then
                    local l = dist2(nx, ny, tx, ty)
                    
                    if (l < minL) then
                        minL = l
                        minI = i
                    end
                end
            end
            i = i + 1
        end
        
        d = 4 - minI
    end
    
    local result = {x, y, d}
    
    if (d == 0) then
        result = {x, y - 1, d}
    elseif (d == 1) then
        result = {x + 1, y, d}
    elseif (d == 2) then
        result = {x, y + 1, d}
    else
        result = {x - 1, y, d}
    end
    
    if (result[2] == 0x3E) then
        result[2] = 0x1E
    elseif (result[2] == 0x1D) then
        result[2] = 0x3D
    end
    
    return result
end

function disable_trail(x, y, fright, eyes)
    if (x == 0x2F and y >= 0x2B and y <= 0x30) then
        return true
    elseif (eyes == 1) then
        if (x >= 0x2C and x <= 0x30 and y >= 0x2C and y <= 0x2F) then
            return true
        end
    elseif (fright == 1) then
        return true
    end
    return false
end

function is_tile_empty(x, y)
    if (y >= 0x3C or y <= 0x1F) then
        return x == 0x2F
    end
    vid = memory.read_s8(0x4040 +
        0x20 * (y - 0x20) +
        (x - 0x20))
    return vid > 0 or vid < -0x70
end

function dist2(x1, y1, x2, y2)
    return ((x2-x1)*(x2-x1))+((y2-y1)*(y2-y1))
end

function tile_to_screen(x, y)
    return {
        --8*(x-30)+4,
        --8*(y-32)+4
        client.bufferwidth() -8*(y-31)+4, 
        8*(x-30)+4
    }
end

while true do

    --for i=0x20,0x3B,1 do
    --    for j=0x20,0x3F,1 do
    --        gui.drawBox(i, j, i + 1, j + 1, is_tile_empty(i, j) and 0xFFFFFF00 or 0xFFFF00FF);
    --    end
    --end


    onframe(); -- or inline
    emu.frameadvance();
 end