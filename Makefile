chrome_bin = chrome
chromium_bin = chromium

Arc-Darker.crx: $(shell find Arc-Darker -type f)
	chrome="$(chrome_bin)"; \
	if ! which "$$chrome" >/dev/null 2>/dev/null; then \
		chrome="$(chromium_bin)"; \
		if ! which "$$chrome" >/dev/null 2>/dev/null; then \
			echo "Chrome/Chromium not found. Please specify:" >&2; \
			echo >&2; \
			echo "  make chrome_bin=<path>" >&2; \
			echo >&2; \
			exit 1; \
		fi; \
	fi; \
	key_opt=; test ! -f Arc-Darker.pem || key_opt="--pack-extension-key=Arc-Darker.pem"; \
	test -n "$$key_opt" && echo -n "Building $@ with existing key..." || echo -n "Building $@ with NEW key..."; \
	"$$chrome" --pack-extension=Arc-Darker $$key_opt; \
	echo "done."

clean:
	test ! -f Arc-Darker.crx || rm Arc-Darker.crx

SHELL = /bin/bash
.SILENT:
