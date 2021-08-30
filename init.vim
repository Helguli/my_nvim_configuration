set number
set nocompatible
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
set clipboard=unnamedplus
set foldmethod=syntax
set nofoldenable
set mouse=a

inoremap {<cr> {<cr>}<c-o><s-o>
inoremap [ []<Left>
inoremap ( ()<Left>
noremap <silent> <C-S>          :update<CR>
vnoremap <silent> <C-S>         <C-C>:update<CR>
inoremap <silent> <C-S>         <C-O>:update<CR>


au BufRead,BufNewFile *.ino,*.pde set filetype=cpp

"filetype off

call plug#begin('~/.vim/plugged')
Plug 'coddingtonbear/neomake-platformio'
"Plug 'prabirshrestha/vim-lsp'
"Plug 'ludovicchabant/vim-gutentags'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'Shougo/deoplete.nvim'
"Plug 'lighttiger2505/deoplete-vim-lsp'
"Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'jackguo380/vim-lsp-cxx-highlight'

call plug#end()

if executable('ccls')
   au User lsp_setup call lsp#register_server({
      \ 'name': 'ccls',
      \ 'cmd': {server_info->['ccls --log-file=vmi.log']},
      \ 'root_uri': {server_info->lsp#utils#path_to_uri(
      \   lsp#utils#find_nearest_parent_file_directory(
      \     lsp#utils#get_buffer_path(), ['.ccls', 'compile_commands.json']))},
      \ 'initialization_options': {
      \   'highlight': { 'lsRanges' : v:true },
      \   'cache': {'directory': stdpath('cache') . '/ccls' },
      \ },
      \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp', 'cc', 'ino'],
      \ })
endif



function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    inoremap <buffer> <expr><c-f> lsp#scroll(+4)
    inoremap <buffer> <expr><c-d> lsp#scroll(-4)

    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
    
    " refer to doc to add more commands
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END


hi LspCxxHlSymParameter ctermfg=LightRed guifg=LightRed cterm=none gui=none

hi LspCxxHlSymLocalVariable ctermfg=LightCyan guifg=Orange cterm=none gui=none

hi LspCxxHlSymField ctermfg=Brown guifg=Brown

hi LspCxxHlSymVariable ctermfg=DarkBlue guifg=Blue cterm=bold gui=bold

"let  g:gutentags_ctags_tagfile = '.tags'
"let  s:vim_tags = expand('~/.cache/tags')
"let  g:gutentags_cache_dir = s:vim_tags
"let  g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
"let  g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
"let  g:gutentags_ctags_extra_args += ['--c-kinds=+px']

let g:deoplete#enable_at_startup = 1

