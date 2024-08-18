ESX = exports["es_extended"]:getSharedObject()

local Spawn = {
    ['Centre'] = {tp1 = vector3(-876.88,-438.03,39.9), tp2 = vector3(-876.88,-438.03,39.9)}
}

local Skin = {
    ["Tenue d'homme d'affaire"] = {
        Male = {
            tshirt_1 = 15, tshirt_2 = 0,
            torso_1 = 1, torso_2 = 1,
            arms = 0,
            chain_1 = 0, chain_2 = 0,
            pants_1 = 4, pants_2 = 2,
            bags_1 = 0, bags_2 = 0,
            shoes_1 = 8, shoes_2 = 11,
            helmet_1= -1, helmet_2 = 0,
            ears_1 = 0,     ears_2 = 0
        },
        Female = {
            tshirt_1 = 15, tshirt_2 = 0,
            torso_1 = 4, torso_2 = 0,
            arms = 0,
            chain_1 = 0, chain_2 = 0,
            pants_1 = 16, pants_2 = 4,
            bags_1 = 0, bags_2 = 0,
            shoes_1 = 15, shoes_2 = 0,
            helmet_1= -1, helmet_2 = 0,
            ears_1 = 2,     ears_2 = 0
        },
    }
}

local Valid = false
local Creator = {
    firstname = nil,
    lastname = nil,
    sexe = nil,
    age = nil,
    height = nil,
    starter = nil,
    spawn = nil,
    skinSpawn = nil,

    face = {
        index = 1,
        items = {},
    },
    
    sex = {
        index = 1,
        items = {"Homme", "Femme"}
    },
    
    hair_1 = {
        index = 1,
        items = {},
    },
    hair_color = {
        primary = { 1, 1 },
        secondary = { 1, 1 }
    },
    
    beard_1 = {
        index = 1,
        items = {},
    },
    beard_2 = {
        percentage = 1.0,
    },
    beard_3 = {
        primary = { 1, 1 },
        secondary = { 1, 1 }
    },
    
    skin = {
        index = 1,
        items = {}
    },
    
    makeup_1 = {
        index = 1,
        items = {},
    },
    makeup_2 = {
        percentage = 1.0,
    },
    makeup_3 = {
        primary = { 1, 1 },
        secondary = { 1, 1 },
        third = {1, 1}
    },
    
    lipstick_1 = {
        index = 1,
        items = {},
    },
    lipstick_2 = {
        percentage = 1.0,
    },
    lipstick_3 = {
        primary = { 1, 1 },
        secondary = { 1, 1 }
    },

}




local creamenu = false
local choisiHabit = false
local choisiStarter = false
local choisiSpawn = false

