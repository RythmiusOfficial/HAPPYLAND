--This is called by the engine when the game is loaded.
function p.__load_game()
    local cmd_name = "debug1"
    game_command_system.add_command(cmd_name, p.handler)
    game_command_system.add_help(cmd_name, p.get_help_str())
end

function p.handler(str)
    ga_print("In game_cmd_debug1.lua:")

    -- ga_debug1() --May not be implemented by the engine.

    -- local var = "dyn.foo"
    -- ga_dyn_init_v(var, std.vec(0.1, 0.2, 0.3))
    -- local x1 = ga_dyn_get_v(var)
    -- ga_dyn_set_v_by_delta(var, std.vec(0.1,0.2,0.3))
    -- local x2 = ga_dyn_get_v(var)
    -- ga_print("x1 = " .. std.vec_to_str(x1))
    -- ga_print("x2 = " .. std.vec_to_str(x2))
    -- ga_exit()

    -- local look = std.vec(1.0, 1.0, 1.0)
    -- local up = std.vec(0.0, 0.0, 1.0)
    -- ga_camera_set_look(look, up)
end

function p.get_help_str()
    return
           "Usage: debug1\n\n"
        .. "This is used internally by the developer. "
end
