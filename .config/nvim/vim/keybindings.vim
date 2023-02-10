"" Custom Commands
"-------------------------------------------------------------------------------
" these commands may change depending on the filetype or active extension

" open a new fullscreen terminal
command! T call NewTerminal("")

" open a new horiontal terminal
command! HT call NewHorizontalTerminal("")

" open a new vertical terminal
command! VT call NewVerticalTerminal("")

" enable soft wrapping (no enter inserted) at end of window
command! SoftWrap setlocal wrap linebreak formatoptions=lqj textwidth=0 colorcolumn=0

" enable hard wrapping (insert enter) at 88 characters
command! HardWrap setlocal nowrap nolinebreak formatoptions=tqj textwidth=88 colorcolumn=88

" enable no wrapping (disable both hard wrapping and soft wrapping)
command! NoWrap setlocal nowrap nolinebreak formatoptions=lqj textwidth=0 colorcolumn=0

augroup terminal
  autocmd!
  autocmd TermOpen * call OnTerminalOpen()
  autocmd TermClose * call OnTerminalClose()
augroup end

augroup pythonterminal
    autocmd!

    autocmd FileType python command! T call NewTerminal("ipython")
    autocmd FileType python command! HT call NewHorizontalTerminal("ipython")
    autocmd FileType python command! VT call NewVerticalTerminal("ipython")
augroup end

function! OnTerminalOpen()
    let g:last_terminal_job_id = b:terminal_job_id
endfunction
function! OnTerminalClose()
    if exists("g:last_terminal_job_id")
        unlet g:last_terminal_job_id
    endif
endfunction

function! NewTerminal(shell)
    execute "terminal ".a:shell
endfunction
function! NewHorizontalTerminal(shell)
    execute "split | resize 10 | terminal ".a:shell
    execute "normal G\<C-w>k"
endfunction
function! NewVerticalTerminal(shell)
    execute "vsplit | terminal ".a:shell
    execute "normal G\<C-w>h"
endfunction