function OpenMenuCreator()
    local Charcreator = {}

    Charcreator.MainMenu = RageUI.CreateMenu(Config.TextNom, 'Création de Personnage')
    Charcreator.MainIdentity = RageUI.CreateSubMenu(Charcreator.MainMenu, Config.TextNom, 'Création de Personnage')
    Charcreator.MainSkin = RageUI.CreateSubMenu(Charcreator.MainMenu, Config.TextNom, 'Création de Personnage')
    Charcreator.MainChoose = RageUI.CreateSubMenu(Charcreator.MainSkin, Config.TextNom, 'Création de Personnage')
    Charcreator.MainStarter = RageUI.CreateSubMenu(Charcreator.MainMenu, Config.TextNom, 'Création de Personnage')
    Charcreator.MainSpawn = RageUI.CreateSubMenu(Charcreator.MainMenu, Config.TextNom, 'Création de Personnage')
    Charcreator.MainVetement = RageUI.CreateSubMenu(Charcreator.MainMenu, Config.TextNom, 'Création de Personnage')

    Charcreator.MainMenu:SetRectangleBanner(0, 0, 0, 0)
    Charcreator.MainIdentity:SetRectangleBanner(0, 0, 0, 0)
    Charcreator.MainSkin:SetRectangleBanner(0, 0, 0, 0)
    Charcreator.MainChoose:SetRectangleBanner(0, 0, 0, 0)
    Charcreator.MainStarter:SetRectangleBanner(0, 0, 0, 0)
    Charcreator.MainSpawn:SetRectangleBanner(0, 0, 0, 0)
    Charcreator.MainVetement:SetRectangleBanner(0, 0, 0, 0)

    GetComponents()
    
    Charcreator.MainSkin:AddInstructionButton({[1] = GetControlInstructionalButton(0, 44, 0), [2] = "Tournée à droite"})
    Charcreator.MainSkin:AddInstructionButton({[1] = GetControlInstructionalButton(0, 51, 0), [2] = "Tournée à gauche"})

    Charcreator.MainSkin.EnableMouse = true
    Charcreator.MainMenu.Closable = false

    Charcreator.MainMenu.Closed = function()
        DestroyCamCreator()
        creamenu = false
        RageUI.Visible(Charcreator.MainMenu, false)
    end

    if creamenu then
        creamenu = false
        else
            creamenu = true

    RageUI.Visible(Charcreator.MainMenu, true)
    CreateThread(function()
        while (creamenu) do
            Wait(0)

            RageUI.IsVisible(Charcreator.MainMenu, function()
                RageUI.Button("Crée son identité →", nil, {}, true, {}, Charcreator.MainIdentity)
                RageUI.Button("Crée son personnage →", nil, {}, true, {}, Charcreator.MainSkin)
                RageUI.Button("Choisir son pack de départ →", nil, {}, true, { }, Charcreator.MainStarter)
                RageUI.Button("Choisir son lieu d'atterisage →", nil, {}, true, {}, Charcreator.MainSpawn)
                RageUI.Button("Choisir ses vêtements →", nil, {}, true, {}, Charcreator.MainVetement)
                if not Valid and choisiHabit and choisiStarter and choisiSpawn and Creator.firstname ~= nil and Creator.lastname ~= nil and Creator.sexe ~= nil and Creator.age ~= nil and Creator.height ~= nil and Creator.starter ~= {} and Creator.spawn ~= {} then
                    RageUI.Button("Valider la création →", nil, {}, true, {
                        onSelected = function()
                            Valid = true
                        end
                    })
                else
                    RageUI.Button("Valider la création →", nil, {}, false, {})
                end
                if Valid then
                    RageUI.Button("Valider la création →", nil, {RightLabel = "Confirmation"}, true, {
                        RageUI.Info(Config.TextNom, {
                            'Prénom :', 'Nom :', 'Date de naissance :', 'Sexe :', 'Taille :', 
                            'Lieu atterisage :', 'Pack de départ :', 'Vêtement :'
                        }, {
                            ""..Creator.firstname.."", ""..Creator.lastname.."", 
                            ""..Creator.age.."", ""..Creator.sexe.."", 
                            ""..Creator.height.."", ""..Creator.spawn.."", 
                            Creator.starter.label.."", ""..Creator.skinSpawn..""
                        }),
                        onSelected = function()
                            -- Fade out l'écran
                            DoScreenFadeOut(3000)
                            Wait(3000)
                            
                            SetEntityCoords(PlayerPedId(), Spawn[Creator.spawn].tp1)
                            
                            RageUI.CloseAll()
                            FreezeEntityPosition(PlayerPedId(), false) 
                            DestroyCamCreator()
                            skinAnim(Spawn[Creator.spawn].tp2)
                            
                            TriggerServerEvent('flCore:CreatePlayer', Creator)
                            
                            DoScreenFadeIn(3000)
                            Wait(3000)
                            
                            for i = 1, #players do
                                local targetPed = GetPlayerPed(players[i])
                                if targetPed ~= playerPed then
                                    ResetEntityAlpha(targetPed) -- Restaurer la visibilité
                                end
                            end
                            
                            DisplayRadar(true)
                            ESX.ShowNotification(""..Config.TextNom.."\nBienvenue sur le serveur ! Bon jeu à toi")
                        end
                    })
                    
                end
            end)


            function getNilValue(value, valueType)
                if value == nil then
                    if valueType == 'string' then
                        return "Inconnu"
                    elseif valueType == 'number' then
                        return 0  
                    elseif valueType == 'boolean' then
                        return false
                    else
                        return nil
                    end
                else
                    return value
                end
            end
            
            RageUI.IsVisible(Charcreator.MainIdentity, function()
                RageUI.Info(""..Config.TextNom.."", 
                {
                    'Nom de famille :', 
                    'Prénom :', 
                    'Sexe :', 
                    'Date de naissance :', 
                    'Taille du personnage :'
                }, 
                {
                    getNilValue(Creator.lastname, 'string'), 
                    getNilValue(Creator.firstname, 'string'), 
                    getNilValue(Creator.sexe, 'string'), 
                    getNilValue(Creator.age, 'string'), 
                    getNilValue(Creator.height, 'string')
                })
            
                RageUI.Button('Nom du personnage', nil, {}, true, {
                    onSelected = function()
                        local lastname = lib.inputDialog('Indiquez le nom de votre personnage', {'Exemple : Carl'}) 
                        if lastname and lastname[1] then
                            Creator.lastname = lastname[1]
                        end
                    end
                })
                
                RageUI.Button('Prénom du personnage', nil, {}, true, {
                    onSelected = function()
                        local firstname = lib.inputDialog('Indiquez le prénom de votre personnage', {'Exemple : Josh'})
                        if firstname and firstname[1] then
                            Creator.firstname = firstname[1]
                        end
                    end
                })
                
                RageUI.Button('Sexe du personnage', nil, {}, true, {
                    onSelected = function()
                        local sexe = lib.inputDialog('Indiquez le sexe de votre personnage (H pour Homme, F pour Femme)', {'Exemple : H'})
                        if sexe and sexe[1] then
                            -- Vérification que le sexe est soit "H" soit "F"
                            local validSexes = {H = true, F = true}
                            if validSexes[sexe[1]:upper()] then
                                Creator.sexe = sexe[1]:upper()
                            else
                                ESX.ShowNotification("Sexe invalide. Utilisez 'H' pour Homme ou 'F' pour Femme.")
                            end
                        end
                    end
                })
                
                RageUI.Button('Date de naissance du personnage', nil, {}, true, {
                    onSelected = function()
                        local age = lib.inputDialog('Indiquez la date de naissance de votre personnage (format DD/MM/YYYY)', {'Exemple : 01/01/2000'})
                        if age and age[1] then
                            print("Date entrée : " .. age[1])
                
                            local day, month, year = age[1]:match("^(%d%d)/(%d%d)/(%d%d%d%d)$")
                            if day and month and year then
                                print("Jour : " .. day .. ", Mois : " .. month .. ", Année : " .. year)
                                day, month, year = tonumber(day), tonumber(month), tonumber(year)
                                if (month >= 1 and month <= 12) and (day >= 1 and day <= 31) and (year >= 1900 and year <= 2024) then
                                    Creator.age = age[1]
                                else
                                    ESX.ShowNotification("Date invalide. Assurez-vous que la date est correcte.")
                                end
                            else
                                ESX.ShowNotification("Format de date invalide. Utilisez le format DD/MM/YYYY.")
                            end
                        else
                            print("Aucune date n'a été entrée ou dialogue annulé")
                        end
                    end
                })
                
                RageUI.Button('Taille du personnage', nil, {}, true, {
                    onSelected = function()
                        local height = lib.inputDialog('Indiquez la taille de votre personnage en cm', {'Exemple : 165'})
                        if height and height[1] then
                            local h = tonumber(height[1])
                            if h and h >= 50 and h <= 250 then
                                Creator.height = height[1]
                            else
                                ESX.ShowNotification("Taille invalide. La taille doit être un nombre entre 50 et 250 cm.")
                            end
                        end
                    end
                })                
            
                RageUI.Button('~o~Retour à la création', nil, {}, true, {
                    onSelected = function()
                        RageUI.GoBack()
                    end
                })
            end)
            

            RageUI.IsVisible(Charcreator.MainSkin, function()
                Cam() 
            
                RageUI.List('Sexe', Creator.sex.items, Creator.sex.index, nil, {}, true, {
                    onListChange = function(Index)
                        Creator.sex.index = Index
                        local sexValue = Index - 1 
                        TriggerEvent("skinchanger:change", "sex", sexValue)
                    end,
                    onSelected = function(Index)
                        changeGender(Index)
                    end
                })
            


                
                RageUI.List('Visage', Creator.face.items, Creator.face.index, nil, {}, true, {
                    onListChange = function(Index)
                        Creator.face.index = Index;
                        TriggerEvent("skinchanger:change", "face", Index)
                    end
                })

                RageUI.List('Peau', Creator.skin.items, Creator.skin.index, nil, {}, true, {
                    onListChange = function(Index)
                        Creator.skin.index = Index;
                        TriggerEvent("skinchanger:change", "skin", Index)
                    end
                })                

                RageUI.List("Cheveux", Creator.hair_1.items, Creator.hair_1.index, nil, {}, true, {
                    onListChange = function(Index)
                        Creator.hair_1.index = Index;
                        TriggerEvent("skinchanger:change", "hair_1", Index)
                    end
                })
                
                RageUI.List('Barbe', Creator.beard_1.items, Creator.beard_1.index, nil, {}, true, {
                    onListChange = function(Index)
                        Creator.beard_1.index = Index;
                        TriggerEvent("skinchanger:change", "beard_1", Index)
                    end
                })

                RageUI.List('Maquillage', Creator.makeup_1.items, Creator.makeup_1.index, nil, {}, true, {
                    onListChange = function(Index)
                        Creator.makeup_1.index = Index;
                        TriggerEvent("skinchanger:change", "makeup_1", Creator.makeup_1.index)
                    end
                })

                RageUI.List('Rouge à levre', Creator.lipstick_1.items, Creator.lipstick_1.index, nil, {}, true, {
                    onListChange = function(Index)
                        Creator.lipstick_1.index = Index;
                        TriggerEvent("skinchanger:change", "lipstick_1", Creator.lipstick_1.index)
                    end
                })

                RageUI.Button('Finir sa création', nil, {
                    Color = {
                        HightLightColor = {148, 0, 0, 150},
                        BackgroundColor = {148, 0, 0, 150}
                    }
                }, true, {
                    onSelected = function()
                        RageUI.GoBack()
                    end
                })
            end, function()
                RageUI.ColourPanel("Couleur Cheveux", RageUI.PanelColour.HairCut, Creator.hair_color.primary[1], Creator.hair_color.primary[2], {
                    onColorChange = function(MinimumIndex, CurrentIndex)
                        Creator.hair_color.primary[1] = MinimumIndex
                        Creator.hair_color.primary[2] = CurrentIndex
                        TriggerEvent("skinchanger:change", "hair_color_1", Creator.hair_color.primary[2])
                    end
                }, 4)
                RageUI.ColourPanel("Couleur Cheveux 2", RageUI.PanelColour.HairCut, Creator.hair_color.secondary[1], Creator.hair_color.secondary[2], {
                    onColorChange = function(MinimumIndex, CurrentIndex)
                        Creator.hair_color.secondary[1] = MinimumIndex
                        Creator.hair_color.secondary[2] = CurrentIndex
                        TriggerEvent("skinchanger:change", "hair_color_2", Creator.hair_color.secondary[2])
                    end
                }, 4)

                

                RageUI.PercentagePanel(Creator.beard_2.percentage, 'Opacité', '0%', '100%', {
                    onProgressChange = function(Percentage)
                        Creator.beard_2.percentage = Percentage
                        TriggerEvent("skinchanger:change", "beard_2", Creator.beard_2.percentage * 10)
                    end
                }, 5);
                RageUI.ColourPanel("Couleur Barbe 1", RageUI.PanelColour.HairCut, Creator.beard_3.primary[1], Creator.beard_3.primary[2], {
                    onColorChange = function(MinimumIndex, CurrentIndex)
                        Creator.beard_3.primary[1] = MinimumIndex
                        Creator.beard_3.primary[2] = CurrentIndex
                        TriggerEvent("skinchanger:change", "beard_3", Creator.beard_3.primary[2])
                    end
                }, 5)
                RageUI.ColourPanel("Couleur Barbe 2", RageUI.PanelColour.HairCut, Creator.beard_3.secondary[1], Creator.beard_3.secondary[2], {
                    onColorChange = function(MinimumIndex, CurrentIndex)
                        Creator.beard_3.secondary[1] = MinimumIndex
                        Creator.beard_3.secondary[2] = CurrentIndex
                        TriggerEvent("skinchanger:change", "beard_4", Creator.beard_3.secondary[2])
                    end
                }, 5)

                

                RageUI.PercentagePanel(Creator.makeup_2.percentage, 'Opacité', '0%', '100%', {
                    onProgressChange = function(Percentage)
                        Creator.makeup_2.percentage = Percentage
                        TriggerEvent("skinchanger:change", "makeup_2", Creator.makeup_2.percentage * 10)
                    end
                }, 6);
                RageUI.ColourPanel("Couleur Maquillage 1", RageUI.PanelColour.HairCut, Creator.makeup_3.primary[1], Creator.makeup_3.primary[2], {
                    onColorChange = function(MinimumIndex, CurrentIndex)
                        Creator.makeup_3.primary[1] = MinimumIndex
                        Creator.makeup_3.primary[2] = CurrentIndex
                        TriggerEvent("skinchanger:change", "makeup_3", Creator.makeup_3.primary[2])
                    end
                }, 6)
                RageUI.ColourPanel("Couleur Maquillage 2", RageUI.PanelColour.HairCut, Creator.makeup_3.secondary[1], Creator.makeup_3.secondary[2], {
                    onColorChange = function(MinimumIndex, CurrentIndex)
                        Creator.makeup_3.secondary[1] = MinimumIndex
                        Creator.makeup_3.secondary[2] = CurrentIndex
                        TriggerEvent("skinchanger:change", "makeup_4", Creator.makeup_3.secondary[2])
                    end
                }, 6)
                RageUI.ColourPanel("Couleur Maquillage 3", RageUI.PanelColour.HairCut, Creator.makeup_3.third[1], Creator.makeup_3.third[2], {
                    onColorChange = function(MinimumIndex, CurrentIndex)
                        Creator.makeup_3.third[1] = MinimumIndex
                        Creator.makeup_3.third[2] = CurrentIndex
                        TriggerEvent("skinchanger:change", "makeup_4", Creator.makeup_3.third[2])
                    end
                }, 6)

                

                RageUI.PercentagePanel(Creator.lipstick_2.percentage, 'Opacité', '0%', '100%', {
                    onProgressChange = function(Percentage)
                        Creator.lipstick_2.percentage = Percentage
                        TriggerEvent("skinchanger:change", "lipstick_2", Creator.lipstick_2.percentage * 10)
                    end
                }, 7);
                RageUI.ColourPanel("Couleur Rouge à levre 1", RageUI.PanelColour.HairCut, Creator.lipstick_3.primary[1], Creator.lipstick_3.primary[2], {
                    onColorChange = function(MinimumIndex, CurrentIndex)
                        Creator.lipstick_3.primary[1] = MinimumIndex
                        Creator.lipstick_3.primary[2] = CurrentIndex
                        TriggerEvent("skinchanger:change", "lipstick_3", Creator.lipstick_3.primary[2])
                    end
                }, 7)
                RageUI.ColourPanel("Couleur Rouge à levre 2", RageUI.PanelColour.HairCut, Creator.lipstick_3.secondary[1], Creator.lipstick_3.secondary[2], {
                    onColorChange = function(MinimumIndex, CurrentIndex)
                        Creator.lipstick_3.secondary[1] = MinimumIndex
                        Creator.lipstick_3.secondary[2] = CurrentIndex
                        TriggerEvent("skinchanger:change", "lipstick_3", Creator.lipstick_3.secondary[2])
                    end
                }, 7)
            end)

            RageUI.IsVisible(Charcreator.MainStarter, function()
                RageUI.Button("Starter Pack n°1", nil, {}, true, {
                    onActive = function()
                        RageUI.Info('Starter Légal', {'Argent Liquide :', 'Argent Banque :', 'Object / Voiture :'}, {'100$', '250$', '5x Eau | 5x Pain / Panto'})
                    end,
                    onSelected = function()
                        Creator.starter = {name = "legal", label = "Légal"}
                        choisiStarter = true
                    end
                })
                RageUI.Button("Starter Pack n°2", nil, {}, true, {
                    onActive = function()
                        RageUI.Info('Starter Illégal', {'Argent Sale :', 'Argent Banque :', 'Object / Voiture :'}, {'250$', '100$', '1x Téléphone / Enduro'})
                    end,
                    onSelected = function()
                        Creator.starter = {name = "illegal", label = "Illégal"}
                        choisiStarter = true
                    end
                })
            end)

            RageUI.IsVisible(Charcreator.MainSpawn, function()
                for k,v in pairs(Spawn) do
                    RageUI.Button(k, nil, {}, true, {
                        onSelected = function()
                            Creator.spawn = k
                            choisiSpawn = true
                        end
                    })
                end
            end)
            
            RageUI.IsVisible(Charcreator.MainVetement, function()
                for k,v in pairs(Skin) do
                    RageUI.Button(k, nil, {}, true, {
                        onSelected = function()
                            Creator.skinSpawn = k
                            choisiHabit = true
                            setSkinToPed(v)
                        end})
                    end
                end)
            end
        end)
    end
