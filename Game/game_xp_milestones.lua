--If you are reading this, then I know you can write prettier code than this.
function p.milestone_str(level)
    if( level == 10 ) then return "20 Health Regen Upgrades" end
    if( level == 20 ) then return "20 Health Max Upgrades" end
    if( level == 30 ) then return "Laser Max Ammo Upgrade" end
    if( level == 40 ) then return "20 Cannon Damage + 8 Cannon Num Shots Upgrades" end
    if( level == 50 ) then return "Plasma Fire Rate Upgrade" end
    if( level == 60 ) then return "10 Above 100% Health Regen Upgrades" end
    if( level == 70 ) then return "Rocket Fire Rate Upgrade" end
    if( level == 80 ) then return "Laser Super Damage Upgrade" end
    if( level == 90 ) then return "Armor Regen Upgrade" end
    if( level == 100 ) then return "Minigun Super Damage Upgrade" end
    --
    if( level == 110 ) then return "20 Rail Damage Upgrades" end
    if( level == 120 ) then return "Laser Super Damage Upgrade" end
    if( level == 130 ) then return "5 EMP Radius + 5 EMP Free Time Upgrades" end
    if( level == 140 ) then return "20 Nuke Projectile Speed Upgrades" end
    if( level == 150 ) then return "Laser Max Ammo Upgrade" end
    if( level == 160 ) then return "Laser Super Damage Upgrade" end
    if( level == 170 ) then return "Armor Regen Upgrade" end
    if( level == 180 ) then return "Rocket Fire Rate Upgrade" end
    if( level == 190 ) then return "Plasma Fire Rate Upgrade" end
    if( level == 200 ) then return "Minigun Super Damage + Laser Super Damage Upgrade" end
    --
    if( level == 210 ) then return "20 Rocket Damage Upgrades" end
    if( level == 220 ) then return "20 Laser Damage Upgrades" end
    if( level == 230 ) then return "20 Homing Max Ammo Upgrades" end
    if( level == 240 ) then return "Laser Super Damage Upgrade" end
    if( level == 250 ) then return "Laser Max Ammo Upgrade" end
    if( level == 260 ) then return "20 Minigun Damage Upgrades" end
    if( level == 270 ) then return "Rocket Fire Rate Upgrade" end
    if( level == 280 ) then return "Laser Super Damage Upgrade" end
    if( level == 290 ) then return "Plasma Fire Rate Upgrade" end
    if( level == 300 ) then return "Minigun Super Damage Upgrade" end
    --
    if( level == 310 ) then return "Armor Regen Upgrade" end
    if( level == 320 ) then return "Laser Super Damage Upgrade" end
    if( level == 330 ) then return "20 Nuke Damage Upgrades" end
    if( level == 340 ) then return "20 Dark Hole Damage Upgrades" end
    if( level == 350 ) then return "Laser Max Ammo Upgrade" end
    if( level == 360 ) then return "Laser Super Damage Upgrade" end
    if( level == 370 ) then return "20 Cannon Damage Upgrades" end
    if( level == 380 ) then return "20 Rocket Damage Upgrades" end
    if( level == 390 ) then return "20 Homing Rocket Damage Upgrades" end
    if( level == 400 ) then return "Minigun Super Damage + Laser Super Damage Upgrades" end
    --
    if( level == 410 ) then return "5 EMP Radius + 5 EMP Freeze Time Upgrades" end
    if( level == 420 ) then return "20 Homing Max Ammo Upgrades" end
    if( level == 430 ) then return "Armor Regen Upgrade" end
    if( level == 440 ) then return "Laser Super Damage Upgrade" end
    if( level == 450 ) then return "Laser Max Ammo Upgrade" end
    if( level == 460 ) then return "Rocket Fire Rate Upgrade" end
    if( level == 470 ) then return "Plasma Fire Rate Upgrade" end
    if( level == 480 ) then return "Laser Super Damage Upgrade" end
    if( level == 490 ) then return "20 EMP Damage Upgrades" end
    if( level == 500 ) then return "Minigun Super Damage Upgrade" end
    --
    -- if( level > 500 ) then
    --     local cent = math.floor(level / 100)
    --     local rem = level % 100
    --     --
    --     if( rem == 10 ) then
    --         local damage = cent * 20
    --         local cap = cent * 20
    --         -- fire_rate = 1
    --         return
    --             tostring(damage) .. " Plasma Damge + "
    --             .. tostring(cap) .. " Plasma Max Ammo"
    --             -- .. tostring(fire_rate) .. " Plasma Fire Rate Upgrades"
    --     end
    --     if( rem == 20 ) then
    --         local damage = cent * 20
    --         local cap = cent * 20
    --         return
    --             tostring(damage) .. " Cannon Damge + "
    --             .. tostring(cap) .. " Cannon Max Ammo Upgrades"
    --     end
    --     if( rem == 30 ) then
    --         local damage = cent * 20
    --         local cap = cent + 1
    --         local super = 2
    --         return
    --             tostring(damage) .. " Laser Damge + "
    --             .. tostring(cap) .. " Laser Max Ammo + "
    --             .. tostring(super) .. " Laser Super Damage Upgrades"
    --     end
    --     if( rem == 40 ) then
    --         local damage = cent * 20
    --         local cap = cent * 3
    --         local proj_speed = cent * 20
    --         return
    --             tostring(damage) .. " Rocket Damge + "
    --             .. tostring(cap) .. " Rocket Max Ammo + "
    --             .. tostring(proj_speed) .. " Rocket Projectile Speed Upgrades"
    --     end
    --     if( rem == 50 ) then
    --         local damage = cent * 20
    --         local cap = cent * 5
    --         return
    --             tostring(damage) .. " Homing Damge + "
    --             .. tostring(cap) .. " Homing Max Ammo Upgrades"
    --     end
    --     if( rem == 60 ) then
    --         local damage = cent * 20
    --         local cap = cent * 2
    --         local proj_speed = 10
    --         return
    --             tostring(damage) .. " Minigun Damge + "
    --             .. tostring(cap) .. " Minigun Max Ammo + "
    --             .. tostring(proj_speed) .. " Minigun Projectile Speed Upgrades"
    --     end
    --     if( rem == 70 ) then
    --         local damage = cent * 20
    --         local cap = cent * 2
    --         return
    --             tostring(damage) .. " Railgun Damge + "
    --             .. tostring(cap) .. " Railgun Max Ammo Upgrades"
    --     end
    --     if( rem == 80 ) then
    --         local damage = cent * 20
    --         local cap = cent
    --         local radius = cent * 5
    --         local freeze = cent * 10
    --         return
    --             tostring(damage) .. " EMP Damge + "
    --             .. tostring(cap) .. " EMP Max Ammo + "
    --             .. tostring(radius) .. " EMP Radius + "
    --             .. tostring(freeze) .. " EMP Freeze Time Upgrades"
    --     end
    --     if( rem == 90 ) then
    --         local damage = cent * 20
    --         local cap = cent
    --         local radius = cent * 3
    --         local proj_speed = cent * 20
    --         return
    --             tostring(damage) .. " Nuke Damge + "
    --             .. tostring(cap) .. " Nuke Max Ammo + "
    --             .. tostring(radius) .. " Nuke Radius + "
    --             .. tostring(proj_speed) .. " Nuke Projectile Speed Upgrades"
    --     end
    --     if( rem == 0 ) then
    --         local damage = cent * 20
    --         local cap = cent
    --         local proj_speed = cent * 10
    --         return
    --             tostring(damage) .. " Hole Damge + "
    --             .. tostring(cap) .. " Hole Max Ammo + "
    --             .. tostring(proj_speed) .. " Hole Projectile Speed Upgrades"
    --     end
    -- end
    return ""
