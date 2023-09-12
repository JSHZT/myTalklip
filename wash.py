import os
import os.path as osp
import shutil
from tqdm import tqdm

meta_id_list=[]
data_root = '/data1/video_preprocess_all'
iden_list = os.listdir(data_root)
test_flag = True
with open("/data0/hzt/code/data_preprocess/target-list.txt", "r") as f:
    for line in f:
        meta_id_list.append(line.strip('\n'))
os.makedirs("/data1/send")
for iden in tqdm(meta_id_list):
    if osp.exists(osp.join(data_root, iden, 'DATAPROCESS', 'sentence')):
        # shutil.rmtree(target_path)
        os.makedirs(osp.join("/data1/send", iden))
        source_path = osp.join(data_root, iden, 'DATAPROCESS', 'sentence')
        target_path = osp.join("/data1/send", iden, 'sentence')
        shutil.copytree(source_path, target_path)
