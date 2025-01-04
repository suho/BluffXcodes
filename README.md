# BluffXcodes

A command line tool to help developers work with multiple Xcode versions by temporarily modifying the bundle version of Xcode that "bluff" the system about which Xcode version is being used. This is particularly useful when you need to use an older Xcode version while maintaining compatibility with newer macOS requirements.

## Prerequisites

- macOS Sonoma (14.0) or later
- At least 2 Xcode versions installed
  - One must be compatible with macOS Sonoma
- Full Disk Access permission granted to your terminal application (Terminal, iTerm2, Warp, etc.)

To grant **Full Disk Access**:
1. Open **System Settings**.
2. Navigate to **Privacy & Security** > **Full Disk Access**.
3. Add your terminal application to the list of allowed apps.

## Installation

### Using Mint

```bash
mint install suho/bluffxcodes
```

### From Source
1. Clone the repository

```bash
git clone https://github.com/suho/bluffxcodes.git
```

2. Build and install

```bash
cd bluffxcodes
swift build -c release
cp -f .build/release/bluffxcodes /usr/local/bin/bluffxcodes
```

## Usage

Simply run the command in your terminal:

```bash
bluffxcodes
```

The tool will automatically:

1. Detect your installed Xcode versions.
2. Update the bundle version to enable compatibility for the selected Xcode.
3. Display the results of the operation and open the selected Xcode version.

From this point on, you can use the selected Xcode as normal (e.g., open it from the dock, Spotlight, etc.).

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## Credits
- Inspired by discussions in the [iOS Developers Slack](https://ios-developers.slack.com/) community.
- Special thanks to [@aaronpearce](https://github.com/aaronpearce) for the original idea.

## License

This project is licensed under the MIT License - see the [LICENSE](./LICENSE) file for details.
