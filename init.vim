
"===
"===vim's underlying configuration
"===

"去除vi一致性模式，避免以前版本的一些bug
set nocompatible
"语法高亮
set syntax=on
let g:polyglot_disabled = ['sensible']
"设置编码
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8
"显示行号
set nu
"突出显示行
set cul
"显示括号匹配
set showmatch
"设置Tab长度为4空格
set tabstop=4
"设置自动缩进长度为4空格
set shiftwidth=4
"继承前一行的缩进方式，适用于多行注释
set autoindent
"设置粘贴
"set paste
"显示空格和tab键
set listchars=tab:>-,trail:-
"总是显示状态栏
set laststatus=2
"使用系统剪切板
set clipboard=unnamedplus
"显示光标所在位置
set ruler
"打开文件类型检测
filetype plugin indent on

" ===
" ===Basic map setting
" ===
"Open the init.vim anytime
noremap <LEADER>rc :e ~/.config/nvim/init.vim<CR>
noremap zh z+5
noremap zj j+5
noremap zk k+5
noremap zl l+5
noremap S  :w<CR>
noremap Q  :q<CR>
" Use <space> + new arrow keys for moving the cursor around windows
noremap <space>w <C-w>w
noremap <space>k <C-w>k
noremap <space>j <C-w>j
noremap <space>h <C-w>h
noremap <space>l <C-w>l
" split the screens to up (horizontal), down (horizontal), left (vertical), right (vertical)
noremap sk :set nosplitbelow<CR>:split<CR>:set splitbelow<CR>
noremap sj :set splitbelow<CR>:split<CR>
noremap sh :set nosplitright<CR>:vsplit<CR>:set splitright<CR>
noremap sl :set splitright<CR>:vsplit<CR>
" Resize splits with arrow keys
noremap <up> :res +5<CR>
noremap <down> :res -5<CR>
noremap <left> :vertical resize-5<CR>
noremap <right> :vertical resize+5<CR>
" Compile function
noremap r :call CompileRunGcc()<CR>
func! CompileRunGcc()
	exec "w"
	if &filetype == 'c'
		exec "!g++ % -o %<"
		exec "!time ./%<"
	elseif &filetype == 'cpp'
		set splitbelow
		exec "!g++ -std=c++11 % -Wall -o %<"
		:sp
		:res -15
		:term ./%<
		" elseif &filetype == 'java'
		"set splitbelow
		":sp
		":res -5
		"term javac % && time java %<
	elseif &filetype == 'sh'
		:!time bash %
	elseif &filetype == 'python'
		set splitbelow
		:sp
		:term python3 %
	elseif &filetype == 'html'
		silent! exec "!".g:mkdp_browser." % &"
	elseif &filetype == 'tex'
		silent! exec "VimtexStop"
		silent! exec "VimtexCompile"
	elseif &filetype == 'javascript'
		set splitbelow
		:sp
		:term export DEBUG="INFO,ERROR,WARNING"; node --trace-warnings .
	endif
endfunc

" ===
" ===Plug
" ===

call plug#begin('~/.config/nvim/plugged')

" coc.nvim
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" vim-colorschemes
"Plug 'flazz/vim-colorschemes'

"Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"Plug 'zchee/deoplete-jedi'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'jiangmiao/auto-pairs'

Plug 'scrooloose/nerdcommenter'

Plug 'sbdchd/neoformat'

"Plug 'davidhalter/jedi-vim'

Plug 'scrooloose/nerdtree'

"Plug 'neomake/neomake'

Plug 'mg979/vim-visual-multi'

Plug 'machakann/vim-highlightedyank'
"
Plug 'tmhedberg/SimpylFold'
" themes
"Plug 'morhetz/gruvbox'
" ===
" === 语法高亮
" ===
Plug 'sheerun/vim-polyglot'
" python,c/cpp
Plug 'vim-python/python-syntax'
Plug 'vim-jp/vim-cpp'

" 彩虹括号
Plug 'luochen1990/rainbow'
"onedark
Plug 'joshdick/onedark.vim'
Plug 'itchyny/lightline.vim'

" minibufexpl
Plug 'fholgado/minibufexpl.vim'

Plug 'mg979/vim-xtabline'
call plug#end()

"===
"===注释插件 nerdcommenter
"===
"	<leader>cc	注释单行
"	<leader>cu	反注释

"===
"===代码自动format插件
"===
"python
let g:neoformat_enabled_python = ['autopep8', 'yapf', 'docformatter']

"run a formatter on save
augroup fmt
	autocmd!
	autocmd BufWritePre * undojoin | Neoformat
augroup END
" Enable alignment
let  g:neoformat_basic_format_align = 1

" Enable tab to spaces conversion
let  g:neoformat_basic_format_retab = 1

" Enable trimmming of trailing whitespace
let  g:neoformat_basic_format_trim = 1

