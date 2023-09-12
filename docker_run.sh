docker run -it \
		--gpus all \
		--ipc host \
		--shm-size 8G \
		-v /data0:/data0 \
		-v /data1:/data1 \
		talklip:0.0.1 \
        /bin/bash