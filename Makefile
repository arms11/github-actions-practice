# Define the name of the Docker image
IMAGE_NAME := arms11/builder
SAMPLE_IMAGE := arms11/stock-alert

pull_sample:
  @docker pull $(SAMPLE_IMAGE)

pull:
	@docker pull $(IMAGE_NAME)

lint:
	@docker run -v $(pwd):/app \
		-w /app $(IMAGE_NAME) \
		pylint $(find . -name "*.py" | xargs)

Test:
	@docker run -v $(pwd):/app \
		-w /app $(IMAGE_NAME) pytest
