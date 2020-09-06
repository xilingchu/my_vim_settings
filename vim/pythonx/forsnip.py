## Python Scrip for Fortran Snippets
import re

def expBlock(foo):
    exp_sym = '!'
    len_exp = 40
    foo     = foo[1:-1].title()
    foo     = ' ' + foo + ' '
    len_foo = len(foo)
    if len_foo % 2 == 1:
        len_exp += 1
    len_dash = int((len_exp - len_foo)/2)
    str_dash = len_dash*'-'
    str_tar = exp_sym + str_dash +  foo +  str_dash + exp_sym
    return str_tar



if __name__ == '__main__':
    str_test = expBlock('this is just a test')
    print(str_test)
