yay.create_autocmd("UpgradeSelect", {
  desc = "skip AUR packages newer than 30 days",
  callback = function(event)
    local exclude = {}
    local cutoff = os.time() - (30 * 24 * 60 * 60)
    for _, pkg in ipairs(event.data.upgrades) do
      if pkg.repository == "aur" and pkg.last_modified >= cutoff then
        yay.log.debug("excluding AUR package newer than 30 days:", pkg.name)
        table.insert(exclude, pkg.name)
      end
    end
    return { exclude = exclude, skip_menu = false }
  end,
})
