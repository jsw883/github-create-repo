# Makefile for github-create-repo install

include Makefile.config

help:
	@echo "[$(COMMAND_NAME) make]"
	@echo "USAGE: make [ install uninstall ]"
	@echo "  install    makes .github-create-repo.sh executable and globally"
	@echo "             accessible and makes .github-repo-defaults available"
	@echo "  uninstall  undoes everything"

install:
	cp github-create-repo.sh $(BIN_PATH)/$(COMMAND_NAME).sh
	chmod +x $(BIN_PATH)/$(COMMAND_NAME).sh
	ln -s $(BIN_PATH)/$(COMMAND_NAME).sh $(BIN_PATH)/$(COMMAND_NAME)

	cp -a .github-repo-defaults $(HOME_PATH)/.github-repo-defaults

uninstall:
	rm -rf $(BIN_PATH)/$(COMMAND_NAME).sh $(BIN_PATH)/$(COMMAND_NAME)
	rm -rf $(HOME_PATH)/.github-repo-defaults