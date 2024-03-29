set nocompatible              " required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Add all your plugins here (note older versions of Vundle used Bundle instead of Plugin)
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'taglist.vim'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'tell-k/vim-autopep8'
Plugin 'Yggdroot/indentLine'
Plugin 'tmhedberg/SimpylFold'
Plugin 'Valloric/YouCompleteMe'
Plugin 'jiangmiao/auto-pairs'
Plugin 'scrooloose/nerdcommenter'
Plugin 'jakwings/vim-colors'
Plugin 'skammer/vim-css-color'
Plugin 'hail2u/vim-css3-syntax'
Plugin 'mileszs/ack.vim' 

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required



"config ack vim 
let g:ackprg = 'ag --nogroup --nocolor --column'
map <C-p> <ESC>:Ack<space>
"end config 


"config pep8 
au BufNewFile,BufRead *.py set tabstop=4 |set softtabstop=4|set shiftwidth=4|set textwidth=79|set expandtab|set autoindent|set fileformat=unix
au BufNewFile,BufRead *.js, *.html, *.css set tabstop=2|set softtabstop=2|set shiftwidth=2
" Disable show diff window
let g:autopep8_disable_show_diff=1

" vim-autopep8自1.11版本之后取消了F8快捷键，需要用户自己为:Autopep8设置快捷键：
autocmd FileType python noremap <buffer> <F8> :call Autopep8()<CR>

map <F6> <ESC>:Autopep8<CR>:w<CR>:call RunPython()<CR>

function! RunPython()
  let mp = &makeprg
  let ef = &errorformat
  let exeFile = expand("%:t")
  setlocal makeprg=python\ -u
  set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
  silent make %
  copen
  let &makeprg = mp
  let &errorformat = ef
endfunction

"end config 




colorschem colorful256 
"colorschem colorsbox-greenish 
"colorschem peaksea
"colorschem lizard256 
"colorschem wombat256mod 
"colorschem xoria256 
"colorschem lapis256 

"end config 


"config nerdcommenter 

" nerdcommenter默认热键<leader>为'\'，这里将热键设置为','
"let mapleader=','

" 设置注释快捷键
map <F4> <leader>ci<CR>

"end conig 


"config YCM 
" 补全菜单的开启与关闭
set completeopt=longest,menu                       " 让Vim的补全菜单行为与一般IDE一致(参考VimTip1228)
let g:ycm_min_num_of_chars_for_completion=2                " 从第2个键入字符就开始罗列匹配项
let g:ycm_cache_omnifunc=0                        " 禁止缓存匹配项,每次都重新生成匹配项
let g:ycm_autoclose_preview_window_after_completion=1        " 智能关闭自动补全窗口
autocmd InsertLeave * if pumvisible() == 0|pclose|endif         " 离开插入模式后自动关闭预览窗口

" 补全菜单中各项之间进行切换和选取：默认使用tab  s-tab进行上下切换，使用空格选取。可进行自定义设置：
"let g:ycm_key_list_select_completion=['<c-n>']
"let g:ycm_key_list_select_completion = ['<Down>']        " 通过上下键在补全菜单中进行切换
"let g:ycm_key_list_previous_completion=['<c-p>']
"let g:ycm_key_list_previous_completion = ['<Up>']
inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"    " 回车即选中补全菜单中的当前项

" 开启各种补全引擎
let g:ycm_collect_identifiers_from_tags_files=1            " 开启 YCM 基于标签引擎
let g:ycm_auto_trigger = 1                    " 开启 YCM 基于标识符补全，默认为1
let g:ycm_seed_identifiers_with_syntax=1                " 开启 YCM 基于语法关键字补全
let g:ycm_complete_in_comments = 1                " 在注释输入中也能补全
let g:ycm_complete_in_strings = 1                " 在字符串输入中也能补全
let g:ycm_collect_identifiers_from_comments_and_strings = 0    " 注释和字符串中的文字也会被收入补全

" 重映射快捷键
"上下左右键的行为 会显示其他信息,inoremap由i 插入模式和noremap不重映射组成，只映射一层，不会映射到映射的映射
inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"

"nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>            " force recomile with syntastic
"nnoremap <leader>lo :lopen<CR>    "open locationlist
"nnoremap <leader>lc :lclose<CR>    "close locationlist
"inoremap <leader><leader> <C-x><C-o>

nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR> " 跳转到定义处
let g:ycm_confirm_extra_conf=0                     " 关闭加载.ycm_extra_conf.py确认提示

"end config 


"config SimpyFold
" 必须手动输入za来折叠（和取消折叠）
set foldmethod=indent                " 根据每行的缩进开启折叠
set foldlevel=99

" 使用空格键会是更好的选择,所以在你的配置文件中加上这一行命令吧：
nnoremap <space> za

