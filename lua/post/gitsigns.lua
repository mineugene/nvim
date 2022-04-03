local settings = {
  signs = {
    add = { text = "\u{258E}" }, -- left one-quarter block
    change = { text = "\u{258E}" }, -- left one-quarter block
    changedelete = { text = "\u{2580}" }, -- upper half block
    delete = { text = "\u{2581}" }, -- lower one-eighth block
    topdelete = { text = "\u{2594}" }, -- upper one-eighth block
  },
  numhl = false,
}

require("gitsigns").setup(settings)
