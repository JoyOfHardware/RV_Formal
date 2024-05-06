# About

Some baremetal experiments using the Rust Toolchain.

# Dependencies

Use `resources/build_gcc.sh` to install the powerpc binutils toolchain.

# Building

cargo build --target=powerpc64le-unknown-linux-gnu --release

# Inspecting

This section is incomplete. Need to add commands to view
disassembled binary.

``powerpc64le-linux-gnu-objdump -t target/powerpc64le-unknown-linux-gnu/release/bare_metal_powerpc64 | grep "_start"``