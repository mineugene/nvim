LUAFILES=init.lua lua/

all: /usr/bin/nvim
	/usr/bin/nvim --headless -c "autocmd User PackerComplete quitall" -c "PackerSync"

clean:
	/usr/bin/rm plugin/packer_compiled.lua

lint: /usr/bin/which /usr/bin/luacheck
	@/usr/bin/luacheck ${LUAFILES}

.PHONY: all clean lint
.DEFAULT_GOAL:=all
