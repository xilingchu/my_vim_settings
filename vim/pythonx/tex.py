#That is a python script for latex file in vim
def tableline(num):
    n = int(num)
    goal = ''
    for i in range(0, n):
        if i == 0:
            goal = goal + 'c'
        else:
            goal = goal + ' c'
    return goal


def table(num1, num2):
    n1 = int(num1)
    n2 = int(num2)
    goal = ''
    count = 0
    for i in range(1, n1+1):
        if i == 2:
            goal = goal + '\midrule' + '\n'
        for j in range(1, n2+1):
            if j==n2:
                goal = goal + r' \\'
            else:
                goal = goal + r' & '
        if i != n1:
            goal = goal + '\n'
    return goal


def expBlock(foo):
    exp_sym = '%'
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
