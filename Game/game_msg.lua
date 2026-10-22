--Adding a message to the screen lower left message list.
function p.add(txt)
    --If you are reading this, then I know you can write prettier code than this.

    ga_set_s("xar.messages.slot5.msg", ga_get_s("xar.messages.slot4.msg"))
    ga_set_f("xar.messages.slot5.ttl", ga_get_f("xar.messages.slot4.ttl"))

    ga_set_s("xar.messages.slot4.msg", ga_get_s("xar.messages.slot3.msg"))
    ga_set_f("xar.messages.slot4.ttl", ga_get_f("xar.messages.slot3.ttl"))

    ga_set_s("xar.messages.slot3.msg", ga_get_s("xar.messages.slot2.msg"))
    ga_set_f("xar.messages.slot3.ttl", ga_get_f("xar.messages.slot2.ttl"))

    ga_set_s("xar.messages.slot2.msg", ga_get_s("xar.messages.slot1.msg"))
    ga_set_f("xar.messages.slot2.ttl", ga_get_f("xar.messages.slot1.ttl"))

    ga_set_s("xar.messages.slot1.msg", txt)
    local duration = 6.0
    ga_set_f("xar.messages.slot1.ttl", duration)
end
