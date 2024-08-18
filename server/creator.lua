ESX = exports["es_extended"]:getSharedObject()

local characters = { "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z" }

function CreateRandomPlateText()
    local plate = ""
    math.randomseed(GetGameTimer())
    for i = 1, 4 do
        plate = plate .. characters[math.random(1, #characters)]
    end
    plate = plate .. ""
    for i = 1, 3 do
        plate = plate .. math.random(1, 9)
    end
    return plate
end

RegisterNetEvent('flCore:CreatePlayer')
AddEventHandler('flCore:CreatePlayer', function(Creator)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    MySQL.Async.execute("UPDATE users SET firstname = @prenom, lastname = @nom, dateofbirth = @dob, sex = @sex, height = @height WHERE identifier = @identifier", {
        ["@identifier"] = xPlayer.identifier,
        ["@prenom"] = Creator.firstname,
        ["@nom"] = Creator.lastname,
        ["@dob"] = Creator.age,
        ["@sex"] = Creator.sexe,
        ["@height"] = Creator.height
    }, function()
        print("📌 | Nouvel enregistrement d'identity ("..GetPlayerName(xPlayer.source)..")\n- Nom : "..Creator.lastname.."\n- Prénom : "..Creator.firstname)
    end)

    if Creator.starter.name == "legal" then
        Plate = CreateRandomPlateText()
        MySQL.Async.execute("INSERT INTO owned_vehicles (owner, plate, vehicle, type, state) VALUES (@owner, @plate, @vehicle, @type, @state)", {
            ["@owner"] = xPlayer.identifier,
            ["@plate"] = Plate,
            ["@vehicle"] = json.encode({ model = GetHashKey('panto'), plate = plateText }),
            ["@type"] = "car",
            ["@state"] = 1
        })
        xPlayer.addMoney(1000)
        xPlayer.addAccountMoney('bank', 250)
        xPlayer.addInventoryItem("water", 5)
        xPlayer.addInventoryItem("bread", 5)
    elseif Creator.starter.name == "illegal" then
        Plate = CreateRandomPlateText()
        MySQL.Async.execute("INSERT INTO owned_vehicles (owner, plate, vehicle, type, state) VALUES (@owner, @plate, @vehicle, @type, @state)", {
            ["@owner"] = xPlayer.identifier,
            ["@plate"] = Plate,
            ["@vehicle"] = json.encode({ model = GetHashKey('enduro'), plate = plateText }),
            ["@type"] = "car",
            ["@state"] = 1
        })
        xPlayer.addAccountMoney('black_money', 250)
        xPlayer.addAccountMoney('bank', 100)
        xPlayer.addInventoryItem("phone", 1)
    end
end)


