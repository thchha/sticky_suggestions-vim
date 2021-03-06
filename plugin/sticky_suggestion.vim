if exists("s:ticky_beeing")
	finish 
endif
let s:ticky_beeing = 1

let g:sticky_suggestion_min_length = 1

inoremap <expr> <tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr> <s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"

" takes the first suggestion. 
inoremap <expr> <cr> pumvisible() ?  "\<c-n>\<esc>\a":  "\<cr>"

augroup StickySuggestionMenuGroup
	au!
	"au TextChangedI * noautocmd call s:onKeystroke()
	au InsertCharPre * noautocmd call s:onKeystroke()
augroup end

function! s:onKeystroke()
    if v:char == ' ' | return | endif
	if pumvisible() == 1 | return | endif
	let p = 1
	while p < g:sticky_suggestion_min_length
		let p += 1
		let cc = getline('.')[col('.')-p] =~ '\K'
		if cc == 0 | return | endif
	endwhile
	
	if &omnifunc == '' 
		call feedkeys("\<c-x>\<c-i>")
		return
	endif
	call feedkeys("\<c-x>\<c-o>")
endfunction
