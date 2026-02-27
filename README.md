# llvm-util

A command-line build utility for LLVM and GCC development. Provides a unified
interface for common tasks like building, testing, debugging, and formatting
across both projects.

## Setup

Add the main script to your `PATH` with a short alias:

```sh
ln -s /path/to/llvm-util/main ~/bin/lu
```

Then run commands from anywhere inside your `llvm-project` or `gcc` source tree:

```sh
cd ~/llvm-project
lu build clang
lu test clang/test/Sema/
lu run clang --version
```

## Project Detection

The tool automatically detects which project you're working in:

- **LLVM** — walks up from the current directory looking for a directory named
  `llvm-project`. Falls back to `~/llvm-project/`.
- **GCC** — if the current directory is under a tree containing `gcc/BASE-VER`,
  execution is automatically rerouted to `gcc-util`.

You can override detection by setting `LLVM_PROJECT_ROOT` or `GCC_PROJECT_ROOT`.

## LLVM Subcommands

| Subcommand  | Description |
|-------------|-------------|
| `build [targets...]` | Incremental build with ninja. Runs `rebuild` automatically if no build directory exists. |
| `rebuild [targets...]` | Clean build — removes `build/`, runs CMake, then builds. |
| `clean` | Remove the build directory. |
| `check <target> [targets...]` | Run test suites (`check-clang`, `check-llvm`, etc.). |
| `check-cxx` | Run the libc++ test suite via `llvm-lit`. |
| `test <paths...>` | Run specific tests with `llvm-lit`. |
| `run <binary> [args...]` | Build and execute a binary from `build/bin/`. |
| `debug <binary> [args...]` | Build and launch a binary under `lldb`. |
| `show-path <binary>` | Print the absolute path to a built binary. |
| `format` | Format the last commit's changes with `clang-format-diff`. |

Every subcommand supports `-h` / `--help`.

### Build Configuration

On first `rebuild`, if no `build-config` file exists in the project root, the
default configuration is copied from `default-build-config`. This file contains
one CMake variable per line (e.g. `CMAKE_BUILD_TYPE=Debug`), which are passed
to CMake as `-D` flags.

Default configuration highlights:
- Compiler: `clang` / `clang++` with `lld`
- Build type: `Debug` with assertions enabled
- Projects: `clang`, `clang-tools-extra`, `lld`
- Runtimes: `libcxx`, `libcxxabi`, `libunwind`
- Target: `X86`

## GCC Subcommands

When working inside a GCC source tree, the same commands are available with
GCC-appropriate behavior:

| Subcommand  | Description |
|-------------|-------------|
| `build [targets...]` | Incremental build. Uses ninja (CMake) or make (autotools). |
| `rebuild [targets...]` | Clean build with CMake or autotools configure. |
| `clean` | Remove the build directory. |
| `check <target> [targets...]` | Run test suites (`check-gcc`, `check-g++`, etc.). |
| `test <paths...>` | Run specific tests with dejagnu. |
| `run <binary> [args...]` | Build, install, and execute a binary. |
| `debug <binary> [args...]` | Build and launch a binary under `gdb`. |
| `show-path <binary>` | Print the path to an installed binary. |
| `format` | Format the last commit's changes with `clang-format-diff`. |
| `install-deps` | Install build dependencies (Fedora/RHEL). |
| `save-tests <label>` | Save `.sum` test result files with a label. |
| `compare-tests <before> <after>` | Compare two saved test snapshots. |

### GCC Build System Detection

- If `gcc-cmake/` exists in the GCC source tree, CMake+Ninja is used.
- Otherwise, autotools (`configure` + `make`) is used.

GCC binaries are installed to `$GCC_PROJECT_ROOT/install/` and executed from
there by `run`, `debug`, and `show-path`.
