
#
# Environment.
#

NODE ?= node --harmony-generators

#
# Binaries.
#

BIN := ./node_modules/.bin
MOCHA := $(BIN)/mocha --harmony-generators
ESLINT := $(BIN)/eslint

#
# Server.
#

server: | node_modules
	@$(NODE) ./server

#
# Test.
#

test: | node_modules
	@$(MOCHA) --harmony ./test

#
# Lint.
#

lint: | node_modules
	@$(ESLINT) .

#
# Node Modules.
#

node_modules: package.json
	@npm install

#
# Clean.
#

distclean:
	@rm -rf node_modules

#
# Phonies.
#

.PHONY: server
.PHONY: test
.PHONY: distclean
.PHONY: lint
