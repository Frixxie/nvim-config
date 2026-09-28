# Mac setup

An Ansible playbook based on the Homebrew packages installed on this Mac on
2026-09-28. It installs command-line tools, GUI applications, fonts, and taps.
Edit `packages.yml` to maintain the package list.

## Prepare a Mac

1. Install Apple's Command Line Tools with `xcode-select --install` if needed.
2. Install [Homebrew](https://brew.sh) and follow its shell setup instructions.
3. Install Ansible:

   ```sh
   brew install ansible
   ```

Run the following commands from this `ansible/` directory:

```sh
ansible-galaxy collection install -r requirements.yml
ansible-playbook -i localhost, mac.yml --check --ask-become-pass
ansible-playbook -i localhost, mac.yml --ask-become-pass
```

`--check` previews changes without installing packages. Some casks use macOS
installers that require an administrator password; `--ask-become-pass` prompts
for it and passes it to the cask module. Homebrew itself runs as your regular
user. Installers may also require macOS approval or a restart.

Both Apple Silicon (`/opt/homebrew`) and Intel (`/usr/local`) Homebrew locations
are supported.

## Behavior

- Re-running installs missing packages and leaves installed versions alone.
- Fresh installations use versions currently available from Homebrew; this is
  a package inventory, not a version lockfile.
- Homebrew resolves dependencies automatically. The list is based on Homebrew's
  Bundle export, which includes explicitly requested formulae even when another
  formula also depends on them.
- The explicit link for `postgresql@18` is preserved.
- Removing an entry from `packages.yml` does not uninstall it.
- Application settings, database contents, service startup, and programs
  installed outside Homebrew are not captured.

## Refresh the inventory

On the source Mac, inspect the current export:

```sh
brew bundle dump --file=-
```

Update `homebrew_taps`, `homebrew_formulae`, `homebrew_linked_formulae`, and
`homebrew_casks` in `packages.yml` from the corresponding entries. Bundle may
also include Cargo or other package-manager entries; these are outside this
playbook's Homebrew scope.
