#!/usr/bin/env bash

MODE=$1 # dev or release
FILE=$2 # aab or apk

buildAab="flutter build appbundle --release"
buildApk="flutter build apk --release"
buildDebug="flutter build apk --debug"
cleanAndroid="cd android && ./gradlew clean && cd .."

build_dev () {
    eval $cleanAndroid
    eval $buildDebug
}

build_release () {
    eval $cleanAndroid
    
    if [ "$FILE" == "aab" ]; then
        eval $buildAab
    elif [ "$FILE" == "apk" ]; then
        eval $buildApk
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