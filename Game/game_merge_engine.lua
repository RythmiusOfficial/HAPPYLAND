--This is an experimental file designed to implement the "quad algorithm" but for blocks.

-------------------------------------------------
--                  Helpers
-------------------------------------------------

function p.create_box(min, max)
    local box = {}
    box.min = min
    box.max = max
    return box
end

--For debugging.
function p.box_to_str(box)
    return "Box: " .. std.bp_to_str(box.min) .. " to " .. std.bp_to_str(box.max)
end

function p.create_cube(bp)
    return p.create_box(bp, bp)
end

-- function p.box_contains_cube(box, bp)
--     if( bp.x < box.min.x ) then return false end
--     if( bp.y < box.min.y ) then return false end
--     if( bp.z < box.min.z ) then return false end
--     if( bp.x > box.max.x ) then return false end
--     if( bp.y > box.max.y ) then return false end
--     if( bp.z > box.max.z ) then return false end
--     return true
-- end

function p.get_box_volume(box)
    local x = box.max.x - box.min.x + 1
    local y = box.max.y - box.min.y + 1
    local z = box.max.z - box.min.z + 1
    return x*y*z
end

function p.boxes_are_disjoint(box1, box2)
    if( box1.max.x < box2.min.x ) then return true end
    if( box1.max.y < box2.min.y ) then return true end
    if( box1.max.z < box2.min.z ) then return true end
    if( box2.max.x < box1.min.x ) then return true end
    if( box2.max.y < box1.min.y ) then return true end
    if( box2.max.z < box1.min.z ) then return true end
    return false
end

--Returns the smallest box that contains
--the given two boxes.
function p.get_hull_of_boxes(box1, box2)
    local box = {}
    box.min = {}
    box.max = {}
    box.min.x = math.min(box1.min.x, box2.min.x)
    box.min.y = math.min(box1.min.y, box2.min.y)
    box.min.z = math.min(box1.min.z, box2.min.z)
    box.max.x = math.max(box1.max.x, box2.max.x)
    box.max.y = math.max(box1.max.y, box2.max.y)
    box.max.z = math.max(box1.max.z, box2.max.z)
    return box
end

function p.can_boxes_be_merged(box1, box2)
    --The logic here is humorous.
    if not p.boxes_are_disjoint(box1, box2) then return false end
    local box3 = p.get_hull_of_boxes(box1, box2)
    local vol1 = p.get_box_volume(box1)
    local vol2 = p.get_box_volume(box2)
    local vol3 = p.get_box_volume(box3)
    return ( vol1 + vol2 == vol3 )
end

function p.dump_box(box)
    ga_print("Box: " .. std.vec_to_str(box.min) .. " to " .. std.vec_to_str(box.max))
end

-------------------------------------------------
--                  Helpers
-------------------------------------------------

function p.add_box(boxes, box1)
    --Slow.  Would need to do work to make it faster.
    for box2, v in pairs(boxes) do
        local can_merge = p.can_boxes_be_merged(box1, box2)
        if can_merge then
            local box_merged = p.get_hull_of_boxes(box1, box2)
            p.remove_box(boxes, box2)
            p.add_box(boxes, box_merged)
            return
        end
    end
    --box1 cannot be merged with any existing box.
    --Adding box1 to the data structure.
    boxes[box1] = true
end

function p.remove_box(boxes, box)
    boxes[box] = nil
end

-------------------------------------------------
--                    API
-------------------------------------------------

--Silly function.
function p.init_boxes(boxes)
    boxes = {}
end

function p.add_cube(boxes, bp)
    local box = p.create_cube(bp)
    p.add_box(boxes, box)
end

--This turns the position into a 1x1x1 box
--and does NOT merge it.
function p.add_cube_debug(boxes, bp)
    local box = p.create_cube(bp)
    ga_print("game_merge_endgine.add_cube_debug: " .. std.bp_to_str(bp))
    ga_print( p.box_to_str(box) )
    boxes[box] = true
end

--To do: write this function!!!
function p.remove_cube(boxes, bp)
    -- ga_print("game_merge_engine.remove_cube")
    -- local found_one = false
    -- local found_box
    -- for k, v in pairs(cubes) do
    --     if( p.box_contains_cube(k, bp) ) then
    --         found_one = true
    --         found_box = k
    --         break
    --     end
    -- end
    -- --more!!!
end

function p.dump_boxes(boxes)
    ga_print("Dumping boxes:")
    for box, _ in pairs(boxes) do
        p.dump_box(box)
    end
end
