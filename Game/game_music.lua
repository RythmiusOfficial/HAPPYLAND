--Should be called several times per second.
function p.play_music_maybe()
    local playlist = ""

    local playlist_for_path = game_music_by_path.get_cur_playlist()
    playlist = playlist_for_path

    --At this point, we could see if it was registered
    --that there was a rat monster nearby, in which case
    --we could set playlist to a scary song!!!
    --Feel free to mod this!!!

    if ga_get_b("xar.credits.in") then
        --Could be more systematic.
        --Letting the credits play its music.
    elseif playlist ~= nil then
        --Telling the engine to play this playlist.
        --If it is already playing it, it keeps going.
        ga_play_playlist(playlist)
    end
end
