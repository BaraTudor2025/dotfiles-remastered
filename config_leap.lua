require('leap').setup {
  safe_labels = {
    'h', 'j', 'k', 'l', "s", "f", "n", "u", "t", "q", "r", "m", "'",
  },
}

return {
  setup = function ()
    require('leap').set_default_keymaps()
  end
}
