# cosmic-term (macOS port)

This is `weefarm/cosmic-term-macos`, a macOS port of the COSMIC terminal
emulator from [pop-os/cosmic-term](https://github.com/pop-os/cosmic-term).
Upstream source is tracked on the `system76-master` branch; the `main` branch
contains the macOS port.

COSMIC terminal emulator, built using [alacritty\_terminal](https://docs.rs/alacritty_terminal) that is provided by the [alacritty](https://github.com/alacritty/alacritty) project. `cosmic-term` provides bidirectional rendering and ligatures with a custom renderer based on [cosmic-text](https://github.com/pop-os/cosmic-text).

The `wgpu` feature, enabled by default, supports GPU rendering using `glyphon`
and `wgpu`. If `wgpu` is not enabled or fails to initialize, then rendering falls
back to using `softbuffer` and `tiny-skia`.

## Building on macOS

```bash
cargo build --release
```

The default feature set is cross-platform (`wgpu`). Wayland and D-Bus dependent
features are disabled by default on this branch; on Linux you can restore the
full COSMIC desktop experience with:

```bash
cargo build --release --features linux
```

Run the terminal with:

```bash
./target/release/cosmic-term --no-daemon
```

## Packaging as a macOS app

On macOS, double-clicking the raw Unix binary in Finder opens it in `Terminal.app`.
To get a normal app that launches from Finder, Dock, or Launchpad, package it as
an `.app` bundle and copy it to `/Applications`:

```bash
cargo build --release
./package-macos.sh
cp -R target/release/cosmic-term.app /Applications/
```

The first time you open it, right-click the app and choose **Open** so macOS
allows the unsigned/ad-hoc-signed app. After that it opens like any other app.

## Branches

- `main` — macOS port (default)
- `system76-master` — unmodified upstream `pop-os/cosmic-term:master`, kept for
  GPL-3.0 source availability and easier upstream syncing

## License

This project is licensed under GPL-3.0-only, the same license as the upstream
`pop-os/cosmic-term` project.

## Color Schemes

Custom color schemes can be imported from the `View -> Color schemes...` menu item.
You can find templates for color schemes in the [color-schemes](color-schemes) folder.
