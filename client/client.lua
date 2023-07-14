
mainCam = 0
avb = true

function PC(cam)
    Wait(0)
    rotx, roty, rotz = table.unpack(GetEntityRotation(PlayerPedId()))
    camX, camY, camZ = table.unpack(GetGameplayCamCoord())
    local camRX, camRY, camRZ = GetGameplayCamRelativePitch(), 0.0, GetGameplayCamRelativeHeading()
    local camF = GetGameplayCamFov()
    local camRZ = (rotz+camRZ)
    local head = GetPedBoneCoords(PlayerPedId(),31086)
    local fv = GetEntityForwardVector(PlayerPedId()) * 0.2
    SetCamCoord(cam, head.x + fv.x, head.y + fv.y, head.z + fv.z)
    PointCamAtCoord(cam, head.x + fv.x * 2, head.y + fv.y * 2, head.z + fv.z)
    SetCamRot(cam, camRX, camRY, camRZ)
    SetCamFov(cam, camF)
    SetFollowPedCamViewMode(4) -- making sure other wise its weird and glitchy
    Wait(2000)
    SetFollowPedCamViewMode(4) -- making sure other wise its weird and glitchy
    DestroyCam(mainCam)
    SetFollowPedCamViewMode(4) -- making sure other wise its weird and glitchy
    Wait(100)
    RenderScriptCams(false, 1, 0,  false,  false)
end



CreateThread(function()
    while true do
        Wait(0)
        if GetFollowPedCamViewMode() == 2 then 
        DisableControlAction(1, 0, true)
        end
            if avb then
                if IsDisabledControlJustPressed(1,0) and avb then 
                    if GetFollowPedCamViewMode() == 2 and avb then 
                        avb = false 
                        fpcma()
                    end
                if not avb then 
                    Wait(100)
                    avb = true
                end
            end
        end
    end
end)

function fpcma()
    mainCam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    RenderScriptCams(true, 1, Config.TransTime,  true,  true)
    PC(mainCam)
end

