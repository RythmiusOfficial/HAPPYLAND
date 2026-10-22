--This will eventually replace the pathpink function
--that is hardcoded into the engine.

--This is called by the engine when the game is loaded.
function p.__load_game()
    local cmd_name = "pathpink" --CHANGE NAME TO "pathpink"!!!
    game_command_system.add_command(cmd_name, p.handler)
    game_command_system.add_help(cmd_name, p.get_help_str())
end

function p.handler(str)
    ga_debug_push("game_cmd_pathpink")

    local viewer_level = ga_get_viewer_level()
    local viewer_bp = ga_get_viewer_bp(viewer_level)
    local viewer_chunk_id = ga_get_viewer_chunk_id()
    local pink_level = game_base_tele_pink.get_pink_dest_level(viewer_chunk_id)
    local blue_level = game_base_tele_blue.get_blue_dest_top_level(viewer_chunk_id)

    local lines = {}

    local cur_chunk_id = ga_get_viewer_chunk_id()
    while( cur_chunk_id >= 0 ) do
        local cur_level = ga_chunk_id_to_level(cur_chunk_id)
        local cur_vcp = ga_chunk_id_to_vcp(cur_chunk_id)
        local bt = ga_get_cocoon_block_of_chunk(cur_level, cur_vcp)
        --
        if bt:find("^XAR_") then
            bt = string.sub(bt, 5) --Removing the "XAR_".
        end
        --
        local is_pink = (cur_level == pink_level)
        local is_blue = (cur_level == blue_level)
        --
        --Printing to the console.
        local colored_line = ""
        if( is_pink and is_blue ) then
            colored_line = "^xff00ff" .. bt .. "^x0000ff <--- ALSO BLUE^!";
        elseif( is_pink ) then
            colored_line = "^xff00ff" .. bt
        elseif( is_blue ) then
            colored_line = "^x0000ff" .. bt
        else
            colored_line = bt
        end
        lines[#lines+1] = colored_line
        -- ga_console_print(colored_line)
        --
        local parent_chunk_id = ga_chunk_id_to_parent_chunk_id(cur_chunk_id)
        cur_chunk_id = parent_chunk_id
    end

    local num_lines = #lines
    for i = num_lines,1,-1 do
        local colored_line = lines[i]
        ga_console_print(colored_line)
    end

    ga_debug_pop("game_cmd_pathpink")
end

function p.get_help_str()
    return "Usage: pathpink\n\n"
        .. "The command \"pathpink\" prints the name of\n"
        .. "the chunks containing the viewer, with two modifications.\n\n"
        .. "First: if you were to use Pink Rings,\n"
        .. "the chunk you would be \n"
        .. "teleported to is displayed in pink.\n\n"
        .. "Second: if you were to use Blue Rings, "
        .. "you would be teleported\n"
        .. "towards the root of the tree to a \"Top Chunk\", at which\n"
        .. "point you will be teleported down.\n"
        .. "The Top Chunk is displayed in blue.";
end
