"let s:currentFile=resolve(expand("<sfile>:p:h"))

let s:pluginPath=resolve(expand("<sfile>:p:h"))

function! s:setTitle()
    "echo expand('%:t')
    "echo s:currentFile
    let s:fileName=expand('%s:t')
    "echo s:fileName
    silent execute '!' . s:pluginPath . '/settitle.sh ' . s:fileName
endfunc

function! s:idea()
    echo "none"
endfunc

"command setTitle call s:setTitle()

autocmd BufWritePost * call s:setTitle()
autocmd BufReadPost * call s:setTitle()
autocmd BufNewFile * call s:setTitle()
autocmd BufEnter * call s:setTitle()
