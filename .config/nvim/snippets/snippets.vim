"" Latex
"-------------------------------------------------------------------------------

"insert mode
inoremap &tex <Esc>:-1read ~/.config/nvim/snippets/tex.tex<CR>:set filetype=tex<CR>/TITLE<CR><Esc>ciw
autocmd FileType tex inoremap &fig <Esc>:-1read ~/.config/nvim/snippets/figure.tex<CR>jzOj$i
autocmd FileType tex inoremap &svg <Esc>:-1read ~/.config/nvim/snippets/svgfigure.tex<CR>jzOj$i
autocmd FileType tex inoremap &pgf <Esc>:-1read ~/.config/nvim/snippets/pgffigure.tex<CR>jzOj$i
autocmd FileType tex inoremap &pfg <Esc>:-1read ~/.config/nvim/snippets/pgffigure.tex<CR>jzOj$i
autocmd FileType tex inoremap &sub <Esc>:-1read ~/.config/nvim/snippets/subfigure.tex<CR>jzO3j$i
autocmd FileType tex inoremap &ali <Esc>:-1read ~/.config/nvim/snippets/align.tex<CR>j^i<Esc>i
autocmd FileType tex inoremap &mat <Esc>:-1read ~/.config/nvim/snippets/matrix.tex<CR>j$a
autocmd FileType tex inoremap &pma <Esc>:-1read ~/.config/nvim/snippets/pmatrix.tex<CR>j$a
autocmd FileType tex inoremap &bma <Esc>:-1read ~/.config/nvim/snippets/bmatrix.tex<CR>j$a
autocmd FileType tex inoremap &ite <Esc>:-1read ~/.config/nvim/snippets/itemize.tex<CR>j$a
autocmd FileType tex inoremap &enu <Esc>:-1read ~/.config/nvim/snippets/enumerate.tex<CR>j$a

" normal mode
nnoremap &tex :-1read ~/.config/nvim/snippets/tex.tex<CR>:set filetype=tex<CR>/TITLE<CR><Esc>ciw
autocmd FileType tex nnoremap &ite {j<C-V>}kI\item <Esc>dipO\begin{itemize}<CR>\end{itemize}<Esc>P
autocmd FileType tex nnoremap &enu {j<C-V>}kI\item <Esc>dipO\begin{enumerate}<CR>\end{enumerate}<Esc>P
autocmd FileType tex onoremap <silent> i$ :<C-U>normal! T$vt$<CR>
autocmd FileType tex vnoremap <silent> i$ :T$ot$
autocmd FileType tex onoremap <silent> a$ :<C-U>normal! F$vf$<CR>
autocmd FileType tex vnoremap <silent> a$ :F$of$



