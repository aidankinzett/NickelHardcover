> [!NOTE]
> This is a fork of [StrayRose/NickelHardcover](https://codeberg.org/StrayRose/NickelHardcover) that adds support for **Qt 6 based firmware (6.0)**. The original project targets the older Qt 5 firmware (4.x) and remains the right choice for those devices.

# NickelHardcover

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

[Hardcover.app](https://hardcover.app/) integration for Kobo eReaders.

This project wouldn't be possible without **StrayRose**'s original [NickelHardcover](https://codeberg.org/StrayRose/NickelHardcover), **pgaskin**'s [NickelHook](https://github.com/pgaskin/NickelHook) library, and the Qt 6 work in [NickelHook's `qt6-support` branch](https://github.com/nicoverbruggen/NickelHook/tree/qt6-support) and [Nickelite](https://github.com/open-source-arena/Nickelite).

## Supported firmware

| Firmware | Status |
| --- | --- |
| 6.0.279225 (Qt 6) | Supported. Tested on a physical device. |
| 5.x | **Not supported.** It is Qt 6 based and may work, but it has not been tested. |
| 4.x and older (Qt 5) | **Not supported by this fork.** Use the [original project](https://codeberg.org/StrayRose/NickelHardcover). |

Kobo's firmware 6.0 is currently a beta line, and Kobo warns against rolling back from it. A firmware update that replaces the system partition removes the plugin, so reinstall after updating.

<a href="screenshots/syncing.png" target="_blank"><img src="screenshots/syncing.png" alt="Syncing with hardcover" width="24.5%"></a>
<a href="screenshots/review.png" target="_blank"><img src="screenshots/review.png" alt="Reviewing book" width="24.5%"></a>
<a href="screenshots/journal.png" target="_blank"><img src="screenshots/journal.png" alt="Reading journal" width="24.5%"></a>
<a href="screenshots/new-journal.png" target="_blank"><img src="screenshots/new-journal.png" alt="New reading journal note" width="24.5%"></a>
<a href="screenshots/menu.png" target="_blank"><img src="screenshots/menu.png" alt="NickelHardcover menu" width="19.6%"></a>
<a href="screenshots/status.png" target="_blank"><img src="screenshots/status.png" alt="Reading status menu" width="19.6%"></a>
<a href="screenshots/linking.png" target="_blank"><img src="screenshots/linking.png" alt="Manually linking book" width="19.6%"></a>
<a href="screenshots/linking-edition.png" target="_blank"><img src="screenshots/linking-edition.png" alt="Manually linking edition" width="19.6%"></a>
<a href="screenshots/settings.png" target="_blank"><img src="screenshots/settings.png" alt="Settings" width="19.6%"></a>

## Features

- Automatically update reading progress on Hardcover.app
- Automatically sync Kobo annotations (highlights and notes) to your Hardcover.app journal
- Review and rate books
- View your Hardcover.app journal and add new entries
- Update book status

## FAQ

- **Is my device supported?**  
  It depends on your firmware, not your model. See [Supported firmware](#supported-firmware). Only one device on firmware 6.0.279225 has been tested so far; please report how it goes on yours.

- **Do I need to install NickelMenu as well?**  
  No. NickelHardcover doesn't rely on NickelMenu.

- **Why is it called NickelHardcover then?**  
  Kobo internally calls its UI Nickel. The name simply references the fact that this is a mod to the native UI.

- **Can you add support for X feature?**  
  Maybe. [Open a new issue](../../issues/new) and ask. Be sure to provide your use case.

## Installing or updating

1. Download `NickelHardcover.zip` from the newest entry on the [releases page](../../releases) (releases are currently betas, which GitHub's "latest" link skips)
2. Connect your Kobo over USB and extract the zip into the **root of the Kobo drive**, merging with the existing hidden `.kobo` and `.adds` folders. On macOS, Finder hides these folders, so use the terminal instead: `unzip -o NickelHardcover.zip -d /Volumes/KOBOeReader`
3. Eject/disconnect your Kobo, and it should install the plugin and reboot

The zip contains the plugin (`.kobo/Kobo.tgz`) and the command line helper it uses to talk to Hardcover.app (`.adds/NickelHardcover/cli`). No need to uninstall before updating. Your configuration is retained.

## Usage

While a book is open, you'll find a new menu in the top-right corner that gives access to all of NickelHardcover's features.

### Signing in

When you first open the menu, you'll see a "Sign in to Hardcover.app" menu item.

<a href="screenshots/signin.png" target="_blank"><img src="screenshots/signin.png" alt="Sign in to Hardcover.app menu item" width="600px"></a>

Tapping it brings up a dialog with a QR code.

<a href="screenshots/scan-qrcode.png" target="_blank"><img src="screenshots/scan-qrcode.png" alt="Sign in dialog" width="600px"></a>

Scan the QR code, or visit the link and enter the code, then tap continue. That's it, you're ready to use NickelHardcover!

### Linking a Hardcover book

NickelHardcover attempts to determine which book to update on Hardcover.app using the ISBN of the open book. If that fails, or you want more control, use the "Manually link book" menu option to select the book or edition yourself.

### Syncing

There are a few ways to sync reading progress and annotations with Hardcover.app:
- Manually — trigger a sync at any time with the "Sync now" menu option
- Automatically — enable auto-sync for the open book with the "Enable auto-sync" menu option

You can configure when auto-sync runs (on a schedule, when closing a book, or by read percentage) in the NickelHardcover settings.

## Uninstall

To uninstall NickelHardcover, delete the `.adds/NickelHardcover` directory and manually restart your Kobo. (This has not been verified on firmware 6.0 yet.)

## Troubleshooting

Enable debug logging in the NickelHardcover settings to write `nickelhardcover_*.log` files to `.adds/NickelHardcover` on your Kobo, and attach the relevant ones to any bug report. Redact tokens before sharing.

## Building

Builds run in Docker. The Qt 6 toolchain compiles Qt from source, so building it the first time takes a while:

```sh
mise run toolchain::build   # build the toolchain and build environment images (once)
mise run build              # produces NickelHardcover.zip
```

Other tasks, such as `mise run install` (copy to a Kobo over SSH), are listed by `mise tasks`. The plugin is built with a [NickelHook](https://github.com/nicoverbruggen/NickelHook/tree/qt6-support) fork that adds Qt 6 support, pulled in as a git submodule, so clone with `--recurse-submodules`.

The Qt 6 toolchain in [toolchain/qt6](toolchain/qt6) comes from [Nickelite](https://github.com/open-source-arena/Nickelite).
