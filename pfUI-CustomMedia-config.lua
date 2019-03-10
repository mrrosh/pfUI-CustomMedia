--                MODULE        SUBGROUP       ENTRY               VALUE
-- pfUI:UpdateConfig("module_template", nil, nil, 0)

-- load pfUI environment
setfenv(1, pfUI:GetEnvironment())

function pfUI:LoadConfig_CustomMedia()
  pfUI:UpdateConfig("CustomMedia",       nil,         "pcastbar",   "Interface\\AddOns\\pfUI\\img\\bar")
  pfUI:UpdateConfig("CustomMedia",       nil,         "tcastbar",   "Interface\\AddOns\\pfUI\\img\\bar")
  pfUI:UpdateConfig("CustomMedia",       nil,         "pcwidth", "200")
  pfUI:UpdateConfig("CustomMedia",       nil,         "pcheight", "20")
  pfUI:UpdateConfig("CustomMedia",       nil,         "tcwidth", "200")
  pfUI:UpdateConfig("CustomMedia",       nil,         "tcheight", "20")
  pfUI:UpdateConfig("CustomMedia",       nil,         "ppbar",   "Interface\\AddOns\\pfUI\\img\\bar")
  pfUI:UpdateConfig("CustomMedia",       nil,         "tpbar",   "Interface\\AddOns\\pfUI\\img\\bar")
  pfUI:UpdateConfig("CustomMedia",       nil,         "ttpbar",   "Interface\\AddOns\\pfUI\\img\\bar")
end