end

vector3(-1554.3145751953,115.24348449707,56.780494689941-0.98)

local ControlDisable = {20, 24, 27, 178, 177, 189, 190, 187, 188, 202, 239, 240, 201, 172, 173, 174, 175}
function Cam()
    DisableAllControlActions(0)
    for k, v in pairs(ControlDisable) do
        EnableControlAction(0, v, true)
    end
    local Control1, Control2 = IsDisabledControlPressed(1, 44), IsDisabledControlPressed(1, 51)
    local Control3, Control4 = IsDisabledControlPressed(1, 73), IsDisabledControlPressed(1, 79)
    if Control1 or Control2 then
        local pPed = PlayerPedId()
        SetEntityHeading(pPed, Control1 and GetEntityHeading(pPed) - 2.0 or Control2 and GetEntityHeading(pPed) + 2.0)

        for k, v in pairs(GetActivePlayers()) do 
            if v ~= GetPlayerIndex() then 
                NetworkConcealPlayer(v, true, true) 
            end 
        end
    elseif Control3 then
        SetCamFov(cam, GetCamFov(cam) + 0.4)
    elseif Control4 then
        SetCamFov(cam, GetCamFov(cam) - 0.4)
    end
end

function DestroyCamCreator()
    DestroyCam(cam, false)
    RenderScriptCams(false, true, 1500, false, false)
