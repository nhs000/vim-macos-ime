" This file is part of vim-osx-ime.
"
" vim-osx-ime is free software: you can redistribute it and/or modify
" it under the terms of the GNU General Public License as published by
" the Free Software Foundation, either version 3 of the License, or
" (at your option) any later version.

" vim-osx-ime is distributed in the hope that it will be useful,
" but WITHOUT ANY WARRANTY; without even the implied warranty of
" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
" GNU General Public License for more details.

" You should have received a copy of the GNU General Public License
" along with Foobar.  If not, see <http://www.gnu.org/licenses/>.

if exists('g:loaded_osxime')
    finish
endif
let g:loaded_osxime = 1

if !exists('g:osxime_auto_detect')
    let g:osxime_auto_detect = 1
endif

if !exists('g:osxime_insert_leave')
    let g:osxime_insert_leave = 1
endif

if !exists('g:osxime_issw_path')
    let g:osxime_issw_path = 'issw'
endif

if !exists('g:osxime_normal_ime')
    let g:osxime_normal_ime = 'com.apple.keylayout.US'
endif

" Drop due to the fact sometime it's impossible to determine 
" whether character is Japanese or Chinese
" So let user choose which input source is being used 
" by config in vimrc.
if !exists('g:kanji_mode')
    let g:kanji_ime = 'com.apple.inputmethod.Kotoeri.Japanese'
endif

if !exists('g:japanese_mode')
    let g:japanese_ime = 'com.apple.inputmethod.Kotoeri.Japanese'
endif

if !exists('g:vietnamese_mode')
    let g:vietnamese_ime = 'com.apple.inputmethod.VietnameseIM.VietnameseSimpleTelex'
endif

function s:switch_normal_ime()
  call s:switch_ime(g:osxime_normal_ime)
endfunction

function s:switch_mode(mode_ime)
  echom a:mode_ime
  if a:mode_ime == 3
    call s:switch_ime(g:kanji_ime)
  elseif a:mode_ime == 2
    call s:switch_ime(g:japanese_ime)
  elseif a:mode_ime == 1
    call s:switch_ime(g:vietnamese_ime)
  else
    call s:switch_ime(g:osxime_normal_ime)
  endif
endfunction

function s:switch_ime(ime)
  execute "silent !" . g:osxime_issw_path . " '" . a:ime . "' > /dev/null"
endfunction

function s:insert_entered()
  if g:osxime_auto_detect
    let l:char = getline('.')[col('.') - 3]
    " only work when go to insert mode by append ('a' key)
    " because vim only provides InsertEnter event
    let l:col = col('.')
    let l:char = matchstr(getline('.'), '\%' . col('.') . 'c.')
    echom l:char
    " English mode
    if l:char < "\u80"
      let l:mode = 0
    " Vietnames mode
    elseif l:char >= "\u80" && l:char <= "\u3040"
      let l:mode = 1 
    " Hiragana + Katanamode
    elseif l:char >= "\u3040" && l:char <= "\u3100"
      let l:mode = 2
    " Kanji mode
    else 
      let l:mode = 3
    endif
  endif
  call s:switch_mode(l:mode)
endfunction

function s:insert_leave()
  call s:switch_normal_ime()
endfunction

autocmd InsertEnter * :call s:insert_entered()

if g:osxime_insert_leave
  autocmd InsertLeave * :call s:insert_leave()
endif
