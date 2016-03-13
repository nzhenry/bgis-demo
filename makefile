ci: remove-containers build-image startup-app run-tests remove-unused-images stop-containers

cd: ci deploy

remove-containers:	
	@docker rm bgis-test || true
	@docker rm bgis-tmp || true
	@docker rm bgis-selenium-server || true
build-image:
	@docker build -t bgis-img .
startup-app:
	@docker run -d	--name bgis-tmp bgis-img
run-tests:
	@docker run -d --name bgis-selenium-server --link bgis-tmp selenium/standalone-firefox
	@docker run -dit --name bgis-test --link bgis-selenium-server bgis-img bash
	@docker exec bgis-test npm test || true
	@docker exec bgis-test bash -c 'cat test_reports/*.xml' > test_report.xml
remove-unused-images:
	@docker rmi $$(docker images -q) || true
stop-containers:
	@docker stop bgis-test || true
	@docker stop bgis-tmp || true
	@docker stop bgis-selenium-server || true
deploy:
	@docker stop bgis || true
	@docker rm bgis || true
	@docker run -d --name bgis -e VIRTUAL_HOST=bgis.livehen.com -e VIRTUAL_PORT=9000 bgis-img