end

function CamCreator(camType)
    SetEntityInvincible(PlayerPedId(), true) 
    FreezeEntityPosition(PlayerPedId(), true) 
    SetEntityCoords(PlayerPedId(), -1554.3145751953,115.24348449707,56.780494689941-0.98)
    SetEntityHeading(PlayerPedId(), 133.85)
    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", false)
    SetCamActive(cam, true)
    PointCamAtEntity(cam, PlayerPedId(), 0, 0, 0, 1)
    SetCamParams(cam, -1558.6339111328, 110.51725769043, 56.779865264893-0.98, 2.0, 0.0, 129.0322265625, 70.2442, 0, 1, 1, 2)
    SetCamFov(cam, 20.0)
    RenderScriptCams(1, 0, 0, 1, 1)
end

function setSkinToPed(Tenues)
    TriggerEvent("skinchanger:getSkin", function(skin)
        local uniformObject
        if skin.sex == 0 then
            uniformObject = Tenues.Male
        else
            uniformObject = Tenues.Female
        end
        if uniformObject then
            TriggerEvent('skinchanger:loadClothes', skin, uniformObject)
            TriggerServerEvent('esx_skin:save', skin)
            DisplayRadar(true)
            TriggerEvent('skinchanger:getSkin', function(skin4)
                TriggerServerEvent('skin:save', skin4)
            end)
        end
    end)
end

function skinAnim(coords)
    CinemaMode = true
    TaskGoStraightToCoord(PlayerPedId(), coords, 1.0, 8000, 320.25466, 5)
    CinemaMode = false
end

function GetComponents()
    for i= 0, 45, 1 do
        table.insert(Creator.face.items, '#'..i)
    end
    
    for i= 0, 210, 1 do
        table.insert(Creator.hair_1.items, '#'..i)
    end
    
    for i= 0, 100, 1 do
        table.insert(Creator.beard_1.items, '#'..i)
    end
    
    for i= 0, 45, 1 do
        table.insert(Creator.skin.items, '#'..i)
    end
    
    for i= 0, 150, 1 do
        table.insert(Creator.makeup_1.items, '#'..i)
    end
    
    for i= 0, 150, 1 do
        table.insert(Creator.lipstick_1.items, '#'..i)
    end
end

