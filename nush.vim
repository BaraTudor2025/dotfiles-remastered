"let g:pos = {}
au! CursorMoved * let g:pos = deepcopy(v:event)
"let g:pos = [] 
"au! VisualChanged * :call add(g:pos, deepcopy(v:event))
normal! h
"call assert_equal(g:pos.start_line, 0)
"call assert_equal(g:pos.end_line, 0)
"call assert_equal(g:pos.start_col, 0)
"call assert_equal(g:pos.end_col, 0)
