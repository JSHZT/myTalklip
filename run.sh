WORKSPACE=/root/autodl-tmp/hzt/code/TalkLip

file_list_dir=$WORKSPACE/data_list
avhubert_path=$WORKSPACE/pretrain/lip_reading_expert.pt
avhubert_root=/root/autodl-tmp/hzt/code/av_hubert
checkpoint_dir=/root/autodl-tmp/hzt/exp/TalkLip/size_256_multigpus_crop

data_root=/root/autodl-tmp/hzt/data/talklip
batch_size=1
num_worker=0


log_name=log.txt
image_size=256
cont_w=1e-3
lip_w=1e-5
perp_w=0.07
n_epoch=100
# gpu=1
ckpt_interval=2000
accumulation_steps=8
# gen_checkpoint_path=/root/autodl-tmp/hzt/exp/TalkLip/size_256_multigpus/checkpoint_step000098000.pth
# disc_checkpoint_path=/root/autodl-tmp/hzt/exp/TalkLip/size_256_multigpus/disc_checkpoint_step000098000.pth

# debug="-m debugpy --listen 0.0.0.0:5678  --wait-for-client"
# debug=''

CUDA_VISIBLE_DEVICES=0,1,2,3 python -m torch.distributed.launch --nproc_per_node=4 train.py --distributed \
                --file_dir $file_list_dir \
                --avhubert_root $avhubert_root \
                --avhubert_path $avhubert_path \
                --checkpoint_dir $checkpoint_dir \
                --log_name $log_name \
                --cont_w $cont_w \
                --lip_w $lip_w \
                --perp_w $perp_w \
                --n_epoch $n_epoch \
                --ckpt_interval $ckpt_interval \
                --data_root $data_root \
                --batch_size $batch_size \
                --num_worker $num_worker \
                --image_size $image_size \
                --accumulation_steps $accumulation_steps 
                # --gen_checkpoint_path $gen_checkpoint_path \
                # --disc_checkpoint_path $disc_checkpoint_path 

                # --gpu $gpu \

# $file_list_dir: a directory which contains train.txt, valid.txt, test.txt of LRS2 dataset
# $word_root: root directory of text annotation. Normally, it should be equal to $video_root, as LRS2 dataset puts a video file ".mp4" and its corresponding text file ".txt" in the same directory.
# $avhubert_root: path of root of avhubert (should like xxx/av_hubert)
# $avhubert_path: download the above Lip reading expert and enter its path
# $checkpoint_dir: a directory to save checkpoint of talklip
# $log_name: name of log file
# $cont_w: weight of contrastive learning loss (default: 1e-3)
# $lip_w: weight of lip reading loss (default: 1e-5)
# $perp_w: weight of perceptual loss (default: 0.07)
# $gen_checkpoint_path(optional): enter the path of a generator checkpoint if you want to resume training from a checkpoint
# $disc_checkpoint_path(optional): enter the path of a discriminator checkpoint if you want to resume training from a checkpoint

# Note: Sometimes, discriminator losses may diverge during training (close to 100). 
# Please stop the training and resume it with a reliable checkpoint.