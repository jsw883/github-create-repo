# Makefile for github-create-repo install

include Makefile.config

help:
	@echo "[$(FUNCTION_NAME) make]"
	@echo "USAGE: make [ install uninstall ]"
	@echo "  install    makes .github-create-repo.sh executable and globally"
	@echo "             accessible and makes .github-repo-defaults available"
	@echo "  uninstall  undoes everything"

install:
	cp github-create-repo.sh $(BIN_PATH)/$(FUNCTION_NAME).sh
	chmod +x $(BIN_PATH)/$(FUNCTION_NAME).sh
	ln -s $(BIN_PATH)/$(FUNCTION_NAME).sh $(BIN_PATH)/$(FUNCTION_NAME)

	cp -a $(DEFAULTS_NAME) $(HOME_PATH)/$(DEFAULTS_NAME)

uninstall:
	rm -rf $(BIN_PATH)/$(FUNCTION_NAME).sh $(BIN_PATH)/$(FUNCTION_NAME)
	rm -rf $(HOME_PATH)/$(DEFAULTS_NAME)