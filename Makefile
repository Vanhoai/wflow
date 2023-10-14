setup-dev:
	./scripts/setup.sh dev

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

push:
	git add .
	git commit -m "$(m)"
	git push

analyze:
	flutter analyze

push:
	git add .
	git commit -m "$(m)"
	git push
	
generate:
	dart run build_runner build --delete-conflicting-outputs

run:
	@echo "Running app..."
	@flutter run --debug
	@echo "App is running..."
	