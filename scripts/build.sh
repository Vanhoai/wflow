#!/usr/bin/env bash

MODE=$1 # dev or release
FILE=$2 # aab or apk

build_dev () {
    cd android && ./gradlew clean && cd ..
    flutter build apk --debug
}

build_release () {
    cd android && ./gradlew clean && cd ..
    
    if [ "$FILE" == "aab" ]; then
        flutter build appbundle --release
    elif [ "$FILE" == "apk" ]; then
        flutter build apk --release
    else
        echo "Invalid file"
    fi
}

build () {
    if [ "$MODE" == "dev" ]; then
        echo "Building dev environment"
        build_dev
        echo "Build dev successfully"
    elif [ "$MODE" == "release" ]; then
        echo "Building release environment"
        build_release
        echo "Build release successfully"
    else
        echo "Invalid mode"
    fi
}

build