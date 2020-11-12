PROJECT_NAME=ts-lambda-dns-monitor
AWS_PROFILE=enigol
WS=default

.PHONY: init
init:
	cp backup.tf.bak backup.tf && \
	sed -i.bak -e "s/<project-name>/$(PROJECT_NAME)/g" backup.tf && \
	sed -i '' -e "s/<profile>/$(AWS_PROFILE)/g" backup.tf && \
	terraform init

.PHONY: fmt
.SILENT: fmt
fmt:
	terraform fmt
	@for module in $(shell ls -1 modules); \
	do \
		cd modules/$${module} && \
		terraform fmt && \
		cd ../.. ; \
	done

.PHONY: apply
apply: checkout
	terraform apply

.PHONY: checkout
checkout:
	terraform workspace select $(WS)

# .PHONY: output
# output: checkout
# 	$(eval src_bucket := $(shell \
# 		terraform output bucket_name \
# 	))
# 	$(eval dest_bucket := $(shell \
# 		terraform output errors_bucket_name \
# 	))

.PHONY: clean
clean:
	find archive ! -name ".keep" -type f -exec rm -f {} +
