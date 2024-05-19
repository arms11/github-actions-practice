# Define the name of the Docker image
IMAGE_NAME := arms11/builder
SAMPLE_IMAGE := arms11/stock-alert
CURRENT_DIR := $(shell pwd)
export ST2_EXPOSE_HTTP := 8080
export COMPOSE_INTERACTIVE_NO_CLI := 1


.PHONY: clean pull_sample pull lint test st2 cleanup

pull_sample:
	@docker pull $(SAMPLE_IMAGE)

pull:
	@docker pull $(IMAGE_NAME)

lint:
	docker run -v $(CURRENT_DIR):/app -w /app $(IMAGE_NAME) pylint $(find . -name "*.py" | xargs)

test:
	@docker run -v $(CURRENT_DIR):/app \
		-w /app $(IMAGE_NAME) pytest;

st2:
	@rm -rf st2-docker;
	@git clone https://github.com/StackStorm/st2-docker.git;
	@cd st2-docker && docker-compose up -d;

inspect:
	@cd st2-docker && docker exec -T st2-docker_st2client_1 st2 run core.echo message=hello;

cleanup:
	@cd st2-docker && docker-compose down --remove-orphans -v;
	@rm -rf st2-docker;

d: cleanup
l: lint
t: test
