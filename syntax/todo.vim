syn match myDate '\d\d/\d\d' contained
syn match myDate '\d\d/\d\d/\d\d\d\d' contained
syn keyword mySemaine Lundi Mardi Mercredi Jeudi Vendredi nextgroup=myDate skipwhite

syn match myTodo '^\s*> .*'
syn match ok '^\s*- .*'
syn match myPb '^\s*! .*'

let b:current_syntax = "todo"

hi def link mySemaine Define
hi def link myDate Define

hi def link myTodo SpecialComment
hi def link ok String
hi def link myPb Exception

