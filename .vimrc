call pathogen#infect()
syntax on
filetype plugin indent on
set background=dark
colorscheme solarized

"Yank text to OS X clipboard
noremap <leader>y "*y
noremap <leader>yy "*Y

" Preserve indentation while pasting text from the OS X clipboard
noremap <leader>p :set paste<CR>:put  *<CR>:set nopaste<CR>
