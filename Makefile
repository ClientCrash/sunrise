INSTALL_DIR=/usr/local/bin
SCRIPT=sunrise
INSTALL_PATH=$(INSTALL_DIR)/$(SCRIPT)

.PHONY: install
install:
	chmod +x $(SCRIPT)
	cp $(SCRIPT) $(INSTALL_PATH)

.PHONY: uninstall
uninstall:
	rm -f $(INSTALL_PATH)
