# Qt 6 toolchain for Kobo firmware 5.18+ / 6.x

A cross toolchain (GCC 11 plus Kobo's Qt 6.5.2 `qtbase`) used to build the NickelHardcover plugin for Qt 6 based
Kobo firmware. The Qt 5 counterpart is [NickelTC](https://github.com/pgaskin/NickelTC).

These files were copied unmodified from the `toolchain/qt6` directory of
[Nickelite](https://github.com/open-source-arena/Nickelite) (commit `8a80a5e2f0cc2e16c1f25ffea64b77967bf3f992`),
which is MIT licensed — see [LICENSE](LICENSE). The Qt patches in `source/` contain third-party code with their own
terms; see [source/NOTICE](source/NOTICE) and [source/LICENSES](source/LICENSES).

Build it with `mise run toolchain::build` from the repository root, or directly:

```sh
docker build -t nickelhardcover-qt6-toolchain toolchain/qt6
```

It compiles Qt from source, so expect it to take 30-60 minutes and a few GB of disk.
