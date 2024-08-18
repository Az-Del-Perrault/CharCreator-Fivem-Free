ScriptServer = {}
ScriptServer.Functions = {}

function ScriptServer.Functions:GetPlayerInformations(playerId, identifier)
    local playerData = {}
    MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {
        ['@identifier'] = identifier
    }, function(result)
        if result[1] then
            playerData = {
                firstname = result[1].firstname,
                lastname = result[1].lastname,
                sex = result[1].sex,
                dateOfBirth = result[1].dateofbirth
            }
            
            if result[1].sex == "m" then
                playerData.sex = "Homme"
            elseif result[1].sex == "f" then
                playerData.sex = "Femme"
            end

            for k, v in pairs(json.decode(result[1].accounts)) do
                if v.name == 'bank' then
                    playerData.bank = v.money
                elseif v.name == 'black_money' then
                    playerData.blackMoney = v.money
                elseif v.name == 'money' then
                    playerData.money = v.money
                end
            end
            TriggerClientEvent('brx_spawn:OnPlayerConnect', playerId, playerData)
        end
    end)
end

function ScriptServer.Functions:GetFristConnection(identifier)
    local fristConnection = MySQL.Sync.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {['@identifier'] = identifier})
    if fristConnection[1] ~= nil then
        return false
    else
        return true
    end
end

RegisterNetEvent('brx_spawn:OnPlayerConnect', function(data)
    local playerId = source
    local identifier = GetPlayerIdentifiers(playerId)[1]

    if not ScriptServer.Functions:GetFristConnection(identifier) then
        ScriptServer.Functions:GetPlayerInformations(playerId, identifier)
    end
end)

