return {
    cmd = {
        "arduino-language-server",
        "-cli",
        "/usr/bin/arduino-cli",
        "-cli-config",
        "~/.arduino15/arduino-cli.yaml",
        "-fqbn",
        "esp32:esp32:nodemcu-32s",
    },
}
