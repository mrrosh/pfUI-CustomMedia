pfUI:RegisterModule("CustomMedia", function ()

  pfUI:LoadConfig_CustomMedia()
  pfUI:LoadGui_CustomMedia()

  pfUI.CustomMedia = CreateFrame("Frame", "pfCustomMedia", UIParent)

  local function LoadTextures()
    if pfUI.castbar.player then
      pfUI.castbar.player.bar:SetStatusBarTexture(C.CustomMedia.pcastbar)
    end
    if pfUI.castbar.target then
      pfUI.castbar.target.bar:SetStatusBarTexture(C.CustomMedia.tcastbar)
    end
	if pfUI.uf.player.power then
	  pfUI.uf.player.power.bar:SetStatusBarColor(C.CustomMedia.pbarcolor)
	  for i=1,40 do
      pfUI.uf.raid[i].power.bar:SetStatusBarColor(C.CustomMedia.pbarcolor)
end
	end
  end

  function pfUI.CustomMedia:UpdateConfig()
    LoadTextures()
  end

  pfUI.CustomMedia:UpdateConfig()
end)
