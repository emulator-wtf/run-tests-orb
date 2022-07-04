EW_BIN="$HOME/.cache/emulator-wtf/ew-cli"

"$EW_BIN" --version

args=($EW_BIN)

if [[ ! -z "$APP_APK" ]]; then
    args+=("--app" "$APP_APK")
fi

if [[ ! -z "$TEST_APK" ]]; then
    args+=("--test" "$TEST_APK")
fi

if [[ ! -z "$OUTPUTS_DIR" ]]; then
    args+=("--outputs-dir" "$OUTPUTS_DIR")
fi

if [[ ! -z "$DEVICES" ]]; then
    for device in $(echo $DEVICES | xargs); do
        args+=("--device" "$device")
    done
fi

if [[ "$USE_ORCHESTRATOR" == "true" ]]; then
    args+=("--use-orchestrator")
fi

if [[ "$CLEAR_PACKAGE_DATA" == "true" ]]; then
    args+=("--clear-package-data")
fi

if [[ "$WITH_COVERAGE" == "true" ]]; then
    args+=("--with-coverage")
fi

if [[ ! -z "$ADDITIONAL_APKS" ]]; then
    while IFS= read -r line ; do
        apk=$(echo "$line" | xargs)
        args+=("--additional-apks" "$apk")
    done <<< "$ADDITIONAL_APKS"
fi

if [[ ! -z "$ENVIRONMENT_VARIABLES" ]]; then
    args+=("--environment-variables" "$ENVIRONMENT_VARIABLES")
fi

if [[ ! -z "$NUM_UNIFORM_SHARDS" ]]; then
    if [[ "$NUM_UNIFORM_SHARDS" != "0" ]]; then
        args+=("--num-uniform-shards" "$NUM_UNIFORM_SHARDS")
    fi
fi

if [[ ! -z "$NUM_SHARDS" ]]; then
    if [[ "$NUM_SHARDS" != "0" ]]; then
        args+=("--num-uniform-shards" "$NUM_SHARDS")
    fi
fi

if [[ ! -z "$DIRECTORIES_TO_PULL" ]]; then
    while IFS= read -r line ; do
        dirtopull=$(echo "$line" | xargs)
        args+=("--directories-to-pull" "$dirtopull")
    done <<< "$DIRECTORIES_TO_PULL"
fi

# execute
"${args[@]}"