V := $(shell grep VERSION src/trainsim-helper/Config.h | cut -d\" -f 2)
DIR := trainsim-helper-$(V)

all: release

release:
	@echo Generating release package $(V)
	cp -r main $(DIR)
	cp src/Release/trainsim-helper.exe $(DIR)
	cp src-lua-out/bin/Release/Lua_Out_Editor.exe $(DIR)/trainsim-helper-tools/trainsim-helper-lua-out.exe
	cp src-data-extractor/bin/Release/Data_Extractor.exe $(DIR)/trainsim-helper-tools/trainsim-helper-data-extractor.exe
	rm -f $(DIR).zip
	zip -r $(DIR).zip $(DIR)
	rm -rf $(DIR)
