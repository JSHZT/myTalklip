import os
import os.path as osp

meta_id_list=[]
data_root = '/data1/video_preprocess_all'
iden_list = os.listdir(data_root)
test_flag = True
with open("/data0/hzt/code/data_preprocess/target-list.txt", "r") as f:
    for line in f:
        meta_id_list.append(line.strip('\n'))
for iden in meta_id_list:
    if osp.exists(osp.join(data_root, iden, 'DATAPROCESS', 'sentence')):
        sentence_list = os.listdir(osp.join(data_root, iden, 'DATAPROCESS', 'sentence'))
        for i, sentence in enumerate(sentence_list):
            if sentence == "audio-16k.wav" or sentence == "asr_result.npz":
                continue
            split = 'train' if i % 20 != 0 else ('test' if test_flag else 'valid')
            test_flag = False if test_flag else True
            with open(f"/data0/hzt/code/TalkLip/data_list/{split}.txt", "a+") as f:
                f.writelines(osp.join(iden, 'DATAPROCESS/sentence', sentence))
                f.writelines("\n")
            