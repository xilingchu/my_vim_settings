## Python Scrip for Python Snippets
import re

def objectInInit(foo1, foo2):
    output_str = ''
    start_str = re.compile(r'\s*,')
    if foo1 != 'object':
        output_str = 'super().__init__(self)' + '\n\t\t'.replace('\t', ' '*4)
    if start_str.match(foo2) is not None:
        targets = foo2.split(',')[1:]
        for tar in targets:
            temp_str = 'self.{} = {}'.format(tar.strip(),tar.strip())
            output_str += temp_str + '\n\t\t'.replace('\t', ' '*4)
    return output_str

def expBlock(foo):
    exp_sym = '#'
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
