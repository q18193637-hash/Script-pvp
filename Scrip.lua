-- [[ PVP SCRIPT COMBINED ]] --

-- 1. CÁC BIẾN DỊCH VỤ (SERVICES)
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- 2. HÀM TÌM NGƯỜI CHƠI GẦN NHẤT
local function getClosestPlayer()
    local closestPlayer = nil
    local shortestDistance = math.huge

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local distance = (player.Character.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
            if distance < shortestDistance then
                closestPlayer = player
                shortestDistance = distance
            end
        end
    end
    return closestPlayer
end

-- 3. HÀM TỰ ĐỘNG TẤN CÔNG (COMBO MẪU)
local function attackCombo(target)
    if target and target.Character then
        local targetPos = target.Character.HumanoidRootPart.Position
        
        -- Gọi Remote tấn công (Ví dụ chiêu Z)
        -- Lưu ý: Tên Remote "CommF_" có thể thay đổi tùy phiên bản game
        local args = {
            [1] = "Z",
            [2] = targetPos
        }
        ReplicatedStorage.Remotes.CommF_:InvokeServer(unpack(args))
    end
end

-- 4. VÒNG LẶP CHÍNH (MAIN TOGGLE)
-- Bạn có thể tạo một biến để bật/tắt script
_G.AutoPvP = true 

task.spawn(function()
    while _G.AutoPvP do
        local target = getClosestPlayer()
        if target then
            -- Chỉ tấn công nếu đối thủ ở gần (ví dụ dưới 100 mét)
            local distance = (target.Character.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
            if distance < 100 then
                attackCombo(target)
            end
        end
        task.wait(0.5) -- Nghỉ một chút để tránh bị văng game (crash)
    end
end)

print("Script đã được kích hoạt thành công!")

