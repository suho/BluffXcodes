# BluffXcodes

A command line tool to help developers work with multiple Xcode versions by creating symbolic links that "bluff" the system about which Xcode version is being used. This is particularly useful when you need to use an older Xcode version while maintaining compatibility with newer macOS requirements.

## Prerequisites

- macOS Sonoma (14.0) or later
- At least 2 Xcode versions installed
  - One must be compatible with macOS Sonoma
- `Full Disk Access` permission granted to your terminal application (Terminal, iTerm2, Warp, etc.)

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

3. Usage
Simply run the command in your terminal:

```bash
bluffxcodes
```

The tool will automatically:

1. Detect your installed Xcode versions
2. Create necessary symbolic links to enable compatibility
3. Display the results of the operation

## Contributing
Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (git checkout -b feature/AmazingFeature)
3. Commit your changes (git commit -m 'Add some AmazingFeature')
4. Push to the branch (git push origin feature/AmazingFeature)
5. Open a Pull Request

## Credits
- Inspired by discussions in the [iOS Developers Slack](https://ios-developers.slack.com/) community.
- Special thanks to @aaronpearce for the original idea.

## License

This project is licensed under the MIT License - see the [LICENSE](./LICENSE) file for details.
