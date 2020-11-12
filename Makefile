runtime=nodejs12.x
handler=index.handler

ENV_FILE=.env
FUNC_DIR=ts-lambda-dns-monitor/js
LAYER_DIR=twitter

date:
	$(eval date_formatted := $(shell date -u "+%Y-%m-%dT%H:%M:00Z"))

.PHONY: tsc
tsc:
	cd $(PWD)/src/$(FUNC_DIR) && tsc

.PHONY: test
test: date tsc
	find opt/empty/ ! -name '.keep' -type f -exec rm -f {} + && \
	docker run --rm -v $(PWD)/src/$(FUNC_DIR):/var/task:ro,delegated -v $(PWD)/opt/$(LAYER_DIR):/opt:ro,delegated \
		--env-file $(ENV_FILE) lambci/lambda:$(runtime) ${handler} '{ "time": "$(date_formatted)" }'

.PHONY: clean
clean:
	find archive ! -name ".keep" -type f -exec rm -f {} +
