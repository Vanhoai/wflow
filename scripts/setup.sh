#!/usr/bin/env bash

MODE=$1

setup_dev () {
    yes | cp -rf configs/dev/.env .env
    yes | cp -rf configs/dev/google-services.json android/app/google-services.json
    yes | cp -rf configs/dev/GoogleService-Info.plist ios/Runner/GoogleService-Info.plist
}

setup_prod () {
    yes | cp -rf configs/prod/.env .env
    yes | cp -rf configs/prod/google-services.json android/app/google-services.json
    yes | cp -rf configs/prod/GoogleService-Info.plist ios/Runner/GoogleService-Info.plist
}

setup () {
    if [ "$MODE" == "dev" ]; then
        echo "Setting up dev environment"
        setup_dev
        echo "Set up dev successfully"
    elif [ "$MODE" == "prod" ]; then
        echo "Setting up prod environment"
        setup_prod
        echo "Set up prod successfully"
    else
        echo "Invalid mode"
    fi
}

setup