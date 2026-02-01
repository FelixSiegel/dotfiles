# My (catppuccin themed) desktop setup

## Setup

> [!NOTE]
> If you search for cool looking catppuccin wallpapers, check out <https://github.com/orangci/walls-catppuccin-mocha>.

* **[fastfetch](https://github.com/fastfetch-cli/fastfetch)**:
  * Installation: `sudo dnf in fastfetch`
  * Config: `.config/fastfetch/config.jsonc` (Also requires image as logo)
* **[hyprland](https://hypr.land/)**:
  * Installation:
    * Fedora 43+: (see <https://blog.burkert.me/posts/fedora_43_hyprland/?utm_source=chatgpt.com>)

      ```bash
      sudo dnf copr enable sdegler/hyprland
      sudo dnf in hyprland hyprpolkitagent hyprpaper hyprsunset hyprtoolkit hyprlauncher
      ```

    * Fedora 42 and below use the following COPR instead: <https://copr.fedorainfracloud.org/coprs/solopasha/hyprland/>
  * Dependencies:
    * [`hyprland-virtual-desktops`](https://github.com/levnikmyskin/hyprland-virtual-desktops) (for virtual desktops like in KDE):
      * Installation: Requires hyprm:

        ```bash
        sudo dnf in hyprland-devel
        hyprpm update
        hyprpm add https://github.com/levnikmyskin/hyprland-virtual-desktops
        hyprpm list # to see installed packages, use exact name for following enable command
        hyprpm enable virtual-desktops
        hyprpm reload
        ```

      * Note: If not using this plugin, remove the relevant keybinds from the `hyprland/hyprland.conf` file.
    * [`ashell`](https://malpenzibo.github.io/ashell/):
      * Installation: currently not available in Fedora 43 repos, so build from source:

        ```bash
        # Make sure C toolchain is installed
        sudo dnf install clang clang-devel glibc-headers glibc-devel pkgconf pipewire-devel
        # Install dependencies
        sudo dnf in wayland-protocols-devel wayland-devel libxkbcommon-devel dbus-devel pipewire-devel pulseaudio-libs-devel
        # Clone and build
        git clone https://github.com/MalpenZibo/ashell.git
        cd ashell
        git checkout 0.7.0 # (adjust version as needed)
        cargo build --release
        # Install system-wide
        sudo cp target/release/ashell /usr/local/bin/ashell # Remove later when available in repos
        ```

    * [`Catppuccin-Custom-Cursors`](https://github.com/catppuccin/cursors):
      * Installation see instructions in the repo.
  * Config:
    * Copy hyprland config files at `~/.config/hypr/` and ashell config at `~/.config/ashell/`
    * Configure monitors in `~/.config/hypr/hyprland.conf` under the `monitor` section (see <https://wiki.hypr.land/Configuring/Monitors/>)
    * Configure wallpapers in `~/.config/hypr/hyprpaper.conf` (see <https://wiki.hypr.land/Hypr-Ecosystem/hyprpaper/>)
    * Configuring cursor size and theme in `~/.config/hypr/hyprland.conf` under the `environment` section. E.g., `env = XCURSOR_SIZE,24` and `env = XCURSOR_THEME,Catppuccin-Mocha-Blue-Cursors` such as `env = HYPRCURSOR_THEME,Catppuccin-Mocha-Blue-Cursors` and `env = HYPRCURSOR_SIZE,24`
    * Autostart applications can be added in `~/.config/hypr/hyprland.conf` under the `Autostart` section using the `exec =` directive
    * For papirus folder themes, see <https://github.com/catppuccin/papirus-folders>
* **[neovim](https://neovim.io/)**:
  * Installation: `sudo dnf in nvim`
  * Config: `.config/nvim/`
  * Plugins: Managed with [lazy.nvim](https://github.com/folke/lazy.nvim)
    * [blink.cmp](https://github.com/Saghen/blink.cmp): Completion plugin
    * [catppuccin/nvim](https://github.com/catppuccin/nvim): Theme plugin
    * [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter): Syntax highlighting and code parsing
    * [conform.nvim](https://github.com/stevearc/conform.nvim): Code formatting
    * [fzf-lua](https://github.com/ibhagwan/fzf-lua): Fuzzy finder
      * Requires `fzf`, `fd` and `rg` installed: `sudo dnf in fzf fd-find ripgrep`
    * [indent-o-matic](https://github.com/Darazaki/indent-o-matic): Automatic indentation detection
    * [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim): Indentation lines
    * [mason.nvim](https://github.com/mason-org/mason.nvim): LSP/DAP/Formatter installer
    * [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim): Statusline
    * [luasnip](https://github.com/L3MON4D3/LuaSnip): Snippet engine
      * Snippets inside `snippets/` folder (currently only for LaTeX)
    * [oil.nvim](https://github.com/stevearc/oil.nvim): File explorer
    * [presence.nvim](https://github.com/andweeb/presence.nvim): Discord Rich Presence integration
    * [rustaceanvim](https://github.com/mrcjkb/rustaceanvim): Rust development setup
    * [vimtex](https://github.com/lervag/vimtex): LaTeX support
      * Requires `latexmk` and a LaTeX distribution installed (e.g., `texlive-scheme-full`). And also a PDF viewer like `zathura`: `sudo dnf in zathura` (lowkey best PDF viewer out there, see below for configuration)
    * [which-key.nvim](https://github.com/folke/which-key.nvim): Keybinding popup
  * Keybindings in `~/.config/nvim/lua/keymappings.lua` (Leader key is set to Space)
  * options in `~/.config/nvim/lua/options.lua`
* [zathura](https://pwmt.org/projects/zathura/):
  * Installation: `sudo dnf in zathura zathura-pdf-mupdf zathura-djvu`
  * Config: `.config/zathura`
    * Theme matches Catppuccin Mocha, see <https://github.com/catppuccin/zathura> (Make sure to set `set recolor-keephue true` to keep the colors accurate)

## Disclaimer

This setup is tailored to my personal preferences and workflow. Feel free to adapt and modify it to suit your own needs and tastes! The images in the image folder are not from me, credits to respective owners. If you own any of the images and want them removed, please contact me and I will remove them.
