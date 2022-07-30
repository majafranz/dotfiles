vim.g['deoplete#enable_at_startup'] = 1

-- enable completion only with python
vim.cmd("call deoplete#custom#option('auto_complete', v:false)")
vim.cmd("autocmd FileType python call deoplete#custom#option('auto_complete', v:true)")

