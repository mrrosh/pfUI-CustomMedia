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
        if selection == "Default" then return nil
        elseif selection == "Sword" then return "Interface\\AddOns\\pfUI-CustomMedia\\media\\sword"
        elseif selection == "Lion" then return "Interface\\AddOns\\pfUI-CustomMedia\\media\\lion"
        elseif selection == "Eagle" then return "Interface\\AddOns\\pfUI-CustomMedia\\media\\eagle"
        end
    end

    local function ApplyBackgroundToButtons(texture, color)
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
            local r, g, b, a = GetStringColor(color)
            
            for i = 1, buttonCount do
                local button = _G[group .. i]
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
                    if icon then icon:SetDrawLayer("ARTWORK", 1) end
                end
            end
        end
    end

    local function ApplyBackgroundToBags(texture, color)
        local r, g, b, a = GetStringColor(color)
        
        for bagIndex = 0, 4 do
            local bag = _G["pfBag" .. bagIndex]
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
                        if icon then icon:SetDrawLayer("ARTWORK", 1) end
                    end
                end
            end
        end
    end

    local function UpdateTextures()
        local texture = GetTexture(C.CustomMedia.selectimg)
        local color = C.CustomMedia.color
        ApplyBackgroundToButtons(texture, color)
        ApplyBackgroundToBags(texture, color)
    end

    local frame = CreateFrame("Frame")
    frame:RegisterEvent("PLAYER_ENTERING_WORLD")
    frame:SetScript("OnEvent", function()
        UpdateTextures()
        frame:UnregisterEvent("PLAYER_ENTERING_WORLD")
    end)

    if pfUI.gui.CreateGUIEntry then
        pfUI.gui.CreateGUIEntry(T["Thirdparty"], T["CustomMedia"], function()
            pfUI.gui.CreateConfig(pfUI.gui.UpdaterFunctions["CustomMedia"], T["Bar buttons background"], nil, nil, "header")
            pfUI.gui.CreateConfig(pfUI.gui.UpdaterFunctions["CustomMedia"], T["Select button texture"], C.CustomMedia, "selectimg", "dropdown", pfUI.gui.dropdowns.CustomMedia_selectimg)
            pfUI.gui.CreateConfig(pfUI.gui.UpdaterFunctions["CustomMedia"], T["Pick Color"], C.CustomMedia, "color", "color")
        end)
    else
        pfUI.gui.tabs.thirdparty.tabs.CustomMedia = pfUI.gui.tabs.thirdparty.tabs:CreateTabChild("CustomMedia", true)
        pfUI.gui.tabs.thirdparty.tabs.CustomMedia:SetScript("OnShow", function() if not this.setup then this.setup = true end end)
    end
end)
