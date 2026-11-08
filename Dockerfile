# Build environment for NickelHardcover: the Qt 6 Kobo toolchain plus Rust (for the CLI), resvg (icons) and mise (tasks).
# Build the toolchain image first: `mise run toolchain::build`.
ARG TOOLCHAIN=nickelhardcover-qt6-toolchain
FROM ${TOOLCHAIN}

ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH \
    CARGO_TARGET_ARM_UNKNOWN_LINUX_GNUEABIHF_LINKER=arm-linux-gnueabihf-gcc-11 \
    CC_arm_unknown_linux_gnueabihf=arm-linux-gnueabihf-gcc-11 \
    NH_QT_MAJOR=6

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path --profile minimal --target arm-unknown-linux-gnueabihf && \
    cargo install cargo-binstall && \
    cargo binstall -y mise resvg && \
    mkdir /.local /.cache && \
    chmod -R a+w $RUSTUP_HOME $CARGO_HOME /.local /.cache
