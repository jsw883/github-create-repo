# github-create-repo install

HOME=/home/jsw65
FUNCTION_NAME=github-create-repo
DEFAULTS_NAME=.github-repo-defaults
BIN_PATH=/usr/local/bin

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

	cp -a $(DEFAULTS_NAME) $(HOME)/$(DEFAULTS_NAME)

uninstall:
	rm -rf $(BIN_PATH)/$(FUNCTION_NAME).sh $(BIN_PATH)/$(FUNCTION_NAME)
	rm -rf $(HOME)/$(DEFAULTS_NAME)