"===
"===代码跳转插件 jedi-vim
"===
" <leader>d:go to definition
"k:check documentation of class or method
"<leader>n:show the usage of a name in current file
"<leader>r:rename a name
"disable autocompletion
"let g:jedi#completions_enabled = 0
"You can make jedi-vim use tabs when going to a definition etc:
"let g:jedi#use_tabs_not_buffers = 1
"open the go-to function in split, not another buffer
"let  g:jedi#use_splits_not_buffers = "right"

"===
"===文件管理器 nerdtree
"===
noremap <leader>e :NERDTreeToggle<CR>
let g:NERDTreeShowHidden=1
" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
			\ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif
" Start NERDTree and leave the cursor in it.
"autocmd VimEnter * NERDTree

"===
"===代码检查工具 Neomake
"===
"let g:neomake_python_enabled_makers = ['pylint']
"call neomake#configure#automake('nrwi', 500)	"自动检查

"===
"===多点编辑插件 vim-multiple-cursors
"===

"===
"===高亮显示复制文本 vim-higkhlightedyank
"===
hi HighlightedyankRegion cterm=reverse gui=reverse
let g:highlightedyank_highlight_duration = 1000 " 高亮持续时间为 1000 毫k秒

"===
"===代码折叠插件 SimpyFold
"===
"	zo:打开光标处的fold
"	zO:递归打开光标处所有fold
"	zc:关闭光标处fold
"	zC:关闭光标处所有fold
set foldenable

" =========================================================================================
"===
"===themes
"===
"彩虹括号
let g:rainbow_active = 1

"vim-polyglot语法高亮
let g:python_highlight_all = 1

" set background=dark " or set background=light

" 状态栏插件vim-airline
let g:airline_theme='onedark' " <theme> 代表某个主题的名称

" lightline.vim
let g:lightline = {
			\ 'colorscheme': 'onedark',
			\ }

"onedark
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
	if (has("nvim"))
		"For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
		let $NVIM_TUI_ENABLE_TRUE_COLOR=1
	endif
	"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
	"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
	" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
	if (has("termguicolors"))
		set termguicolors
	endif
endif

let g:onedark_hide_endofbuffer=1
let g:onedark_termcolors=256
let g:onedark_terminal_italics=1
let g:onedark_color_overrides = {
			\ "black": {"gui": "#2F343F", "cterm": "235", "cterm16": "0" },
			\ "purple": { "gui": "#C678DF", "cterm": "170", "cterm16": "5" }
			\}
colorscheme onedark

" ===
" ===minibufexpl.vim
" ===
noremap <c-h> :MBEbb<CR>
noremap <c-l> :MBEbf<CR>
noremap <c-d> :MBEbd<CR>

" ===
" === xtabline
" ===
let g:xtabline_settings = {}
let g:xtabline_settings.enable_mappings = 0
let g:xtabline_settings.tabline_modes = ['tabs', 'buffers']
let g:xtabline_settings.enable_persistance = 0
let g:xtabline_settings.last_open_first = 1
noremap to :XTabMode<CR>
noremap \p :echo expand('%:p')<CR>
nmap <silent><expr> <BS> v:count ? "\<Plug>(XT-Select-Buffer)" : ":Buffers\r"

" ===
" === Coc-nvim
" ===
" auto-install extensions
let g:coc_global_extensions = [
			\'coc-json',
			\'coc-actions',
			\'coc-python',
			\'coc-explorer',
			\'coc-flutter-tools',
			\'coc-clangd',
			\'coc-marketplace',
			\'coc-vimlsp']
"===
"=== coc-explorer
"===
:nmap <space>e <Cmd>CocCommand explorer<CR>
"nmap <Leader>er <Cmd>call CocAction('runCommand', 'explorer.doAction', 'closest', ['reveal:0'], [['relative', 0, 'file']])<CR>
" TextEdit might fail if hidden is not set.
set hidden
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=50
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
	" Recently vim can merge signcolumn and number column into one
	set signcolumn=number
else
	set signcolumn=yes
endif
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
			\ pumvisible() ? "\<C-n>" :
			\ <SID>check_back_space() ? "\<TAB>" :
			\ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
			\: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> <space>- <Plug>(coc-diagnostic-prev)
nmap <silent> <space>= <Plug>(coc-diagnostic-next)
" GoTo code navigation.
"nmap <silent> gd <Plug>(coc-definition)
"nmap <silent> gy <Plug>(coc-type-definition)
"nmap <silent> gi <Plug>(coc-implementation)
"nmap <silent> gr <Plug>(coc-references)
" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
	if (index(['vim','help'], &filetype) >= 0)
		execute 'h '.expand('<cword>')
	elseif (coc#rpc#ready())
		call CocActionAsync('doHover')
	else
		execute '!' . &keywordprg . " " . expand('<cword>')
	endif
endfunction
" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
" Go back to where you just edited it
if has("autocmd")
	au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
