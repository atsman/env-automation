" Helpers:

" Takes a foreground color name, background color name, and optionally one or
" more attr-list items as input, transforms it to the format accepted by
" airline#themes#generate_color_map and returns that value
func! s:clr(fg, bg, ...)
  let l:fg = g:runo#palette[a:fg]
  let l:bg = g:runo#palette[a:bg]
  return [ l:fg[0], l:bg[0], l:fg[1], l:bg[1] ] +
       \ filter(copy(a:000), 'type(v:val) == 1 && len(v:val) > 0')
endfunc

" Takes three ['fg', 'bg'] color lists and optionally a dictionary of extra
" key-value pairs and returns the value generated by
" airline#themes#generate_color_map after optionally merging the dictionary of
" extra key-value pairs.
"
" a:a -> airline_a, airline_x
" a:b -> airline_b, airline_y
" a:c -> airline_c, airline_z
func! s:color_map(a, b, c, ...)
  if a:0 == 0
    return call('airline#themes#generate_color_map', [call('s:clr', a:a), call('s:clr', a:b), call('s:clr', a:c)])
  else
    return call('extend', [ call('airline#themes#generate_color_map', [call('s:clr', a:a), call('s:clr', a:b), call('s:clr', a:c)]) ] + a:000)
  endif
endfunc

"}}}

let g:airline#themes#runo#palette = {
\   'normal': s:color_map(
\       ['black_2', 'blue_3'],
\       ['black_2', 'blue_3'],
\       ['black_2', 'gray_1'],
\       {
\         'airline_warning': s:clr('black_2', 'red_4'),
\         'airline_error': s:clr('black_2', 'red_2'),
\       },
\     ),
\   'normal_modified': s:color_map(
\       ['black_2', 'blue_3'],
\       ['black_2', 'blue_3'],
\       ['black_2', 'yellow_2'],
\       {
\         'airline_warning': s:clr('black_2', 'red_4'),
\         'airline_error': s:clr('black_2', 'red_2'),
\       },
\     ),
\   'insert': s:color_map(
\       ['black_2', 'green_2'],
\       ['black_2', 'green_2'],
\       ['black_2', 'gray_1'],
\       {
\         'airline_warning': s:clr('black_2', 'red_4'),
\         'airline_error': s:clr('black_2', 'red_2'),
\       },
\     ),
\   'insert_modified': s:color_map(
\       ['black_2', 'green_2'],
\       ['black_2', 'green_2'],
\       ['black_2', 'yellow_2'],
\       {
\         'airline_warning': s:clr('black_2', 'red_4'),
\         'airline_error': s:clr('black_2', 'red_2'),
\       },
\     ),
\   'replace': s:color_map(
\       ['gray_2', 'red_4'],
\       ['black_2', 'pink_0'],
\       ['black_2', 'gray_1'],
\       {
\         'airline_warning': s:clr('black_2', 'red_4'),
\         'airline_error': s:clr('black_2', 'red_2'),
\       },
\     ),
\   'replace_modified': s:color_map(
\       ['gray_2', 'red_4'],
\       ['black_2', 'pink_0'],
\       ['black_2', 'black_0'],
\       {
\         'airline_warning': s:clr('black_2', 'red_4'),
\         'airline_error': s:clr('black_2', 'red_2'),
\       },
\     ),
\   'visual': s:color_map(
\       ['black_2', 'yellow_2'],
\       ['black_2', 'yellow_2'],
\       ['black_2', 'gray_1'],
\       {
\         'airline_warning': s:clr('black_2', 'red_4'),
\         'airline_error': s:clr('black_2', 'red_2'),
\       },
\     ),
\   'visual_modified': s:color_map(
\       ['black_2', 'yellow_2'],
\       ['black_2', 'yellow_2'],
\       ['black_2', 'gray_1'],
\       {
\         'airline_warning': s:clr('gray_2', 'red_4'),
\         'airline_error': s:clr('gray_2', 'red_2'),
\       },
\     ),
\   'inactive': s:color_map(
\       ['black_2', 'gray_1'],
\       ['black_2', 'gray_1'],
\       ['black_2', 'gray_1'],
\       {
\         'airline_warning': s:clr('gray_2', 'red_4'),
\         'airline_error': s:clr('gray_2', 'red_2'),
\       },
\     ),
\   'terminal': s:color_map(
\       ['gray_2', 'pink_2'],
\       ['black_2', 'pink_0'],
\       ['black_2', 'gray_1'],
\       {
\         'airline_term': s:clr('black_2', 'gray_1'),
\       },
\     ),
\}

" Extensions
" Tabline
if get(g:, 'airline#extensions#tabline#enabled', 0)
  let g:airline#themes#runo#palette.tabline = {
        \ 'airline_tabfill': s:clr('gray_2', 'black_3'),
        \
        \ 'airline_tab': s:clr('gray_2', 'black_3'),
        \ 'airline_tabsel': s:clr('black_2', 'gray_2'),
        \ 'airline_tabmod': s:clr('black_2', 'green_0'),
        \
        \ 'airline_tab_right': s:clr('pink_0', 'gray_2'),
        \ 'airline_tabsel_right': s:clr('black_2', 'green_3'),
        \ 'airline_tabmod_right': s:clr('black_2', 'green_3'),
        \}
endif

" CtrlP:
if exists('g:loaded_ctrlp')
  let g:airline#themes#runo#palette.ctrlp = airline#extensions#ctrlp#generate_color_map(
        \ s:clr('black_2', 'gray_1'),
        \ s:clr('black_2', 'pink_0'),
        \ s:clr('black_2', 'pink_2'),
        \)
endif

" vim: fdm=marker ts=2 sts=2 sw=2:
