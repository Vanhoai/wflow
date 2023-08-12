setup-dev:
	./scripts/setup.sh dev

setup-prod:
	./scripts/setup.sh prod

build-dev:
	make setup-dev
	./scripts/build.sh dev

build-aab:
	make setup-prod
	./scripts/build.sh release aab

build-apk:
	make setup-prod
	./scripts/build.sh release apk

analyze:
	flutter analyze