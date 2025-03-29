pfUI:RegisterModule("CustomMedia", "vanilla:tbc", function()
    if not C.CustomMedia then C.CustomMedia = {} end
    C.CustomMedia.selectimg = C.CustomMedia.selectimg or "Default" -- Default background texture
    C.CustomMedia.color = C.CustomMedia.color or "1,1,1,0.5" -- Default color

    -- Dropdown options for selecting textures
    pfUI.gui.dropdowns.CustomMedia_selectimg = {
        "Default:" .. T["Default"],
        "Sword:" .. T["Sword"],
        "Lion:" .. T["Lion"],
        "Eagle:" .. T["Eagle"]
    }

    -- Function to get the texture based on selection
    local function GetTexture(selection)
        if selection == "Default" then
            return nil
        elseif selection == "Sword" then
            return "Interface\\AddOns\\pfUI-CustomMedia\\media\\sword"
        elseif selection == "Lion" then
            return "Interface\\AddOns\\pfUI-CustomMedia\\media\\lion"
        elseif selection == "Eagle" then
            return "Interface\\AddOns\\pfUI-CustomMedia\\media\\eagle"
        end
    end

    -- Function to apply background texture and color to buttons
    local function ApplyBackgroundToPfUIButtons(texture, color)
        local _G = getfenv(0)

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
            local buttonCount = 12
            if group == "pfActionBarPetButton" or group == "pfActionBarStancesButton" then
                buttonCount = 10
            end

            for i = 1, buttonCount do
                local buttonName = group .. i
                local button = _G[buttonName]
                local r, g, b, a = GetStringColor(color)
                if button then
                    if button.bg then 
                        button.bg:Hide()
                        button.bg = nil
                    end

                    if texture then
                        local bg = button:CreateTexture(nil, "BACKGROUND")
                        bg:SetDrawLayer("BACKGROUND", -8)
                        bg:SetAllPoints(button)
                        bg:SetTexture(texture)
                        bg:SetTexCoord(0, 1, 0, 1)
                        bg:SetVertexColor(r, g, b, a)
                        button.bg = bg
                    end

                    local icon = button.icon or button:GetNormalTexture()
                    if icon then
                        icon:SetDrawLayer("ARTWORK", 1)
                    end
                end
            end
        end
    end

    -- Function to apply background to bags
    local function ApplyBackgroundToBags(texture, color)
        local _G = getfenv(0)

        for bagIndex = 0, 4 do
            local bag = _G["pfBag" .. bagIndex]
            local r, g, b, a = GetStringColor(color)
            if bag then
                for slotIndex = 1, 36 do
                    local button = _G["pfBag" .. bagIndex .. "item" .. slotIndex]
                    if button then
                        if button.bg then 
                            button.bg:Hide()
                            button.bg = nil
                        end

                        if texture then
                            local bg = button:CreateTexture(nil, "BACKGROUND")
                            bg:SetDrawLayer("BACKGROUND", -8)
                            bg:SetAllPoints(button)
                            bg:SetTexture(texture)
                            bg:SetTexCoord(0, 1, 0, 1)
                            bg:SetVertexColor(r, g, b, a)
                            button.bg = bg
                        end

                        local icon = button.icon or button:GetNormalTexture()
                        if icon then
                            icon:SetDrawLayer("ARTWORK", 1)
                        end
                    end
                end
            end
        end
    end

    -- Reload function to update UI with new settings
    local function ReloadUI()
        local texture = GetTexture(C.CustomMedia.selectimg)
        local color = C.CustomMedia.color
        ApplyBackgroundToPfUIButtons(texture, color)
        ApplyBackgroundToBags(texture, color)
    end

    -- Register event to apply background when entering the world (after reload)
    local frame = CreateFrame("Frame")
    frame:RegisterEvent("PLAYER_ENTERING_WORLD")
    frame:SetScript("OnEvent", function()
        ReloadUI()
        frame:UnregisterEvent("PLAYER_ENTERING_WORLD")
    end)

    -- GUI configuration
    if pfUI.gui.CreateGUIEntry then
        pfUI.gui.CreateGUIEntry(T["Thirdparty"], T["CustomMedia"], function()
            pfUI.gui.CreateConfig(pfUI.gui.UpdaterFunctions["CustomMedia"], T["Bar buttons background"], nil, nil, "header")
            pfUI.gui.CreateConfig(pfUI.gui.UpdaterFunctions["CustomMedia"], T["Select button texture"], C.CustomMedia, "selectimg", "dropdown", pfUI.gui.dropdowns.CustomMedia_selectimg)
            pfUI.gui.CreateConfig(pfUI.gui.UpdaterFunctions["CustomMedia"], T["Pick Color"], C.CustomMedia, "color", "color")
        end)
    else
        -- Fallback GUI setup
        pfUI.gui.tabs.thirdparty.tabs.CustomMedia = pfUI.gui.tabs.thirdparty.tabs:CreateTabChild("CustomMedia", true)
        pfUI.gui.tabs.thirdparty.tabs.CustomMedia:SetScript("OnShow", function() if not this.setup then this.setup = true end end)
    end
end)