end

--Returns true iff actually claimed the milestone.
function p.claim_milestone(level)
    if( level == 10 ) then
       for i = 1,20 do
           game_upgrades.health_regen()
       end
       return true
    end
    if( level == 20 ) then
        for i = 1,20 do
            game_upgrades.health_max()
        end
        return true
    end
    if( level == 30 ) then
        game_upgrades.laser_max_ammo()
        return true
    end
    if( level == 40 ) then
        for i = 1,20 do
            game_upgrades.cannon_damage();
        end
        for i = 1,8 do
            game_upgrades.cannon_num()
        end
        return true
    end
    if( level == 50 ) then
        game_upgrades.plasma_fire_rate()
        return true
    end
    if( level == 60 ) then
        for i = 1,10 do
            game_upgrades.spice()
        end
        return true
    end
    if( level == 70 ) then
        game_upgrades.rocket_fire_rate()
        return true
    end
    if( level == 80 ) then
        game_upgrades.laser_super()
        return true
    end
    if( level == 90 ) then
        game_upgrades.armor_regen()
        return true
    end
    if( level == 100 ) then
        game_upgrades.minigun_super()
        return true
    end
    if( level == 110 ) then
        for i = 1,20 do
            game_upgrades.railgun_damage()
        end
        return true
    end
    if( level == 120 ) then
        game_upgrades.laser_super()
        return true
    end
    if( level == 130 ) then
        for i = 1,5 do
            game_upgrades.emp_radius()
            game_upgrades.emp_freeze_time()
        end
        return true
    end
    if( level == 140 ) then
        for i = 1,20 do
            game_upgrades.nuke_proj_speed()
        end
        return true
    end
    if( level == 150 ) then
        game_upgrades.laser_max_ammo()
        return true
    end
    if( level == 160 ) then
        game_upgrades.laser_super()
        return true
    end
    if( level == 170 ) then
        game_upgrades.armor_regen()
        return true
    end
    if( level == 180 ) then
        game_upgrades.rocket_fire_rate()
        return true
    end
    if( level == 190 ) then
        game_upgrades.plasma_fire_rate()
        return true
    end
    if( level == 200 ) then
        game_upgrades.minigun_super()
        game_upgrades.laser_super()
        return true
    end
    if( level == 210 ) then
        for i = 1,20 do
            game_upgrades.rocket_damage()
        end
        return true
    end
    if( level == 220 ) then
        for i = 1,20 do
            game_upgrades.laser_damage()
        end
        return true
    end
    if( level == 230 ) then
        for i = 1,20 do
            game_upgrades.homing_max_ammo()
        end
        return true
    end
    if( level == 240 ) then
        game_upgrades.laser_super()
        return true
    end
    if( level == 250 ) then
        game_upgrades.laser_max_ammo()
        return true
    end
    if( level == 260 ) then
        for i = 1,20 do
            game_upgrades.minigun_damage()
        end
        return true
    end
    if( level == 270 ) then
        game_upgrades.rocket_fire_rate()
        return true
    end
    if( level == 280 ) then
        game_upgrades.laser_super()
        return true
    end
    if( level == 290 ) then
        game_upgrades.plasma_fire_rate()
        return true
    end
    if( level == 300 ) then
        game_upgrades.minigun_super()
        return true
    end
    if( level == 310 ) then
        game_upgrades.armor_regen()
        return true
    end
    if( level == 320 ) then
        game_upgrades.laser_super()
        return true
    end
    if( level == 330 ) then
        for i = 1,20 do
            game_upgrades.nuke_damage()
        end
        return true
    end
    if( level == 340 ) then
        for i = 1,20 do
            game_upgrades.dark_hole_damage()
        end
        return true
    end
    if( level == 350 ) then
        game_upgrades.laser_max_ammo()
        return true
    end
    if( level == 360 ) then
        game_upgrades.laser_super()
        return true
    end
    if( level == 370 ) then
        for i = 1,20 do
            game_upgrades.cannon_damage()
        end
        return true
    end
    if( level == 380 ) then
        for i = 1,20 do
            game_upgrades.rocket_damage()
        end
        return true
    end
    if( level == 390 ) then
        for i = 1,20 do
            game_upgrades.homing_damage()
        end
        return true
    end
    if( level == 400 ) then
        game_upgrades.minigun_super()
        game_upgrades.laser_super()
        return true
    end
    if( level == 410 ) then
        for i = 1,5 do
            game_upgrades.emp_radius()
            game_upgrades.emp_freeze_time()
        end
        return true
    end
    if( level == 420 ) then
        for i = 1,20 do
            game_upgrades.homing_max_ammo()
        end
        return true
    end
    if( level == 430 ) then
        game_upgrades.armor_regen()
        return true
    end
    if( level == 440 ) then
        game_upgrades.laser_super()
        return true
    end
    if( level == 450 ) then
        game_upgrades.laser_max_ammo()
        return true
    end
    if( level == 460 ) then
        game_upgrades.rocket_fire_rate()
        return true
    end
    if( level == 470 ) then
        game_upgrades.plasma_fire_rate()
        return true
    end
    if( level == 480 ) then
        game_upgrades.laser_super()
        return true
    end
    if( level == 490 ) then
        for i = 1,20 do
            game_upgrades.emp_damage()
        end
        return true
    end
    if( level == 500 ) then
        game_upgrades.minigun_super()
        return true
    end
    -- if( level > 500 ) then
    --     local cent = math.floor(level / 100)
    --     local rem = level % 100
    --     --
    --     if( rem == 10 ) then
    --         local damage = cent * 20
    --         local cap = cent * 20
    --         for i = 1,cap do
    --             game_upgrades.plasma_max_ammo()
    --         end
    --         for i = 1,damage do
    --             game_upgrades.plasma_damage()
    --         end
    --         return true
    --     end
    --     if( rem == 20 ) then
    --         local damage = cent * 20
    --         local cap = cent * 20
    --         for i = 1,cap do
    --             game_upgrades.cannon_max_ammo()
    --         end
    --         for i = 1,damage do
    --             game_upgrades.cannon_damage()
    --         end
    --         return true
    --     end
    --     if( rem == 30 ) then
    --         local damage = cent * 20
    --         local cap = cent + 1
    --         local super = 2
    --         for i = 1,cap do
    --             game_upgrades.laser_max_ammo()
    --         end
    --         for i = 1,damage do
    --             game_upgrades.laser_damage()
    --         end
    --         for i = 1,super do
    --             game_upgrades.laser_super()
    --         end
    --         return true
    --     end
    --     if( rem == 40 ) then
    --         local damage = cent * 20
    --         local cap = cent * 3
    --         local proj_speed = cent * 20
    --         for i = 1,cap do
    --             game_upgrades.rocket_max_ammo()
    --         end
    --         for i = 1,damage do
    --             game_upgrades.rocket_damage()
    --         end
    --         for i = 1,proj_speed do
    --             game_upgrades.rocket_proj_speed()
    --         end
    --         return true
    --     end
    --     if( rem == 50 ) then
    --         local damage = cent * 20
    --         local cap = cent * 5
    --         for i = 1,cap do
    --             game_upgrades.homing_max_ammo()
    --         end
    --         for i = 1,damage do
    --             game_upgrades.homing_damage()
    --         end
    --         return true
    --     end
    --     if( rem == 60 ) then
    --         local damage = cent * 20
    --         local cap = cent * 2 --A lot less.
    --         local proj_speed = 10
    --         for i = 1,cap do
    --             game_upgrades.minigun_max_ammo()
    --         end
    --         for i = 1,damage do
    --             game_upgrades.minigun_damage()
    --         end
    --         for i = 1,proj_speed do
    --             game_upgrades.minigun_proj_speed()
    --         end
    --         return true
    --     end
    --     if( rem == 70 ) then
    --         local damage = cent * 20
    --         local cap = cent * 2 --A lot less.
    --         for i = 1,cap do
    --             game_upgrades.railgun_max_ammo()
    --         end
    --         for i = 1,damage do
    --             game_upgrades.railgun_damage()
    --         end
    --         return true
    --     end
    --     if( rem == 80 ) then
    --         local damage = cent * 20
    --         local cap = cent
    --         local radius = cent * 5
    --         local freeze = cent * 10
    --         for i = 1,cap do
    --             game_upgrades.emp_max_ammo()
    --         end
    --         for i = 1,damage do
    --             game_upgrades.emp_damage()
    --         end
    --         for i = 1,radius do
    --             game_upgrades.emp_radius()
    --         end
    --         for i = 1,freeze do
    --             game_upgrades.emp_freeze_time()
    --         end
    --         return true
    --     end
    --     if( rem == 90 ) then
    --         local damage = cent * 20
    --         local cap = cent --A lot less.
    --         local radius = cent * 3 --A bit less.
    --         local proj_speed = cent * 20
    --         for i = 1,cap do
    --             game_upgrades.nuke_max_ammo()
    --         end
    --         for i = 1,damage do
    --             game_upgrades.nuke_damage()
    --         end
    --         for i = 1,radius do
    --             game_upgrades.nuke_radius()
    --         end
    --         for i = 1,proj_speed do
    --             game_upgrades.nuke_proj_speed()
    --         end
    --         return true
    --     end
    --     if( rem == 0 ) then
    --         local damage = cent * 20
    --         local cap = cent --A lot less.
    --         local proj_speed = cent * 10
    --         for i = 1,cap do
    --             game_upgrades.dark_hole_max_ammo()
    --         end
    --         for i = 1,damage do
    --             game_upgrades.dark_hole_damage()
    --         end
    --         for i = 1,proj_speed do
    --             game_upgrades.dark_hole_proj_speed()
    --         end
    --         return true
    --     end
    -- end
    return false
end
