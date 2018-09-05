-- load pfUI environment
setfenv(1, pfUI:GetEnvironment())

function pfUI:LoadGui_CustomMedia()
  if not pfUI.gui then return end

  local CreateConfig = pfUI.gui.CreateConfig
  local update = pfUI.gui.update
  
  if pfUI.gui.tabs.thirdparty then
    pfUI.gui.tabs.thirdparty.tabs.CustomMedia = pfUI.gui.tabs.thirdparty.tabs:CreateTabChild(T["Custom Media"], true)
    pfUI.gui.tabs.thirdparty.tabs.CustomMedia:SetScript("OnShow", function() 
      if not this.setup then
        CreateConfig(update['CustomMedia'], this, T["Select Player Castbar Texture"], C.CustomMedia, "pcastbar", "dropdown", pfUI.gui.dropdowns.uf_bartexture)
        CreateConfig(update['CustomMedia'], this, T["Select Target Castbar Texture"], C.CustomMedia, "tcastbar", "dropdown", pfUI.gui.dropdowns.uf_bartexture)
		CreateConfig(update['CustomMedia'], this, T["Enable Class Color Mana Bar"], C.CustomMedia,  "pbarcolor", "checkbox")
        this.setup = true 
      end
    end)
  end
end
