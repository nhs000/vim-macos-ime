# vim-osx-auto-ime
Switch input source automatically in vim for osx, modified from [vim-osx-ime](https://github.com/hongqn/vim-osx-ime), but use [issw](https://github.com/vovkasm/input-source-switcher) to switch ime.

## Features
* When vim switches to insert mode:

  * If the character before cursor is a Chinese character, switch to Chinese
    IME and put it in Chinese mode.

  * If the character before cursor is an English character, switch to Chinese
    IME and put it in English mode.

* Switch English IME whenever vim switchs to normal mode.

## How to install
- If you use `NeoBundle`, then add the following codes in your `.vimrc`.
```
  NeoBundle 'chenhouwu/vim-osx-auto-ime', {
   \  'build' : {
   \    'mac' : './install',
   \  },
   \}
```

- Or run the following command in the plugin's directory.
```
./install
```
