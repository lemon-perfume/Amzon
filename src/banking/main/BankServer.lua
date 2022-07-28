-- Ender Modem
local side = "back"
rednet.open(side)

-- Version
local v = "1.0"

-- Password Hash
os.loadAPI("hash")

-- The Vault
local vault = peripheral.find("create:item_vault")

-- Monitor
local monitor = peripheral.find("monitor")

-- User Authentication
function remoteAuth(id, account, pin)
    local accountRight = false
    local pinRight = false

    if fs.exists(account) then 
        accountRight = true
        local readAccount = fs.open(account, "r")
        pinFound = rf.readAll()

        if hash.checkPassword(pin, pinFound) then
            pinRight = true
        end
        rf.close()
    end

    if accountRight then
        if pinRight then
            rednet.send(id, "correct")
            return true
        end
    end
end

-- Display Balance
function displayTotalBalance()
    local totalBal = 0

    for slot, item in pairs(chest.list()) do
        totalBal = totalBal + item.count
    end
    monitor.clear()
    monitor.setCursorPos(1, 1)
    monitor.write(totalBal.." diamonds")
end


-- Main Loop
while true do
    displayTotalBalance()
end