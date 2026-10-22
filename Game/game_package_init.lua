function p.init()
    --Initializing package vars, if they have not been already.
    --These vars live with the package in Data/PackageState,
    --NOT with the players saved game in Data/Save.
    --
    --These package init functions will create the vars
    --and set them the given values.
    --If one of the vars already exists, its value is NOT changed.

    ga_package_init_b("inf2.can_build_block_into_player", true)
end
