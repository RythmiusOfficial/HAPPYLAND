--Adding a message to the screen lower left message list.
function p.add(txt)
    ga_set_s("blank.messages.slot5.msg", ga_get_s("blank.messages.slot4.msg"))
    ga_set_f("blank.messages.slot5.ttl", ga_get_f("blank.messages.slot4.ttl"))

    ga_set_s("blank.messages.slot4.msg", ga_get_s("blank.messages.slot3.msg"))
    ga_set_f("blank.messages.slot4.ttl", ga_get_f("blank.messages.slot3.ttl"))

    ga_set_s("blank.messages.slot3.msg", ga_get_s("blank.messages.slot2.msg"))
    ga_set_f("blank.messages.slot3.ttl", ga_get_f("blank.messages.slot2.ttl"))

    ga_set_s("blank.messages.slot2.msg", ga_get_s("blank.messages.slot1.msg"))
    ga_set_f("blank.messages.slot2.ttl", ga_get_f("blank.messages.slot1.ttl"))

    ga_set_s("blank.messages.slot1.msg", txt)
    duration = 6.0
    ga_set_f("blank.messages.slot1.ttl", duration)
end

function p.update()
    elapsed_time = ga_get_sys_f("time.elapsed")
    
    std.set_bydelta_f("blank.messages.slot1.ttl", -elapsed_time)
    std.set_bydelta_f("blank.messages.slot2.ttl", -elapsed_time)
    std.set_bydelta_f("blank.messages.slot3.ttl", -elapsed_time)
    std.set_bydelta_f("blank.messages.slot4.ttl", -elapsed_time)
    std.set_bydelta_f("blank.messages.slot5.ttl", -elapsed_time)
end
