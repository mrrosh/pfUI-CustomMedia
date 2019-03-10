-- load pfUI environment
setfenv(1, pfUI:GetEnvironment())

function pfUI:LoadGui_CustomMedia()
  if not pfUI.gui then return end

local old_gui = true
  
  if pfUI.api.checkversion and pfUI.api.checkversion(3, 20, 0) and pfUI.gui.CreateGUIEntry then
    old_gui = false
  end

  if old_gui then

  local CreateConfig = pfUI.gui.CreateConfig
  local update = pfUI.gui.update
 
  if pfUI.gui.tabs.thirdparty then
    pfUI.gui.tabs.thirdparty.tabs.CustomMedia = pfUI.gui.tabs.thirdparty.tabs:CreateTabChild(T["CustomMedia"], true)
    pfUI.gui.tabs.thirdparty.tabs.CustomMedia:SetScript("OnShow", function() 
      if not this.setup then
	    CreateConfig(update['CustomMedia'], this, T["Castbar Texture"], nil, nil, "header")
        CreateConfig(update['CustomMedia'], this, T["Select Player Castbar Texture"], C.CustomMedia, "pcastbar", "dropdown", pfUI.gui.dropdowns.uf_bartexture)
        CreateConfig(update['CustomMedia'], this, T["Select Target Castbar Texture"], C.CustomMedia, "tcastbar", "dropdown", pfUI.gui.dropdowns.uf_bartexture)
		CreateConfig(update['CustomMedia'], this, T["Castbar Size"], nil, nil, "header")
		CreateConfig(update['CustomMedia'], this, T["Select Player Castbar Width"], C.CustomMedia, "pcwidth")
		CreateConfig(update['CustomMedia'], this, T["Select Player Castbar Height"], C.CustomMedia, "pcheight")
		CreateConfig(update['CustomMedia'], this, T["Select Target Castbar Width"], C.CustomMedia, "tcwidth")
		CreateConfig(update['CustomMedia'], this, T["Select Target Castbar Height"], C.CustomMedia, "tcheight")
		CreateConfig(update['CustomMedia'], this, T["Power Bar Texture"], nil, nil, "header")
		CreateConfig(update['CustomMedia'], this, T["Select Player Power Bar Texture"], C.CustomMedia, "ppbar", "dropdown", pfUI.gui.dropdowns.uf_bartexture)
		CreateConfig(update['CustomMedia'], this, T["Select Target Power Bar Texture"], C.CustomMedia, "tpbar", "dropdown", pfUI.gui.dropdowns.uf_bartexture)
		CreateConfig(update['CustomMedia'], this, T["Select ToT Power Bar Texture"], C.CustomMedia, "ttpbar", "dropdown", pfUI.gui.dropdowns.uf_bartexture)
        this.setup = true 
      end
    end)
  end
else
    local Reload = pfUI.gui.Reload
    local CreateConfig = pfUI.gui.CreateConfig
    local CreateGUIEntry = pfUI.gui.CreateGUIEntry
    local U = pfUI.gui.UpdaterFunctions
    CreateGUIEntry(T["pfUI-CustomMedia"], function()
	    CreateConfig(U["CustomMedia"], this, T["Castbar Texture"], nil, nil, "header")
        CreateConfig(U["CustomMedia"], this, T["Select Player Castbar Texture"], C.CustomMedia, "pcastbar", "dropdown", pfUI.gui.dropdowns.uf_bartexture)
        CreateConfig(U["CustomMedia"], this, T["Select Target Castbar Texture"], C.CustomMedia, "tcastbar", "dropdown", pfUI.gui.dropdowns.uf_bartexture)
		CreateConfig(U["CustomMedia"], this, T["Castbar Size"], nil, nil, "header")
		CreateConfig(U["CustomMedia"], this, T["Select Player Castbar Width"], C.CustomMedia, "pcwidth")
		CreateConfig(U["CustomMedia"], this, T["Select Player Castbar Height"], C.CustomMedia, "pcheight")
		CreateConfig(U["CustomMedia"], this, T["Select Target Castbar Width"], C.CustomMedia, "tcwidth")
		CreateConfig(U["CustomMedia"], this, T["Select Target Castbar Height"], C.CustomMedia, "tcheight")
		CreateConfig(U["CustomMedia"], this, T["Power Bar Texture"], nil, nil, "header")
		CreateConfig(U["CustomMedia"], this, T["Select Player Power Bar Texture"], C.CustomMedia, "ppbar", "dropdown", pfUI.gui.dropdowns.uf_bartexture)
		CreateConfig(U["CustomMedia"], this, T["Select Target Power Bar Texture"], C.CustomMedia, "tpbar", "dropdown", pfUI.gui.dropdowns.uf_bartexture)
    end)
  end
  end