full: clean build run-app run-tests cleanup

clean:
	@docker stop bgis-test || true
	@docker stop bgis-tmp || true
	@docker stop bgis-selenium-server || true
	@docker rm bgis-test || true
	@docker rm bgis-tmp || true
	@docker rm bgis-selenium-server || true
build:
	@docker build -t bgis-img .
run-app:
	@docker run -d	--name bgis-tmp bgis-img
run-tests:
	@docker run -d --name bgis-selenium-server --link bgis-tmp selenium/standalone-firefox
	@docker run -dit --name bgis-test --link bgis-selenium-server bgis-img bash
	@docker exec bgis-test npm test || true
	@rm test_report.xml || true
	@docker exec bgis-test bash -c 'cat test_reports/*' >> test_report.xml
cleanup:
	@docker rmi $$(docker images -q) || true
	@docker stop bgis-test || true
	@docker stop bgis-tmp || true
	@docker stop bgis-selenium-server || true
