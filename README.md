# vim-osx-auto-ime
Switch input source automatically in vim for osx, modified from [vim-osx-ime](https://github.com/hongqn/vim-osx-ime).

Original **vim-osx-ime** has bad performance because each time you `esc` to normal mode, ime switcher tool is invoked once, you will feel apparent lag in heavy editing.
In contrast, **vim-osx-auto-ime** use **karabiner**, the virutal key modifier to switch IME back to US by default when you `esc` to normal mode, and you will not feel lag any more.

## Features
* When vim switches to insert mode:

  * If the character before cursor is a Chinese character, switch to Chinese
    IME and put it in Chinese mode.

  * If the character before cursor is an English character, switch to Chinese
    IME and put it in English mode.

* Switch English IME whenever vim switchs to normal mode.

## How to install
- checkout rep together with submodules
    ```
    git submodule update --init --recursive
    ```
- build and install issw
    ```
    cd input-source-switcher
    mkdir build && cd build
    cmake ..
    make
    make install
    ```
# install karabiner
    ```
    brew cask install karabiner
    cp karabiner.xml ~/Library/Application Support/Karabiner/private.xml
    ```

# rehash for zsh to recognize issw
    ```
    rehash
    ```
