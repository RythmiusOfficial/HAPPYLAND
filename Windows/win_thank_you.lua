--No no no!!!  You cannot read this!!!  It is secret!
--If you are reading this you are cheating!!!

function p.__render(wid)
    ga_win_set_background(wid, std.vec(0.0, 0.0, 0.0), 1.0)

    local e_diff_num = game_difficulty.easiest_num()
    local hardcore = ga_get_hardcore_mode()
    local msg = ""

    ga_win_set_char_size(wid, 0.015, 0.03)
    if( game_genesis.enabled() ) then
        --Genesis.
        --If you are reading this code you are cheating!
        msg = "^x00ff00Your friend K:\n\n"
            .. "Thank you for rescuing me from the Fractal Block World! "
            .. "It was either my curiosity or bad luck that got me in here "
            .. "in the first place. "
            .. "All the fractal stuff was mind bending.\n\n"
            .. "I use to fantasize about being lost in a strange "
            .. "world and then getting rescued by my friend. "
            .. "Now I know what it feels like for real. "
            .. "It feels awesome to be alive now."
    elseif( e_diff_num == -2 ) then
        --Tranquility mode.
        msg = "^x00ff00Your friend K:\n\n"
            .. "The world is a big place, "
            .. "and it was so easy for me to get lost in it. "
            .. "Thank you for rescuing me. "
            .. "I hope you found some intresting "
            .. "places in your journey!"
    elseif( e_diff_num == -1 ) then
        --Normal mode.
        if( hardcore ) then
            msg = "^x00ff00Your friend K:\n\n"
                .. "Thank you for saving me. "
                .. "You were very brave. "
                .. "You put your life in danger to rescue me. "
                .. "I will never forget it. "
        else
            msg = "^x00ff00Your friend K:\n\n"
                .. "Thank you for rescuing me!\n\n"
                .. "It was either my curiosity or bad luck that got me in here "
                .. "in the first place. "
                .. "I am lucky to have a someone like you in my life.\n\n"
                .. "I need a change of pace after being trapped in a quagmire. "
                .. "Want to do dinner and a show and take it from there? "
        end
    elseif( e_diff_num == 0 ) then
        --Gateway mode.
        if( hardcore ) then
            msg = "^x00ff00Your friend K:\n\n"
                .. "Thank you for saving me. "
                .. "It was scary in this fractal block nightmare. "
                .. "We should watch a movie. "
                .. "Since my nerves are still on edge, we should "
                .. "probably hold hands to play it safe. "
        else
            msg = "^x00ff00Your friend K:\n\n"
                .. "Thank you for rescuing me from the Fractal Block World! "
                .. "It was either my curiosity or bad luck that got me in here "
                .. "in the first place. "
                .. "It was scary with all the monsters. "
                .. "It pushed me nearly to my limits, "
                .. "but it was also very exciting.\n\n"
                .. "I use to fantasize about being trapped in a dire "
                .. "situation and then getting rescued by my friend. "
                .. "Now I know what it feels like for real. "
                .. "It feels awesome to be alive now.\n\n"
                .. "I need a change of pace. "
                .. "Want to do dinner and a show and take it from there? "
            --  .. "And maybe even I will play \"The Phantom of the Opera\" "
            --  .. "on the violin."
        end
    elseif( e_diff_num == 1 ) then
        --Quadmire mode.
        if( hardcore ) then
            msg = "^x00ff00Your friend K:\n\n"
                .. "Holy cow that was exciting! "
                .. "You are like some kind of boss to risk your life "
                .. "to save me in such a hostile place. "
                .. "How could you manage to stay alive for so long?\n\n"
                .. "Well, we have to party now. "
                .. "The normal lights are going down "
                .. "and the strands of christmas lights are "
                .. "going up on the ceiling. "
        else
            msg = "^x00ff00Your friend K:\n\n"
                .. "Wow, that was a rush!  I use to dream "
                .. "of being trapped in a scary world with hoards of monsters. "
                .. "When it ACTUALLY happens, the reality can feel not at all like "
                .. "the fantasy.\n\n"
                .. "But this adventure really hit the spot, and I am so grateful to "
                .. "you for saving me.  It's kinda romantic. "
                .. "Maybe we could explore the fractal block world some more. "
                .. "I PROMISE I won't lose my sanity and fall into a downward spiral. "
                .. "I have never been deep into the HELL area of the fractal block world. "
                .. "Should we explore that together? " --More to come in a later version of the game.
        end
    elseif( e_diff_num == 2 ) then
        --Agony mode.
        if( hardcore ) then
            msg = "^x00ff00Your friend K:\n\n"
                .. "Alright, how did you get past that hoad of monsters "
                .. "inside a hell flower without dying? "
                .. "How long have you been playing this game? "
        else
            msg = "^x00ff00Your friend K:\n\n"
                .. "Holy cow that was intense!  I want to repay you. Etc.\n\n"
                .. "I have an idea. Let's reverse roles. "
                .. "I know a way you can trap yourself even deeper into the fractal block world "
                .. "than I was trapped. Saving you would require finding an "
                .. "^xff00ffOmega Core^!^x00ff00, " --To be added in a future version of the game.
                .. "which exists deep inside reality. "
                .. "So you can just go ahead and trap yourself, "
                .. "and then I will kick open the doors of Hell with a "
                .. "souped up railgun and an EMP, and I will save you.\n\n"
                .. "Doesn't that sould like fun? I think so. "
                .. "And we won't have to advertise our little game. "
                .. "It will be our secret. "
        end
    elseif( e_diff_num == 3 ) then
        --Caustic utopia mode.
        if( hardcore ) then
            msg = "^x00ff00Your friend K:\n\n"
                .. "Nobody is supposed to play this game on this ultra "
                .. "hard difficulty, let alone also using the hardcore option. "
                .. "You are a sick person. "
        else
            msg = "^x00ff00Your friend K:\n\n"
                .. "Disclaimer: the game is not really playtested on this or higher "
                .. "difficulties, so it feels wrong to incentivize you to beat the game "
                .. "on one these modes with the reward of some saucy text from me.\n\n"
                .. "Just kidding! "
                .. "I discovered this place where you can buy outrageous costumes. "
                .. "I found one \"cat costume\" that is pretty great.  It has ears "
                .. "and a tail. "
                .. "It doesn't come with a collar exactly, but I have a cheap teal nylon one "
                .. "that does the trick. I also have a little bell "
                .. "I can put on the collar that constantly makes this annoying "
                .. "sound that I know is really going to irritate you. "
                .. "I can't wait to show it to you ^_^. "
        end
    elseif( e_diff_num == 4 ) then
        --Madness mode.
        if( hardcore ) then
            msg = "^x00ff00The Programmer:\n\n"
                .. "Wow. Just wow. How did you possibly beat this game "
                .. "on this difficulty without dying once. "
                .. "Well, I have a poem for you:\n\n"
                .. "There once was a gamer named insert name here\n"
                .. "who beat fractal block world without too much fear\n"
                .. "they thought normal mode was a bore\n"
                .. "and they preferred madness mode hardcore\n"
                .. "and if it was me who did it I would shed a tear. "
                --.. "and if it was me who did it I would have a beer. "
        else
            msg = "^x00ff00Your friend K:\n\n"
                .. "Thank you so much for rescuing me! "
                .. "Let's go out to our balcony and watch the stars. "
                .. "Maybe read some commented out game script code. "
                --.. "Let's light some standard candles "
                --.. "and turn off the lights. "
                --.. "Maybe watch the episode \"Ocean Deep\" of Planet Earth
                --.. "with the album \"Halfaxa\" by Grimes?"
        end
    end
    ga_win_txt_box(wid, msg, false)

    ga_win_set_front_color(wid, std.vec(1.0, 0.0, 1.0))
    ga_win_set_char_size(wid, 0.02, 0.04)
    ga_win_txt_center(wid, 0.1, "PRESS ENTER TO WIN THE GAME")
end

function p.__process_input(wid)
    if ga_win_key_pressed(wid, "ESC") then
        ga_window_pop()
        return
    end
    if ga_win_key_pressed(wid, "ENTER") then
        ga_window_pop()
        ga_window_push("win_credits")
        return
    end
end
