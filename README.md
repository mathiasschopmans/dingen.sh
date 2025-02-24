# 📟 `dingen.sh` - The AI-Powered Command Line Sidekick

**"Dingens"** [[ˈdɪŋəns](https://de.wiktionary.org/wiki/Dingens)] — that handy German word from the Ruhr area for _"thingamajig"_ or _"whatchamacallit"_. You know, when you can’t quite remember the name of that... _dingens_.

And speaking of German words, [**"dingen"**](https://de.wiktionary.org/wiki/dingen) means _"to hire"_ or _"to delegate"_ — which is exactly what this tool does. It _hires_ your terminal as an AI-powered sidekick, ready to take on the commands you don’t want to figure out yourself.

True to its name, `dingen.sh` has your back when you’re stuck trying to remember _that_ command. It’s a smart command-line wrapper that turns your half-baked ideas into fully-formed commands—no need to Google your way through obscure flags or syntaxes.

Utilizing persisted system prompts and the power of LLMs through [`gh models`](https://github.com/github/gh-models), `dingen.sh` helps you generate and run commands with ease and build own _dingens_ by aliasing. ✨

### It features:

- ✅ Local prompt persistence for custom workflows
- ✅ Smart error handling to keep things smooth
- ✅ Clipboard integration for easy copy-pasting
- ✅ Command preview with syntax highlighting

Perfect for when you need to delegate the grunt work and focus on _real_ tasks—because even the terminal deserves an intern. 💼

By letting you define your own system prompts like the [demo home-assistant prompt](./prompts/home-assistant), `dingen.sh` adapts to your workflow, generating precise shell commands tailored to your needs. With built-in error handling and clipboard integration, it streamlines automation—turning your terminal into a powerhouse of efficiency that is _superior to other consoles_. 🕹️📺

## Example

```diff
- 💭 "Dingens, Werner, kannst du mir ma eben dat Bierchen kalt stellen? 🍻"
+ 💻 `dingen.sh ./prompts/home-assistant "stell Kühlschrank auf 6°"`
```

Wayyy to long - let's create or own _"dingens"_ by adding an alias `alias werner='dingen.sh ./prompts/home-assistant'` in our `.bashrc` or `.zshrc` and try again:

```diff
- 💭 "Dingens, Werner, stell die Heizung hoch, is ja kälter als inne Zeche hier!"
+ 💻 `werner "stell wohzimmer auf 23 grad"`
```

🌎 [Translation](https://chatgpt.com/share/67bc15f5-1e88-8011-b0ed-b856aee5568d)

## Features

- Reads a system prompt from a specified file.
- Accepts user prompts and optional parameters.
- Validates input to ensure correct usage.
- Interacts with an AI model to generate commands.
- Copies generated commands to the clipboard for easy access.
- Provides syntax highlighting for generated commands.
- Confirms execution of commands before running them.

## Usage

To use the script, run the following command in your terminal:

```
./dingens.sh <system_prompt_file> [--max-tokens <number>] <user_prompt>
```

### Arguments

- `<system_prompt_file>`: Path to the file containing the system prompt.
- `--max-tokens <number>`: (Optional) Maximum number of tokens for the AI response. Default is 100.
- `<user_prompt>`: The prompt you want to send to the AI.

### Example

```
./dingens.sh ./prompts/home-assistant "turn off lights in the living room"
```

## Dependencies

- [GitHub CLI](https://cli.github.com/): Install via `brew install gh`
- [`gh models`](https://github.com/github/gh-models) extension to be installed: `gh extension install gh/models`
- [`gh auth login`](https://cli.github.com/manual/gh_auth_login) to authenticate with GitHub.
- [`bat`](https://github.com/sharkdp/bat) for syntax highlighting: `brew install bat`
- [`jq`](https://stedolan.github.io/jq/) for JSON parsing: `brew install jq`
- Requires `pbcopy` for clipboard functionality (macOS).

## Installation

1. Clone the repository:
   ```
   git clone https://github.com/mathiasschopmans/dingen.sh.git
   ```
2. Make the script executable:
   ```bash
   chmod +x ~/path/to/dingen.sh
   ```
3. Add an alias to your `.bashrc` or `.zshrc`:
   ```bash
   alias dingens='bash ~/path/to/dingen.sh'
   ```
4. Source your `.bashrc` or `.zshrc`:
   ```bash
   source ~/.bashrc
   # or
   source ~/.zshrc
   ```
5. Install dependencies:
   ```bash
   brew install gh
   brew install bat
   brew install jq
   ```
6. Authenticate with GitHub:
   ```bash
   gh auth login
   ```
7. Install the `gh models` extension:
   ```bash
   gh extension install gh/models
   ```

### On the fly installation

Alternatively, you can "install" it on the fly by adding the following alias to your `.bashrc` or `.zshrc`:

```bash
alias dingen.sh='bash -c "$(curl -fsSL https://raw.githubusercontent.com/mathiasschopmans/dingen.sh/main/dingens.sh)"'
```

> **⚠️ Caution:** I would not recommend this for production use for performance and security reasons.

## Contributing

Contributions are welcome. Please open an issue or submit a pull request for any enhancements or bug fixes.

## The End

From [@mathiasschopmans](https://github.com/mathiasschopmans) with löve. 💌

Rheurdt York, Germany, 2025
