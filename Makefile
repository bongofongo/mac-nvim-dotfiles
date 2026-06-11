NVIM ?= nvim
ROOT := $(CURDIR)

.PHONY: test lint test-specs test-startup health

test: lint test-specs test-startup

# Syntax-check all Lua files (no execution).
lint:
	@$(NVIM) -l tests/check_syntax.lua $(ROOT)

# Validate lazy.nvim plugin spec files.
test-specs:
	@$(NVIM) -l tests/check_specs.lua $(ROOT)

# Boot the full config headless; fail on any startup error output.
test-startup:
	@err=$$($(NVIM) --headless '+qall!' 2>&1 >/dev/null); \
	if [ -n "$$err" ]; then \
		echo "FAIL startup produced errors:"; \
		echo "$$err"; \
		exit 1; \
	fi; \
	echo "startup: OK"

# Run :checkhealth for lazy.nvim (informational, not part of `make test`).
health:
	@$(NVIM) --headless "+checkhealth lazy" "+%print" +qa! 2>&1
