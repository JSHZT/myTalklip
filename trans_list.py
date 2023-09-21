import os

root = '/root/autodl-tmp/hzt/data/talklip'
idenlist = os.listdir(root)
with open('iden_list.txt', 'a+') as f:
    for iden in idenlist:
        f.writelines(iden)
        f.writelines('\n')
        