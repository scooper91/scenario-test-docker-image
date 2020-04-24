.SILENT:
.ONESHELL:

TEST_CONTAINER=scenario-tests

define STOP_CONTAINERS
EXIT_STATUS=$$?
docker rm -f $(TEST_CONTAINER)
exit $$EXIT_STATUS
endef

test:
	docker run --privileged --name $(TEST_CONTAINER) \
		-v $$PWD/test:/test -v $$PWD/Dockerfile:/scenarios/Dockerfile \
		-w /test -d docker:dind
	docker exec $(TEST_CONTAINER) sh -eou pipefail -c '\
			apk add ruby ruby-etc ruby-io-console ruby-json; \
			gem install bundle; \
			bundle install; \
			bundle exec rspec'
	$(STOP_CONTAINERS)
.PHONY: test
