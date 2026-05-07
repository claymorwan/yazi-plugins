# shell.yazi

A [yazi](https://github.com/sxyazi/yazi) for a better shell integration to run commands using your shell in order to enable your aliases and zsh plugins in the shell input box.
Based on [this](https://github.com/sxyazi/yazi/issues/1206#issuecomment-2188759899) script with some tweaks of mine.
Works with bash/zsh, fish and nushell, untested on other shells and can possibly break.

## Installation
### Install plugin
```bash
ya pkg add claymorwan/yazi-plugins:shell
```
### Setup keymaps
Add this to your `keymaps.toml` file:
```toml
prepend_keymap = [
	# Shell plugin
	{ on = [ ":" ], run = "plugin shell block", desc = "Run a shell command with your shell (block until finishes)" },
	{ on = [ ";" ], run = "plugin shell noblock", desc = "Run a shell command with your shell" },
	{ on = [ "!" ], run = "plugin shell noskip", desc = "Run a shell command with your shell (block until finishes and when return key is pressed)" },
]
```

## Usage
Works like the usual shel block command:
- press `;` for shell commands
- press `:` for shell commands (as block)
- press `!` for shell commands (as block, will immeditaly skip and close after running the command)

### Skipping stuff in your shell config file
If you have stuff that runs when loading your shell (like a neofetch for example) you probably don't want it to run when using this plugin.
You can put these commands in a condition with the `YAZI_SHELL_SKIP_CMD` variable:

- For bash/zsh
```bash
if [[ "$YAZI_SHELL_SKIP_CMD" != true ]]; then
  fastfetch
file
```

- For fish
```fish
if test "$YAZI_SHELL_SKIP_CMD" != true
  fastfetch
end
```

- For nushell
```nu
if not ($env.YAZI_SHELL_SKIP_CMD? | default false | into bool) {
  fastfetch
}
```
