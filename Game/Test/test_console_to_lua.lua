--Try opening the console and running
--the following command: execl test_console_to_lua.foo HELLO_WORLD

function p.foo(arg)
    ga_console_print("Here in test_console_to_lua.foo: arg = " .. arg)

    return arg
end
