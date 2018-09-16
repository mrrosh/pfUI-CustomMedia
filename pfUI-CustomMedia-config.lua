--                MODULE        SUBGROUP       ENTRY               VALUE
-- pfUI:UpdateConfig("module_template", nil, nil, 0)

-- load pfUI environment
setfenv(1, pfUI:GetEnvironment())

function pfUI:LoadConfig_CustomMedia()



local color = RAID_CLASS_COLORS[class]

  pfUI:UpdateConfig("CustomMedia",       nil,         "pcastbar",   "Interface\\AddOns\\pfUI\\img\\bar")
  pfUI:UpdateConfig("CustomMedia",       nil,         "tcastbar",   "Interface\\AddOns\\pfUI\\img\\bar")
end
