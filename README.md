
# Setup

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
