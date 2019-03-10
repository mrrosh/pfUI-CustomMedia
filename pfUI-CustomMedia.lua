pfUI:RegisterModule("CustomMedia", function ()

  pfUI:LoadConfig_CustomMedia()
  pfUI:LoadGui_CustomMedia()

  pfUI.CustomMedia = CreateFrame("Frame", "pfCustomMedia", UIParent)


  local function LoadTextures()
    if pfUI.castbar.player then
      pfUI.castbar.player.bar:SetStatusBarTexture(C.CustomMedia.pcastbar)
	  pfUI.castbar.player:SetWidth(C.CustomMedia.pcwidth)
	  pfUI.castbar.player:SetHeight(C.CustomMedia.pcheight)
    end
    if pfUI.castbar.target then
      pfUI.castbar.target.bar:SetStatusBarTexture(C.CustomMedia.tcastbar)
	  pfUI.castbar.target:SetWidth(C.CustomMedia.tcwidth)
	  pfUI.castbar.target:SetHeight(C.CustomMedia.tcheight)
    end
	if pfUI.uf.player then
	  pfUI.uf.player.power.bar:SetStatusBarTexture(C.CustomMedia.ppbar)
	end
	if pfUI.uf.target then
	  pfUI.uf.target.power.bar:SetStatusBarTexture(C.CustomMedia.tpbar)
	end
	if pfUI.uf.targettarget then
	  pfUI.uf.targettarget.power.bar:SetStatusBarTexture(C.CustomMedia.ttpbar)
	end
  end

  function pfUI.CustomMedia:UpdateConfig()
    LoadTextures()
  end

  pfUI.CustomMedia:UpdateConfig()

end)
	

  SLASH_FRAMESTACK1 = '/fs'
  SLASH_FRAMESTACK3 = '/fstack'
  SLASH_FRAMESTACK2 = '/framestack'
  SlashCmdList.FRAMESTACK = function()
  print(GetMouseFocus():GetName())
  end