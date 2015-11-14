" common =====================================================================
filetype plugin indent on
filetype on
syntax enable
syntax on
set fileformats=unix,dos
set nocompatible 
set nobackup
set nosecure

" 跳转时自动保存
set autowrite
" 修改自动读入
set autoread
" 显示状态栏
:set laststatus=2
" 修复backspace不工作
set backspace=indent,eol,start
" 启用鼠标
"set mouse=a
" 光标可以跨行
set whichwrap=b,s,<,>,[,]
" 行号
set nu
" 下划线
set cursorline
" 80划条红线
set cc=80
" 高亮匹配的括号
set showmatch
" 搜索时忽略大小写
"set ignorecase
" 高亮搜索
set hlsearch
" 在搜索时，输入的词句的逐字符高亮（类似firefox的搜索）
set incsearch

" 缩进 
set softtabstop=2
set shiftwidth=2
" 制表符为
set tabstop=2
" tab用空格填充
set expandtab

" 自动格式化
set formatoptions=tcrqn
" 继承前一行的缩进方式，特别适用于多行注释
set autoindent
" 为C程序提供自动缩进
set smartindent
" 使用C样式的缩进
set cindent

" 折行
" set foldmethod=indent
" set foldlevel=4

" 编码格式
set fileencodings=utf-8,gbk,gb2312
set encoding=utf-8
" 修改文件编码格式 set fileencoding=xxx

" Windows 下的文件保存格式
if $OS == "Windows_NT"
  autocmd BufNewfile * set ff=dos
endif

" 记录上次编辑位置
autocmd BufReadPost *
      \ if line("'\"") > 1 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif

" 格式化文档
map <C-k><C-d> ggvG=''

" end common =================================================================

" hex editor =================================================================
map <C-H><C-n> :%!xxd<CR>
map <C-H><C-p> :%!xxd -r<CR>
" end hex editor =============================================================

" vundle =====================================================================
set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'taglist.vim'
Bundle 'a.vim'
Bundle 'winmanager'
Bundle 'greplace.vim'
Bundle 'echofunc.vim'
Bundle 'Valloric/ListToggle'
Bundle 'scrooloose/syntastic'

filetype plugin indent on
" end vundle =================================================================

" C/C++ ======================================================================

" 设置tags目录
set tags=$HOME/.tags/stltags;
set tags+=./tags;../tags;../../tags;../../../tags;../../../../tags;

" 自动更新tag
autocmd BufWrite *.cpp,*.h,*.c call UpdateTags()

" 建立tags
map <F12> :!ctags --fields=+lS -R<CR>

" C/C++配置Quickfix
autocmd VimEnter *.c,*.cpp,*.h,makefile,Makefile call QuickfixInit()

" a.vim 切换头/源文件
map<C-o> :A<CR>

" greplace.vim
map <C-e> :Gbuffersearch<CR>

" 补全
inoremap <C-h> <C-x><C-o>

" 关闭顶上提示
set completeopt=longest,menu,menuone

" YouCompleteMe
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0
let g:syntastic_always_populate_loc_list = 1

" taglist
" 不同时显示多个文件的tag，只显示当前文件的 
let Tlist_Show_One_File=1 
" 如果taglist窗口是最后一个窗口，则退出vim 
let Tlist_Exit_OnlyWindow=1 
let Tlist_File_Fold_Auto_Close=1

" map <C-m> :Tlist <CR>
" map <M-m> :Tlist <CR>

" end C/C++ ==================================================================

" some plugin ================================================================

"winmanager
let g:winManagerWindowLayout = "FileExplorer|TagList,BufExplorer"
" 所有文件关闭时退出vim
let g:persistentBehaviour=0 
map<C-f> :WMToggle<CR>
" autocmd VimEnter * :WMToggle

" end some plugin ============================================================

function UpdateTags()
  :!ctags --fields=+lS -a %
endfunction

function DoCompile()
  if filereadable('makefile') || filereadable('Makefile')
    :make
    :copen
  else
    :!gcc % -o %:r
  endif
endfunction

function QuickfixInit()
  " F5编译
  map <F5> :call DoCompile()<CR>
  " F6光标移到上一个错误所在的行
  map <F6> :cp<CR>
  " F7光标移到下一个错误所在的行
  map <F7> :cn<CR>
  " 关闭quakefix
  map <F8> :cclose<CR>
  " 以上的映射是使上面的快捷键在插入模式下也能用
  imap <F5> call DoCompile()
  imap <F6> :cp<CR>
  imap <F7> :cn<CR>
  imap <F8> :cclose
endfunction
