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
  end

  function pfUI.CustomMedia:UpdateConfig()
    LoadTextures()
  end

  pfUI.CustomMedia:UpdateConfig()
end)
