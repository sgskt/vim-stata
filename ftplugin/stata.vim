" ftplugin/stata.vim - maps for Stata source files
" Maintainer:   Jeff Pitblado <jpitblado at stata.com>
" Last Change:  17sep2014

if exists("b:did_ftplugin")
	finish
endif
let b:did_ftplugin = 1

" I use '!!rm' in my debug output so it is easy to search for and remove later

" insert/remove double bang comment start of line
nnoremap <buffer> <localleader>c 0i//!!rm <esc>0j
nnoremap <buffer> <localleader>C 07xj

nnoremap <buffer> <localleader>date :r !date '+\%d\%b\%Y'<cr>02lgul0k

" update the version comment at the top of the file
nmap <buffer> <localleader>uu gg/\<version\>\\|\<VERSION\>/<cr>6wcw<esc><localleader>dateJ:nohlsearch<cr>
nmap <buffer> <localleader>vv <localleader>uu?\.?<cr><c-a>:nohlsearch<cr>

" Mata debug message
nnoremap <buffer> <localleader>m0 O<esc>aerrprintf("!!rm: 0\n")<esc>
" Mata show object
nnoremap <buffer> <localleader>mx O<esc>aerrprintf("!!rm: xx\n"); xx<esc>
" Mata show real scalar value
nnoremap <buffer> <localleader>mg O<esc>aerrprintf("!!rm: xx = %g\n", xx) ;<esc>
" Mata show integer scalar value
nnoremap <buffer> <localleader>mf O<esc>aerrprintf("!!rm: xx = %f\n", xx) ;<esc>
" Mata show string scalar value
nnoremap <buffer> <localleader>ms O<esc>aerrprintf("!!rm: xx = %s\n", xx) ;<esc>
" Mata exit early
nnoremap <buffer> <localleader>mee mpoexit(9999) //!!rm<cr><esc>'p

" Stata debug message
nnoremap <buffer> <localleader>s0 O<esc>adi as err `"!!rm: 0"'<esc>
" Stata show global macro
nnoremap <buffer> <localleader>sG O<esc>adi as err `"!!rm: xx = "' ${xx}<esc>
nnoremap <buffer> <localleader>sg O<esc>adi as err `"!!rm: xx is \|${xx}\|"'<esc>
" Stata show local macro
nnoremap <buffer> <localleader>sL O<esc>adi as err `"!!rm: xx = "' `xx'<esc>
nnoremap <buffer> <localleader>sl O<esc>adi as err `"!!rm: xx is \|`xx'\|"'<esc>
" Stata exit early
nnoremap <buffer> <localleader>see mpoexit 9999 //!!rm<cr><esc>'p

" replace 'xx' in the current line with ...
nnoremap <buffer> <localleader>xx :s/xx/

" Folding
function! StataFolds()
    let line = getline(v:lnum)
    let nline = getline(v:lnum+1)
    let nnline = getline(v:lnum+2)
    if match(line, '^\*.*-$') >= 0
        return ">2"
    elseif match(line,'^\*\+$') >= 0 && match(nline,'^\*')>=0 && match(nnline,'^\*\+$')>=0
        return ">1"
    else
        return "="
    endif
endfunction

function! StataFoldsText()
    let foldlength = v:foldend-v:foldstart
    let text=""
    if v:foldlevel==1
        let text=getline(v:foldstart+1)
    else
        let text=getline(v:foldstart)
    endif
    return "[".v:foldlevel."] ".text." (".foldlength." lines)"
endfunction
setlocal foldmethod=expr
setlocal foldexpr=StataFolds()
setlocal foldtext=StataFoldsText()

" end: ftplugin/stata.vim
