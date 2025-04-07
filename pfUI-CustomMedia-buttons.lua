pfUI:RegisterModule("CustomMedia", "vanilla:tbc", function()
    if not C.CustomMedia then C.CustomMedia = {} end
    C.CustomMedia.selectimg = C.CustomMedia.selectimg or "Default"
    C.CustomMedia.color = C.CustomMedia.color or "1,1,1,0.5"

    pfUI.gui.dropdowns.CustomMedia_selectimg = {
        "Default:" .. T["Default"],
        "Sword:" .. T["Sword"],
        "Lion:" .. T["Lion"],
        "Eagle:" .. T["Eagle"]
    }

    local function GetTexture(selection)
        local textures = {
            Default = nil,
            Sword = "Interface\\AddOns\\pfUI-CustomMedia\\media\\sword",
            Lion = "Interface\\AddOns\\pfUI-CustomMedia\\media\\lion",
            Eagle = "Interface\\AddOns\\pfUI-CustomMedia\\media\\eagle"
        }
        return textures[selection] or nil
    end

    local function ApplyBackground(texture, color, frame)
        if not frame or not frame:IsShown() then return end
        local r, g, b, a = GetStringColor(color)
        
        -- Clear existing background
        if frame.bg then
            frame.bg:Hide()
            frame.bg:SetTexture(nil)
            frame.bg = nil
        end

        if texture then
            if not frame.bg then
                frame.bg = frame:CreateTexture(nil, "BACKGROUND")
                frame.bg:SetDrawLayer("BACKGROUND", -8)
                frame.bg:SetAllPoints(frame)
            end
            frame.bg:SetTexture(texture)
            frame.bg:SetTexCoord(0, 1, 0, 1)
            frame.bg:SetVertexColor(r, g, b, a)
            frame.bg:Show()
        end

        local icon = frame.icon or frame:GetNormalTexture()
        if icon then 
            icon:SetDrawLayer("ARTWORK", 1)
            icon:Show()
        end
    end

    local function UpdateButtons()
        local texture = GetTexture(C.CustomMedia.selectimg)
        local color = C.CustomMedia.color
        local buttonGroups = {
            "pfActionBarMainButton",
            "pfActionBarRightButton",
            "pfActionBarVerticalButton",
            "pfActionBarLeftButton",
            "pfActionBarTopButton",
            "pfActionBarStanceBar1Button",
            "pfActionBarStanceBar2Button",
            "pfActionBarStanceBar3Button",
            "pfActionBarStanceBar4Button",
            "pfActionBarPetButton",
            "pfActionBarStancesButton",
            "pfActionBarPagingButton",
        }

        for _, group in ipairs(buttonGroups) do
            local buttonCount = (group == "pfActionBarPetButton" or group == "pfActionBarStancesButton") and 10 or 12
            for i = 1, buttonCount do
                local button = _G[group .. i]
                if button then
                    ApplyBackground(texture, color, button)
                end
            end
        end
    end

    local function UpdateBags()
        local texture = GetTexture(C.CustomMedia.selectimg)
        local color = C.CustomMedia.color
        
        for bagIndex = 0, 4 do
            local bag = _G["pfBag" .. bagIndex]
            if bag then
                for slotIndex = 1, 36 do
                    local button = _G["pfBag" .. bagIndex .. "item" .. slotIndex]
                    if button then
                        ApplyBackground(texture, color, button)
                    end
                end
            end
        end
    end

    local function UpdateBank()
        local texture = GetTexture(C.CustomMedia.selectimg)
        local color = C.CustomMedia.color
        
        for slotIndex = 1, 24 do
            local button = _G["pfBag-1item" .. slotIndex]
            if button then
                ApplyBackground(texture, color, button)
            end
        end

        for bagIndex = 5, 10 do
            local bankBag = _G["pfBag" .. bagIndex]
            if bankBag then
                for slotIndex = 1, 36 do
                    local button = _G["pfBag" .. bagIndex .. "item" .. slotIndex]
                    if button then
                        ApplyBackground(texture, color, button)
                    end
                end
            end
        end
    end

    local function UpdateAll()
        UpdateButtons()
        UpdateBags()
        if BankFrame and BankFrame:IsShown() then
            UpdateBank()
        end
    end

    -- Main update frame
    local f = CreateFrame("Frame")
    f:RegisterEvent("PLAYER_ENTERING_WORLD")
    f:RegisterEvent("BAG_UPDATE")
    f:RegisterEvent("BANKFRAME_OPENED")
    f:RegisterEvent("BANKFRAME_CLOSED")
    f:RegisterEvent("ADDON_LOADED")
    
    -- Delay mechanism for Vanilla
    local delayFrame = CreateFrame("Frame")
    local delayTime = 1 -- 1 second delay
    local elapsed = 0
    delayFrame:Hide()
    
    delayFrame:SetScript("OnUpdate", function()
        elapsed = elapsed + arg1
        if elapsed >= delayTime then
            UpdateAll()
            this:Hide()
            elapsed = 0
        end
    end)

    local function DelayedUpdate()
        delayFrame:Show()
    end

    f:SetScript("OnEvent", function()
        if event == "PLAYER_ENTERING_WORLD" or (event == "ADDON_LOADED" and arg1 == "pfUI") then
            DelayedUpdate()
            if event == "PLAYER_ENTERING_WORLD" then
                this:UnregisterEvent("PLAYER_ENTERING_WORLD")
            end
        elseif event == "BAG_UPDATE" then
            UpdateBags()
        elseif event == "BANKFRAME_OPENED" then
            UpdateBank()
        elseif event == "BANKFRAME_CLOSED" then
            UpdateBags()
        end
    end)

    -- Hook into pfUI's update system
    if pfUI.gui and pfUI.gui.UpdaterFunctions then
        pfUI.gui.UpdaterFunctions["CustomMedia"] = function()
            UpdateAll()
            DelayedUpdate()
        end
    end

    -- GUI Configuration
    if pfUI.gui.CreateGUIEntry then
        pfUI.gui.CreateGUIEntry(T["Thirdparty"], T["CustomMedia"], function()
            pfUI.gui.CreateConfig(pfUI.gui.UpdaterFunctions["CustomMedia"], T["Bar buttons background"], nil, nil, "header")
            pfUI.gui.CreateConfig(pfUI.gui.UpdaterFunctions["CustomMedia"], T["Select button texture"], C.CustomMedia, "selectimg", "dropdown", pfUI.gui.dropdowns.CustomMedia_selectimg)
            pfUI.gui.CreateConfig(pfUI.gui.UpdaterFunctions["CustomMedia"], T["Pick Color"], C.CustomMedia, "color", "color")
        end)
    else
        pfUI.gui.tabs.thirdparty.tabs.CustomMedia = pfUI.gui.tabs.thirdparty.tabs:CreateTabChild("CustomMedia", true)
        pfUI.gui.tabs.thirdparty.tabs.CustomMedia:SetScript("OnShow", function() 
            if not this.setup then 
                this.setup = true 
                DelayedUpdate()
            end 
        end)
    end

    -- Force initial update
    DelayedUpdate()
end)