"" Markdown
"-------------------------------------------------------------------------------
autocmd FileType markdown nnoremap <leader>` 0f*wDa~~<Esc>pa~~<Esc>


"" Html
"-------------------------------------------------------------------------------

inoremap &html <Esc>:-1read ~/.config/nvim/snippets/html.html<CR>:set filetype=html<CR>zR/title<CR><Esc>cit
autocmd FileType html inoremap &'a &aacute;
autocmd FileType html inoremap &'e &eacute;
autocmd FileType html inoremap &'i &iacute;
autocmd FileType html inoremap &'o &oacute;
autocmd FileType html inoremap &'u &uacute;
autocmd FileType html inoremap &:a &auml;
autocmd FileType html inoremap &:e &euml;
autocmd FileType html inoremap &:i &iuml;
autocmd FileType html inoremap &:o &ouml;
autocmd FileType html inoremap &:u &uuml;
autocmd FileType html inoremap &~a &atilde;
autocmd FileType html inoremap &~e &etilde;
autocmd FileType html inoremap &~i &itilde;
autocmd FileType html inoremap &~o &otilde;
autocmd FileType html inoremap &~u &utilde;
autocmd FileType html inoremap &~h &ntilde;
autocmd FileType html inoremap &`a &agrave;
autocmd FileType html inoremap &`e &egrave;
autocmd FileType html inoremap &`i &igrave;
autocmd FileType html inoremap &`o &ograve;
autocmd FileType html inoremap &`u &ugrave;
autocmd FileType html inoremap &'A &Aacute;
autocmd FileType html inoremap &'E &Eacute;
autocmd FileType html inoremap &'I &Iacute;
autocmd FileType html inoremap &'O &Oacute;
autocmd FileType html inoremap &'U &Uacute;
autocmd FileType html inoremap &:A &Auml;
autocmd FileType html inoremap &:E &Euml;
autocmd FileType html inoremap &:I &Iuml;
autocmd FileType html inoremap &:O &Ouml;
autocmd FileType html inoremap &:U &Uuml;
autocmd FileType html inoremap &~A &Atilde;
autocmd FileType html inoremap &~E &Etilde;
autocmd FileType html inoremap &~I &Itilde;
autocmd FileType html inoremap &~O &Otilde;
autocmd FileType html inoremap &~U &Utilde;
autocmd FileType html inoremap &~H &Ntilde;
autocmd FileType html inoremap &`A &Agrave;
autocmd FileType html inoremap &`E &Egrave;
autocmd FileType html inoremap &`I &Igrave;
autocmd FileType html inoremap &`O &Ograve;
autocmd FileType html inoremap &`U &Ugrave;

"" Special letters
"-------------------------------------------------------------------------------
inoremap &'a á
inoremap &'e é
inoremap &'i í
inoremap &'o ó
inoremap &'u ú
inoremap &:a ä
inoremap &:e ë
inoremap &:i ï
inoremap &:o ö
inoremap &:u ü
inoremap &~a ã
inoremap &~e ẽ
inoremap &~i ĩ
inoremap &~o õ
inoremap &~u ũ
inoremap &~h ñ
inoremap &`a à
inoremap &`e è
inoremap &`i ì
inoremap &`o ò
inoremap &`u ù
inoremap &'A Á
inoremap &'E É
inoremap &'I Í
inoremap &'O Ó
inoremap &'U Ú
inoremap &:A Ä
inoremap &:E Ë
inoremap &:I Ï
inoremap &:O Ö
inoremap &:U Ü
inoremap &~A Ã
inoremap &~E Ẽ
inoremap &~I Ĩ
inoremap &~O Õ
inoremap &~U Ũ
inoremap &~H Ñ
inoremap &`A À
inoremap &`E È
inoremap &`I Ì
inoremap &`O Ò
inoremap &`U Ù


"" Greek alphabet
"-------------------------------------------------------------------------------

inoremap &alpha α
inoremap &beta β
inoremap &gamma γ
inoremap &delta δ
inoremap &epsilon ε
inoremap &zeta ζ
inoremap &eta η
inoremap &theta θ
inoremap &iota ι
inoremap &kappa κ
inoremap &lambda λ
inoremap &mu μ
inoremap &nu ν
inoremap &xi ξ
inoremap &omicron ο
inoremap &pi π
inoremap &rho ρ
inoremap &sigma σ
inoremap &sigma ς
inoremap &tau τ
inoremap &upsilon υ
inoremap &phi φ
inoremap &chi χ
inoremap &psi ψ
inoremap &omega ω
inoremap &Alpha Α
inoremap &Beta Β
inoremap &Gamma Γ
inoremap &Delta Δ
inoremap &Epsilon Ε
inoremap &Zeta Ζ
inoremap &Eta Η
inoremap &Theta Θ
inoremap &Iota Ι
inoremap &Kappa Κ
inoremap &Lambda Λ
inoremap &Mu Μ
inoremap &Nu Ν
inoremap &Xi Ξ
inoremap &Omicron Ο
inoremap &Pi Π
inoremap &Rho Ρ
inoremap &Sigma Σ
inoremap &Tau Τ
inoremap &Upsilon Υ
inoremap &Phi Φ
inoremap &Chi Χ
inoremap &Psi Ψ
inoremap &Omega Ω
