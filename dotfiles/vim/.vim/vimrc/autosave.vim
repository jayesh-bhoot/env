augroup autosave
    autocmd!
    autocmd CursorHold,CursorHoldI,InsertLeave,FocusLost,BufLeave * silent! wa
augroup END

