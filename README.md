This repository is intended to be checked out as `~/.vim` on linux-like systems
or `%HOME%\vimfiles` for Windows.  Clone recursively, or open a command prompt
within the cloned directory to run `git submodule update --init --recursive`,
to pull in the plugin directories.

The configured plugins are 
* [vim-maktaba](https://github.com/google/vim-maktaba), which provides a
  "standard library" of methods used by other plugins.
* [vim-codefmt](https://github.com/google/vim-codefmt), which provides on-save
  hooks for auto-formatting code.  Currently only `gofmt` (for golang) and
  `buildifier` are enabled because I spend too much time editing legacy code
  where `clang-format`, `autopep8`, or `js-beautify` would cause a distracting
  number of off-target changes.  Re-enabling them is a matter of uncommenting
  the appropriate line in [`vimrc`](vimrc).
* [vim-go](https://github.com/fatih/vim-go) provides more extensive integration
  with various golang refactoring tools (such as `goimports` and `gopls`).
* [YouCompleteMe](https://github.com/ycm-core/YouCompleteMe) provides more
  extensive code completion options.  In order to use it, it must be built.
  Instructions for how I built it follow below.

## Martian syntax
The martian [ftdetect](ftdetect/martian.vim) is pretty strightforward.  The
[syntax highlighting](syntax/martian.vim) file is a private development fork
of the one [provided in the martian repository][martian-vim].

[martian-vim]: https://github.com/martian-lang/martian/tree/master/tools/syntax/vim

## Building ycmd
If using this on Windows, I'd advise just skipping YCM by deleting the
submodule.  If you want the things it provides on Windows you're probably
better off just using VsCode.

For reasons I'd rather not get into here, I build ycmd against a
[crosstool][]-built sysroot with [clang][].  I also used a version of `python`
from [miniconda][] rather than the system-provided distribution.

[clang]: http://clang.llvm.org/
[crosstool]: https://github.com/crosstool-ng/crosstool-ng
[miniconda]: https://docs.conda.io/en/latest/miniconda.html

```bash
# Supply your own locations for these
$ export MINICONDA=$HOME/miniconda
$ export LLVM=$TOOLCHAINS/versions/latest/tools/clang
$ cd ~/
$ mkdir ycm_build
$ cd ycm_build
# Build ycm_core
$ cmake -GNinja \
        -DPYTHON_LIBRARY=$MINICONDA/lib/libpython2.7.so \
        -DPYTHON_INCLUDE_DIR=$MINICONDA/include/python2.7 \
        -DEXTERNAL_LIBCLANG_PATH=$LLVM/lib/libclang.so \
        -DUSE_CLANG_TIDY=ON \
        ~/.vim/pack/plugins/start/YouCompleteMe/third_party/ycmd/cpp
$ cmake --build . --target ycm_core --config Release
$ cd ..
# Build plugins
$ mkdir regex_build
$ cd regex_build
$ cmake -GNinja \
        -DPYTHON_LIBRARY=$MINICONDA/lib/libpython2.7.so \
        -DPYTHON_INCLUDE_DIR=$MINICONDA/include/python2.7 \
        ~/.vim/pack/plugins/start/YouCompleteMe/third_party/ycmd/third_party/cregex
$ cmake --build . --target _regex --config Release
# Next, configure the golang plugins.
$ cd ~/.vim/pack/plugins/start/YouCompleteMe/third_party/ycmd/third_party/go/src/github.com/mdempsky/gocode
$ GOPATH=$HOME/.vim/pack/plugins/start/YouCompleteMe/third_party/ycmd/third_party/go go build
$ cd ../../rogpeppe/godef
$ GOPATH=$HOME/.vim/pack/plugins/start/YouCompleteMe/third_party/ycmd/third_party/go go build
# javascript
$ cd ../../../../../tern_runtime
$ npm install --production
# rust
$ cd ../racerd/
$ cargo build --release
```

At some point I'll need to update the submodule'd versions of these tools, and
with them these instructions.
