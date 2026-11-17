# leggrowm-mini NixOS configuration

This repository defines one NixOS host, `leggrowm-mini`, for a Lenovo IdeaPad
3 (81W4) with an AMD Ryzen 3 4300U, integrated AMD graphics, Qualcomm Wi-Fi,
and one NVMe drive.

## Included

- one normal user: `leggrowm`;
- Hyprland desktop, Fish, Neovim and development tools;
- Throne GUI client, with no system-wide proxy configured;
- PostgreSQL, OpenSSH and Avahi;
- AMD graphics, Bluetooth, touchpad, PipeWire and power-management settings.

Throne subscription URLs, profiles, and credentials are deliberately not stored
in this repository. Configure them in the Throne GUI after installation.

## Installation

Follow the beginner-friendly Russian guide in
[`INSTALL.ru.md`](./INSTALL.ru.md). It includes backup, USB creation, BIOS,
disk verification, installation, first login, and Throne setup.
