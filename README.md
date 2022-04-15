# Another Neovim Configuration

<div style="display:block-inline;">
  <img src="https://img.shields.io/badge/Linux-%23.svg?style=flat-square&logo=linux&color=FCC624&logoColor=black" alt="Linux badge" />
  <img src="https://img.shields.io/badge/Neovim-0.7.0-57A143.svg?style=flat-square&logo=Neovim&logoColor=57A143" alt="Neovim badge" />
  <img src="https://img.shields.io/github/languages/top/mineugene/nvim?style=flat-square&color=2C2D72" alt="top language badge" />
</div>

![nvim screenshot](https://user-images.githubusercontent.com/8313048/161401470-d2e27892-c3e4-4b0d-94e8-3c77883f2733.png)


## Install

### Pre-requisites

#### Neovim
  - ![neovim/neovim](https://github.com/neovim/neovim/releases/stable) >= 0.7.0

#### Language Servers
  - ![sumneko/lua-language-server](https://github.com/sumneko/lua-language-server/releases)
  - ![iamcco/vim-language-server](https://github.com/iamcco/vim-language-server)
  - ![palantir/python-language-server](https://github.com/palantir/python-language-server)

Note: see Neovim documentation on ![server_configurations.md](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md)
for instructions on installing the above language servers.

### Linux
```shell
git clone --depth 1 \
  "https://www.github.com/mineugene/nvim" \
  "$HOME/.config"
cd $HOME/.config/nvim && make
```
