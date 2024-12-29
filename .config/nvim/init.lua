vim.g.mapleader = " "
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.title = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.backup = false
vim.opt.showcmd = true
vim.opt.cmdheight = 1
vim.opt.laststatus = 3
vim.opt.expandtab = true
vim.opt.scrolloff = 10
vim.opt.shell = "zsh"
vim.opt.backupskip = { "/tmp/*", "/private/tmp/*" }
vim.opt.inccommand = "split"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.smarttab = true
vim.opt.breakindent = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.wrap = false
vim.opt.backspace = { "start", "eol", "indent" }
vim.opt.path:append({ "**" })
vim.opt.wildignore:append({ "*/node_modules/*" })
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.splitkeep = "cursor"
vim.opt.mouse = "a"

vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.foldmethod = "syntax"
vim.opt.foldlevel = 99
vim.opt.signcolumn = "yes"

if vim.fn.has("nvim-0.8") == 1 then
  vim.opt.cmdheight = 0
end


-- Neovide settings for enhanced visuals(TM)
if vim.g.neovide then
  vim.g.neovide_transparency = 0.85
  vim.g.transparency = 0.15
  vim.g.neovide_background_color = "#282a36" .. string.format("%x", math.floor(255 * vim.g.transparency))
  vim.g.neovide_cursor_vfx_mode = "pixiedust"
  vim.g.neovide_cursor_vfx_particle_density = 20.0
  vim.g.neovide_cursor_vfx_opacity = 200.0
  vim.g.neovide_cursor_animation_length = 0.1
  vim.g.neovide_cursor_trail_length = 1.0
  vim.g.neovide_floating_blur_amount_x = 2.0
  vim.g.neovide_floating_blur_amount_y = 2.0
  vim.g.neovide_no_idle = true
  vim.g.neovide_scale_factor = 1.0
  vim.g.neovide_remember_window_size = true;
  vim.o.guifont="JetBrainsMonoNL NF:h14"
  vim.api.nvim_set_keymap('v', '<sc-c>', '"+y', {noremap = true})
	vim.api.nvim_set_keymap('n', '<sc-v>', 'l"+P', {noremap = true})
	vim.api.nvim_set_keymap('v', '<sc-v>', '"+P', {noremap = true})
	vim.api.nvim_set_keymap('c', '<sc-v>', '<C-o>l<C-o>"+<C-o>P<C-o>l', {noremap = true})
	vim.api.nvim_set_keymap('i', '<sc-v>', '<ESC>l"+Pli', {noremap = true})
	vim.api.nvim_set_keymap('t', '<sc-v>', '<C-\\><C-n>"+Pi', {noremap = true})
end

require'lspconfig'.rust_analyzer.setup{
  settings = {
    ['rust-analyzer'] = {
      diagnostics = {
        enable = true;
      }
    }
  }
}

-- typst autocommands(https://github.com/MultisampledNight/core/blob/5d05e0a4fa453f249edaac249d3811e1c5d711a1/config/nvim/init.vim#L469-L532)
vim.cmd [[
  autocmd BufNewFile,BufRead *.typ
  \ set filetype=typst sw=2 ts=2 sts=0 et
  \|call LaunchProgram("typst" . bufnr(), [
  \ "typst",
  \ "watch",
    \ expand("%:p"),
    \ CurrentPdfPath(),
   \ ])
   \|noremap<buffer><Leader>2 <Cmd>call ViewCurrentPdf()<CR>
   autocmd BufLeave *.typ
    \ call StopProgram("typst" . bufnr())
   autocmd VimLeavePre *.typ
    \ call StopProgram("typst" . bufnr())
    \|call StopProgram("evince")

" both latex and typst, and anything that would require a pdf
autocmd BufEnter *.tex,*.typ call ViewCurrentPdf()
let g:tracked_programs = {}

function CurrentPdfPath()
  return expand("%:p:h") . "/view.pdf"
endfunction

function ViewCurrentPdf()
  if !has_key(g:tracked_programs, "evince")
    echo CurrentPdfPath()
    call LaunchProgram("evince", ["evince", CurrentPdfPath()])
    return
  endif

  try
    let pid = jobpid(g:tracked_programs["evince"])
  catch /.*E900: Invalid channel id/
    call LaunchProgram("evince", ["evince", CurrentPdfPath()])
    return
  endtry
endfunction

function LaunchProgram(name, command)
  " stop previously open from "older" buffer
  call StopProgram(a:name)
  let g:tracked_programs[a:name] = ExecAtFile(a:command)
endfunction

function StopProgram(name)
  if has_key(g:tracked_programs, a:name)
    call jobstop(g:tracked_programs[a:name])
    unlet g:tracked_programs[a:name]
  endif
endfunction

function ExecAtFile(command)
  silent update

  exe "lcd " . expand("%:p:h")
  let job_id = jobstart(a:command, { "detach": v:true })
  lcd -

  return job_id
endfunction

" optional helper commands, if sensible for the current buffer
let s:autowrite = v:true
function AutoWriteToggle()
  call AutoWrite(!s:autowrite)
endfunction
function AutoWrite(target)
  if a:target == s:autowrite
    " no change needed
    return
  endif
  let s:autowrite = !s:autowrite

  augroup autowrite

    au!
    if a:target
      au CursorHold,CursorHoldI * call UpdateIfPossible()
    endif

  augroup END
endfunction

function UpdateIfPossible()
  " this does not write if the file doesn't exist yet — this is intentional
  " to support deleting and renaming
  if &buftype == "" && filewritable(@%)
    silent update
  endif
endfunction

command AutoWriteToggle call AutoWriteToggle()
command AutoWrite call AutoWrite(v:true)
command AutoWriteDisable call AutoWrite(v:false)
autocmd FocusGained * checktime

]]
-- Configure diagnostic display (global LSP settings)
vim.diagnostic.config({
    virtual_text = true,  -- Show inline virtual text
    signs = true,  -- Enable diagnostic signs
    underline = true,  -- Underline errors and warnings
    severity_sort = true,  -- Sort diagnostics by severity
    float = {
        source = "always",
        border = "rounded",
    },
})



