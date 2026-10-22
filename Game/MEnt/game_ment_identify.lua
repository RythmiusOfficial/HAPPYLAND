function p.get_id()
    local id = ga_get_i("temp.identify_ment")
    return id
end

function p.maybe(inst_id)
    --New way.
    ga_create_i("temp.identify_ment")
    ga_set_i("temp.identify_ment", inst_id)
end

function p.has_health()
    if( not ga_exists("temp.identify_ment") ) then return false end
    local id = ga_get_i("temp.identify_ment")
    if( not ga_ment_exists(id) ) then return false end
    local ment_type = ga_ment_get_type(id)
    if( not game_ment_health.get_ment_has_health(id) ) then return false end
    return true
end

function p.get_str()
    local id = p.get_id()
    if( id < 0 ) then return "" end
    local ment_type = ga_ment_get_type(id)
    if( ga_ment_type_var_exists(ment_type, "identity_str") ) then
        return ga_ment_get_s(id, "identity_str")
    end
    return ""
end

function p.get_health()
    local id = p.get_id()
    if( id < 0 ) then return 0 end
    local ment_type = ga_ment_get_type(id)
    if( not game_ment_health.get_ment_has_health(id) ) then return 0 end
    local health = game_ment_health.get_ment_health(id)
    return health
end

function p.get_max_health()
    local id = p.get_id()
    if( id < 0 ) then return 0 end
    local ment_type = ga_ment_get_type(id)
    if( not game_ment_health.get_ment_has_health(id) ) then
        return 0
    end
    return game_ment_health.get_ment_max_health(id)
end
