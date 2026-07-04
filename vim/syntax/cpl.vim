" Vim syntax file
" Language: CPL (cplcode.net, Paolo Luchini)
" Latest Revision: 2026

if exists("b:current_syntax")
  finish
endif

syntax case ignore

" --- Types ---
syntax keyword cplType INTEGER REAL STRING BOOLEAN CHAR FILE POINTER
syntax keyword cplType ARRAY STRUCTURE STRUCTURED CSTRING SINGLE
syntax keyword cplType ENUM TYPE DYNAMIC STORED

" --- Structure / block keywords ---
syntax keyword cplStructure MODULE SUBROUTINE FUNCTION INLINE OPERATOR END
syntax keyword cplStructure IF THEN ELSE END
syntax keyword cplStructure LOOP REPEAT FOR TO BY UNTIL WHILE ALL DO
syntax keyword cplStructure CASE EXCEPT FOLLOWS
syntax keyword cplStructure WITH USE INCLUDE
syntax keyword cplStructure EXIT STOP TRAP TRACE ERROR

" --- Declarations / qualifiers ---
syntax keyword cplStorageClass CONSTANT VARIABLE OPTIONAL NEW FREE IS IN

" --- Boolean / null-like literals ---
syntax keyword cplBoolean YES NO NULL

" --- Logical operators (word form) ---
syntax keyword cplOperator AND OR NOT

" --- I/O and builtin-ish keywords ---
syntax keyword cplIO WRITE READ FROM TO BY NAME BINARY POSITION OPEN OPENRO CREATE CLOSE FLUSH EOF INPUTREADY ASK ARG COMMANDLINE

" --- Common builtin functions ---
syntax keyword cplBuiltin ABS CEILING FLOOR ROUND MAX MIN MAXABS NORM RAND GAUSS LENGTH HI LO

" --- Comments: ! to end of line ---
syntax match cplComment "!.*$" contains=@Spell

" --- Preprocessor directives ---
syntax match cplPreProc "^\s*#\s*\(ifdef\|ifndef\|else\|endif\|define\|include\|undef\)\>.*$"

" --- Strings ---
syntax region cplString start=+"+ skip=+\\"+ end=+"+ contains=@Spell

" --- Numbers ---
syntax match cplNumber "\<\d\+\(\.\d\+\)\?\([eE][-+]\?\d\+\)\?\>"

" --- Embedded C sections: <* ... *> ---
syntax region cplCSection matchgroup=cplCDelim start="<\*" end="\*>" contains=cplString keepend

" --- Operators (symbolic) ---
syntax match cplOperator "[-+*/=<>:;,.]"
syntax match cplNotEqual "#"

let b:current_syntax = "cpl"

highlight default link cplType          Type
highlight default link cplStructure     Statement
highlight default link cplStorageClass  StorageClass
highlight default link cplBoolean       Boolean
highlight default link cplOperator      Operator
highlight default link cplNotEqual      Operator
highlight default link cplIO            Keyword
highlight default link cplBuiltin       Function
highlight default link cplComment       Comment
highlight default link cplPreProc       PreProc
highlight default link cplString        String
highlight default link cplNumber        Number
highlight default link cplCDelim        SpecialComment
highlight default link cplCSection      Special
