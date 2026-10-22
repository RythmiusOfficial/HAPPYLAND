function p.enabled()
    --Old way.
    -- return ga_genesis() --Deprecate!!!

     --New way.
    return ga_get_b("worldgen.state.genesis")
end
