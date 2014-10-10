V := $(shell grep VERSION src/trainsim-helper/Config.h | cut -d\" -f 2)
DIR := trainsim-helper-$(V)

all: release

release:
	@echo Generating release package $(V)
	cp -r main $(DIR)
	cp src/Release/trainsim-helper.exe $(DIR)
	cp src-lua-out/bin/Release/Lua_Out_Editor.exe $(DIR)/trainsim-helper-lua-out/trainsim-helper-lua-out.exe
	zip -r $(DIR).zip $(DIR)
	rm -rf $(DIR)
