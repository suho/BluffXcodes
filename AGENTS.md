# Agent Guidelines for BluffXcodes

## Repository Overview
- The command line tool is defined in `Sources/` with subfolders:
  - `Actions/`: core actions like `Xcode.swift`, `XcodeBluff.swift`, `XcodeSelection.swift`.
  - `Helpers/`: helper utilities (`Constants.swift`, `Error.swift`, `Picker.swift`, `Terminal.swift`).
- Images and other assets live in `Resources/`.
- `Package.swift` declares dependencies and is the entry point for building.
- Copies of the contributor rules from [agent-rules](https://github.com/steipete/agent-rules) live in the `Rules/` folder for offline reference.

## Contribution Guidelines
- Follow the **Modern Swift** best practices. See `Rules/modern-swift.md` for a local copy of the guide.
- Use the conventional commit style with emojis as described in `Rules/commit.mdc`.
  - Examples: `✨ feat:`, `🐛 fix:`, `📝 docs:`.
  - Keep commits focused and in imperative mood.
- Pull requests should provide a concise summary and follow `Rules/pr-review.mdc` perspectives.

## Validation
- Run `swift build` to ensure the project compiles. Use `swift test` if tests exist.
- If new Swift source files are added or modified, ensure they compile without errors.
- For documentation changes, no build is required but verify Markdown formatting.

## Working Notes for Agents
- Explore `README.md` for usage instructions and project goals.
- When adding documentation, follow the structure from `Rules/create-docs.mdc`.
- Keep code changes within `Sources/` unless editing documentation or resources.
- Avoid adding large dependencies without discussion.
- Use clear code and small functions following the guidelines from `Rules/implement-task.mdc`.