" 希望看到折叠代码的文档字符串？
let g:SimpylFold_docstring_preview=1

"end config 

"config indentline 
" 支持任意ASCII码，也可以使用特殊字符：¦, ┆, or │ ，但只在utf-8编码下有效
let g:indentLine_char='¦'    

" 使indentline生效
let g:indentLine_enabled = 1

" end config 


" config taglist 
let Tlist_Use_Right_Window = 1             "让taglist窗口出现在Vim的右边

let Tlist_File_Fold_Auto_Close = 1         "当同时显示多个文件中的tag时，设置为1，可使taglist只显示当前文件tag，其它文件的tag都被折叠起来。

let Tlist_Show_One_File = 1             "只显示一个文件中的tag，默认为显示多个

let Tlist_Sort_Type ='name'             "Tag的排序规则，以名字排序。默认是以在文件中出现的顺序排序

let Tlist_GainFocus_On_ToggleOpen = 1         "Taglist窗口打开时，立刻切换为有焦点状态

let Tlist_Exit_OnlyWindow = 1             "如果taglist窗口是最后一个窗口，则退出vim

let Tlist_WinWidth = 32             "设置窗体宽度为32，可以根据自己喜好设置

let Tlist_Ctags_Cmd='/usr/local/bin/ctags'     "这里比较重要了，设置ctags的位置，不是指向MacOS自带的那个，而是我们用homebrew安装的那个

map <leader>z :TlistToggle<CR>                "热键设置，我设置成Leader+z来呼出和关闭Taglist


"end config 


"config NERDTree

"使用F3键快速调出和隐藏它
map <F3> :NERDTreeToggle<CR>

let NERDTreeChDirMode=1

"显示书签"
let NERDTreeShowBookmarks=1

"设置忽略文件类型"
let NERDTreeIgnore=['\~$', '\.pyc$', '\.swp$']

"窗口大小"
let NERDTreeWinSize=25

" 修改默认箭头
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

"How can I open a NERDTree automatically when vim starts up if no files were specified?
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" 打开vim时自动打开NERDTree
autocmd vimenter * NERDTree           

"How can I open NERDTree automatically when vim starts up on opening a directory?
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

" 关闭vim时，如果打开的文件除了NERDTree没有其他文件时，它自动关闭，减少多次按:q!
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" 开发的过程中，我们希望git信息直接在NERDTree中显示出来， 和Eclipse一样，修改的文件和增加的文件都给出相应的标注， 这时需要安装的插件就是 nerdtree-git-plugin,配置信息如下
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ "Unknown"   : "?"
    \ }

" 显示行号
let NERDTreeShowLineNumbers=1
let NERDTreeAutoCenter=1

" 在终端启动vim时，共享NERDTree
let g:nerdtree_tabs_open_on_console_startup=1

"end config 


" config windows 
" 指定屏幕上可以进行分割布局的区域
set splitbelow               " 允许在下部分割布局
set splitright               " 允许在右侧分隔布局

" 组合快捷键：
nnoremap <C-j> <C-w><C-j>    " 组合快捷键：- Ctrl-j 切换到下方的分割窗口
nnoremap <C-k> <C-w><C-k>    " 组合快捷键：- Ctrl-k 切换到上方的分割窗口
nnoremap <C-l> <C-w><C-l>    " 组合快捷键：- Ctrl-l 切换到右侧的分割窗口
nnoremap <C-h> <C-w><C-h>    " 组合快捷键：- Ctrl-h 切换到左侧的分割窗口

" end config 

set guifont=Meslo\ LG\ S\ DZ\ Regular\ for\ Powerline:h13
set enc=utf-8
set number                        
set showtabline=0                
set guioptions-=r                
set guioptions-=L               
set guioptions-=b               
set cursorline                  
set cursorcolumn                
set langmenu=zh_CN.UTF-8        
syntax on                      
set nowrap                     
set fileformat=unix            
set cindent                    
set tabstop=4                  
set shiftwidth=4               
set backspace+=indent,eol,start
set showmatch                  
set scrolloff=5                
set laststatus=2               
set mouse=a      
set selection=exclusive
set selectmode=mouse,key
set matchtime=5
set ignorecase                 
set incsearch
set hlsearch                   
set noexpandtab       
set whichwrap+=<,>,h,l
set autoread
set clipboard=unnamed

autocmd! BufWritePost $MYVIMRC source $MYVIMRC

" config for key mapping 

"make C files and go and back on Quickfix
autocmd FileType c,cpp  map <buffer> <leader>m :w<cr>:make<cr>
nmap <leader>cv :cn<cr>
nmap <leader>cx :cp<cr>
nmap <leader>cw :cw 10<cr> 


map! <C-a> <HOME>
map! <C-e> <END>

"end key mapping config 
