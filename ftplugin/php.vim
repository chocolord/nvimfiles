" indentation
setlocal tabstop=4
setlocal shiftwidth=4

" Basic functions
inorea <buffer> *+f public function
inorea <buffer> *-f private function
inorea <buffer> *#f protected function

" keywords
inorea <buffer> *+ public
inorea <buffer> *- private
inorea <buffer> *# protected
inorea <buffer> *c class
inorea <buffer> *e extends
inorea <buffer> *i implements
inorea <buffer> *r return
inorea <buffer> *t throw

let b:did_ftplugin = 1
