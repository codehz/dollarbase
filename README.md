# $base

A Objective-C runtime for easily creating scripting language, all built-in symbol starting with '$' to avoid name collision.

Currently only intended to be used with cosmopolitan libc and it GCC's objective-c implementation (hope they won't removed in future).

## Usage

1. First, you need setup a proper development environment with cosmopolitan libc with objective-c enabled.
2. Run make add files(*.a, *.h) to include path and library path.
3. You need to use `-fconstant-string-class=\$String` to compile your program