pfUI:RegisterModule("CustomMedia", "vanilla:tbc", function()
  if not C.CustomMedia then C.CustomMedia = {} end
  C.CustomMedia.selectimg = C.CustomMedia.selectimg or "Default"
  C.CustomMedia.color = C.CustomMedia.color or "1,1,1,0.5"
  C.CustomMedia.debug = false -- turn true if you want print statements

  pfUI.gui.dropdowns.CustomMedia_selectimg = {
    "Default:" .. T["Default"],
    "Wings:" .. T["Wings"],
    "Lion:" .. T["Lion"],
    "Eagle:" .. T["Eagle"],
    "Grunge:" .. T["Grunge"],
    "Textured:" .. T["Textured"],
    "Transparent:" .. T["Transparent"]
  }

  local function PrintDebug(msg)
    if C.CustomMedia.debug then
      DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99[CustomMedia]:|r " .. msg)
    end
  end

  local function GetTexture(selection)
    local textures = {
      Default = nil,
      Wings = "Interface\\AddOns\\pfUI-CustomMedia\\media\\wings",
      Lion = "Interface\\AddOns\\pfUI-CustomMedia\\media\\lion",
      Eagle = "Interface\\AddOns\\pfUI-CustomMedia\\media\\eagle",
      Grunge = "Interface\\AddOns\\pfUI-CustomMedia\\media\\grunge",
      Textured = "Interface\\AddOns\\pfUI-CustomMedia\\media\\textured",
      Transparent = "Interface\\AddOns\\pfUI-CustomMedia\\media\\transparent"
    }
    return textures[selection] or nil
  end
  local function GetStringColor(color)
    if type(color) == "string" then
      local r, g, b, a = strsplit(",", color)
      return tonumber(r), tonumber(g), tonumber(b), tonumber(a) or 1
    elseif type(color) == "table" then
      return color.r or 1, color.g or 1, color.b or 1, color.a or 1
    end
    return 1, 1, 1, 1 -- default to white if no valid color is provided
  end

  local function ApplyBackground(texture, color, frame)
    if not frame or not frame:IsShown() then return end
    local r, g, b, a = GetStringColor(color)

    if not frame.bg then
      frame.bg = frame:CreateTexture(nil, "BACKGROUND")
      frame.bg:SetDrawLayer("BACKGROUND", -8)
      frame.bg:SetAllPoints(frame)
    end

    if texture then
      frame.bg:SetTexture(texture)
      frame.bg:SetTexCoord(0, 1, 0, 1)
      frame.bg:SetVertexColor(r, g, b, a)
      frame.bg:Show()
      PrintDebug("Applied texture to " .. (frame:GetName() or "unknown"))
    else
      frame.bg:SetTexture(nil)
      frame.bg:Hide()
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
      local buttonCount = (strfind(group, "Pet") or strfind(group, "Stances")) and 10 or 12
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
      for slotIndex = 1, 36 do
        local button = _G["pfBag" .. bagIndex .. "item" .. slotIndex]
        if button then
          ApplyBackground(texture, color, button)
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
      for slotIndex = 1, 36 do
        local button = _G["pfBag" .. bagIndex .. "item" .. slotIndex]
        if button then
          ApplyBackground(texture, color, button)
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

  -- Delayed update mechanism (Vanilla-compatible)
  local delayFrame = CreateFrame("Frame")
  local delayTime = 1
  local elapsedTime = 0
  delayFrame:Hide()

  delayFrame:SetScript("OnUpdate", function()
    elapsedTime = elapsedTime + arg1
    if elapsedTime >= delayTime then
      UpdateAll()
      delayFrame:Hide()
      elapsedTime = 0
    end
  end)

  local function DelayedUpdate()
    delayFrame:Show()
  end

  local f = CreateFrame("Frame")
  f:RegisterEvent("PLAYER_ENTERING_WORLD")
  f:RegisterEvent("BAG_UPDATE")
  f:RegisterEvent("BANKFRAME_OPENED")
  f:RegisterEvent("BANKFRAME_CLOSED")
  f:RegisterEvent("ADDON_LOADED")

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

  -- GUI config
  if pfUI.gui and pfUI.gui.UpdaterFunctions then
    pfUI.gui.UpdaterFunctions["CustomMedia"] = function()
      UpdateAll()
      DelayedUpdate()
    end
  end

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

  -- Initial update
  DelayedUpdate()
end)
