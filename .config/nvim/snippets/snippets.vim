"" Latex
"-------------------------------------------------------------------------------

inoremap ;tex <Esc>:-1read ~/.config/nvim/snippets/tex.tex<CR>:set filetype=tex<CR>
autocmd FileType tex inoremap ;fig <Esc>:-1read ~/.config/nvim/snippets/figure.tex<CR>jzOj$i
autocmd FileType tex inoremap ;svg <Esc>:-1read ~/.config/nvim/snippets/svgfigure.tex<CR>jzOj$i
autocmd FileType tex inoremap ;pgf <Esc>:-1read ~/.config/nvim/snippets/pgffigure.tex<CR>jzOj$i
autocmd FileType tex inoremap ;pfg <Esc>:-1read ~/.config/nvim/snippets/pgffigure.tex<CR>jzOj$i
autocmd FileType tex inoremap ;sub <Esc>:-1read ~/.config/nvim/snippets/subfigure.tex<CR>jzO3j$i
autocmd FileType tex inoremap ;ali <Esc>:-1read ~/.config/nvim/snippets/align.tex<CR>j^i<Esc>i
autocmd FileType tex inoremap ;mat <Esc>:-1read ~/.config/nvim/snippets/matrix.tex<CR>j$a
autocmd FileType tex inoremap ;pma <Esc>:-1read ~/.config/nvim/snippets/pmatrix.tex<CR>j$a
autocmd FileType tex inoremap ;bma <Esc>:-1read ~/.config/nvim/snippets/bmatrix.tex<CR>j$a
autocmd FileType tex inoremap ;ite <Esc>:-1read ~/.config/nvim/snippets/itemize.tex<CR>j$a
autocmd FileType tex inoremap ;enu <Esc>:-1read ~/.config/nvim/snippets/enumerate.tex<CR>j$a



"" Greek alphabet
"-------------------------------------------------------------------------------

inoremap ;alpha α
inoremap ;beta β
inoremap ;gamma γ
inoremap ;delta δ
inoremap ;epsilon ε
inoremap ;zeta ζ
inoremap ;eta η
inoremap ;theta θ
inoremap ;iota ι
inoremap ;kappa κ
inoremap ;lambda λ
inoremap ;mu μ
inoremap ;nu ν
inoremap ;xi ξ
inoremap ;omicron ο
inoremap ;pi π
inoremap ;rho ρ
inoremap ;sigma σ
inoremap ;sigma ς
inoremap ;tau τ
inoremap ;upsilon υ
inoremap ;phi φ
inoremap ;chi χ
inoremap ;psi ψ
inoremap ;omega ω
inoremap ;Alpha Α
inoremap ;Beta Β
inoremap ;Gamma Γ
inoremap ;Delta Δ
inoremap ;Epsilon Ε
inoremap ;Zeta Ζ
inoremap ;Eta Η
inoremap ;Theta Θ
inoremap ;Iota Ι
inoremap ;Kappa Κ
inoremap ;Lambda Λ
inoremap ;Mu Μ
inoremap ;Nu Ν
inoremap ;Xi Ξ
inoremap ;Omicron Ο
inoremap ;Pi Π
inoremap ;Rho Ρ
inoremap ;Sigma Σ
inoremap ;Tau Τ
inoremap ;Upsilon Υ
inoremap ;Phi Φ
inoremap ;Chi Χ
inoremap ;Psi Ψ
inoremap ;Omega Ω
