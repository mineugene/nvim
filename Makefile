LUAFILES=init.lua lua/

all:
	nvim --headless -c "autocmd User PackerComplete quitall" -c "PackerSync"

clean:
	/usr/bin/rm plugin/packer_compiled.lua

lint:
	@luacheck ${LUAFILES}

.PHONY: all clean lint
.DEFAULT_GOAL:=all
