LUAFILES=init.lua lua/

all: /usr/bin/nvim
	/usr/bin/nvim --headless -c "autocmd User PackerComplete quitall" -c "PackerSync"

clean:
	/usr/bin/rm -rf plugin/

lint: /usr/bin/which /usr/bin/luacheck
	if /usr/bin/which stylua &>/dev/null; then stylua ${LUAFILES}; fi;
	@/usr/bin/luacheck ${LUAFILES}

.PHONY: all clean lint
.DEFAULT_GOAL:=all
