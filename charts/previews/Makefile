
APP := $(notdir $(CURDIR))
VALUES ?= values.yaml

all: lint
	helm template -f $(VALUES) .

lint:
	helm lint .

deploy install:
	helm upgrade --install $(APP) -f $(VALUES) .

clean uninstall:
	helm uninstall $(APP)

list:
	helm list -A --all
