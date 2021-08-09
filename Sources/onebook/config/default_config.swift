func returnDefaultConfig() -> String {
    let defaultConfig = """
    # A default configuration file for onebook written in TOML

    [import]
    # Import subcommand settings
    default_browsers = [
      "chromium",
      # "chrome",
      # "firefox",
      # "safari",
      # "qutebrowser"
    ]

    [export]
    # Export subcommand settings
    default_browsers = [
      "chromium",
      "chrome",
      "firefox",
      "safari",
      "qutebrowser"
    ]

    [sync]
    # Sync subcommand settings
    default_browsers = [
      "chromium",
      "chrome",
      "firefox",
      "safari",
      "qutebrowser"
    ]
    """
    return defaultConfig
}
