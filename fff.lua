local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local activated = false
local spamConnection

-- Função que simula o clique do botão esquerdo do mouse (MouseButton1) e a tecla "G"
local function spamMouse1AndG()
    -- Simula o clique do botão esquerdo do mouse
    mouse1press()  
    task.wait(0.05)  -- Pequeno delay para garantir que o clique seja registrado
    mouse1release()

    -- Simula o pressionamento da tecla "G"
    keypress(Enum.KeyCode.G)  
    task.wait(0.05)  -- Pequeno delay entre a ação do mouse e da tecla
    keyrelease(Enum.KeyCode.G)
end

-- Função que alterna entre ativar e desativar o spam
local function toggleSpam()
    activated = not activated

    if activated then
        if not spamConnection then  -- Evita múltiplas conexões
            -- Inicia o spam utilizando o RunService para executar a cada frame
            spamConnection = RunService.Heartbeat:Connect(function()
                spamMouse1AndG()
            end)
        end
    else
        -- Desativa o spam quando `activated` for falso
        if spamConnection then
            spamConnection:Disconnect()
            spamConnection = nil  -- Limpa a conexão
        end
    end
end

-- Detecta quando a tecla "E" é pressionada para iniciar ou parar o spam de Mouse1 e "G"
UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
    if not gameProcessedEvent and input.KeyCode == Enum.KeyCode.E then
        toggleSpam()
    end
end)
