--File: game_music_by_path.lua

--This script maps block types to playlist names.
--I reserve the right to change this mapping.

-- function p.
-- function p.verify_playlists_exist()

function p.__load_game()
    ga_debug_push("game_music_by_path.__load")
    p.init_maybe()
    ga_debug_pop("game_music_by_path.__load")
end

--Local data structures.
local initialized = false
p.chunk_bt_to_playlist = {} --These play music when you are "in their chunk".
p.kilo_bt_to_playlist = {}  --These play music when you are "in their kilo chunk".

function p.add_kilo(bt, playlist)
    p.kilo_bt_to_playlist[bt] = playlist
end

function p.remove_kilo(bt)
    p.kilo_bt_to_playlist[bt] = nil
end

function p.add_chunk(bt, playlist)
    p.chunk_bt_to_playlist[bt] = playlist
    p.add_kilo(bt, playlist)
end

function p.remove_chunk(bt)
    p.chunk_bt_to_playlist[bt] = nil
    p.remove_kilo(bt, playlist)
end

function p.add(bt, playlist)
    p.add_kilo(bt, playlist)
end

function p.remove(bt, playlist)
    p.remove_kilo(bt, playlist)
end

--Getting the playlist that is specified
--by the path of the player.
function p.get_cur_playlist()
    p.init_maybe();

    local player_level = ga_get_viewer_level()
    local level = player_level
    while(level >= 0) do
        local bt = ga_get_cocoon_block_of_chunk(level, std.bp(0,0,0))

        if( level == player_level ) then
            --For chunks at the same level of the player,
            --to play a playlist, they have to be in the
            --chunk_bt_to_playlist table.
            local new_playlist_name = p.chunk_bt_to_playlist[bt]
            if( new_playlist_name ~= nil ) then
                return new_playlist_name
            end
        else
            local new_playlist_name = p.kilo_bt_to_playlist[bt]
            if( new_playlist_name ~= nil ) then
                return new_playlist_name
            end
        end
        level = level - 1
    end
end

function p.init_maybe()
    if( initialized ) then return end
    initialized = true

    p.init_maybe_helper() --The hard work.
    p.verify_playlists_exist()
end

function p.init_maybe_helper()
    -------------------------------------------
    -- Happy Land

    p.add("block_happy_land_0",				"hl_happy_land")
    p.add("block_tall_grass_apartment",                 "hl_tall_grass_apartment")
    p.add("block_happy_exit_cube_air_part",		"hl_exit_cube_part_dungeon")
end

-------------------------------------------------------------------------------
--                   Verifying that the package has playlists
-------------------------------------------------------------------------------

function p.verify_playlists_exist()
    local print_errors_to_console = ga_get_b("xar.sound.print_broken_playlist_errs_to_console")
    local print_errors_to_stdout  = ga_get_b("xar.sound.print_broken_playlist_errs_to_stdout")

    if( not print_errors_to_console and
        not print_errors_to_stdout )
    then
        return
    end

    --Getting all playlists.
    --The playlists are the keys.
    local all_playlists = {}
    for k,v in pairs(p.chunk_bt_to_playlist) do
        all_playlists[v] = true
    end
    for k,v in pairs(p.kilo_bt_to_playlist) do
        all_playlists[v] = true
    end

    --Sorting the playlists into an array.
    local all_playlists_array = {}
    for k in pairs(all_playlists) do
        table.insert(all_playlists_array, k)
    end
    table.sort(all_playlists_array)

    --Checking each playlist.
    for _,playlist in pairs(all_playlists_array) do
        local exists = ga_playlist_exists(playlist)
        if( not exists ) then
            local msg = "Xar music playlist not found: " .. playlist
            if( print_errors_to_console ) then
                ga_console_print("^1" .. msg)
            end
            if( print_errors_to_stdout ) then
                ga_print("*** Warning: " .. msg)
            end
        end
    end
end
