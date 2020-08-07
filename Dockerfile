FROM tensorflow/pytorch:1.6.0-cuda10.1-cudnn7-runtime

MAINTAINER edclol

USER root

RUN chmod 777 /tmp && \
        apt update && \
        echo "172.16.1.127  master" >> /etc/hosts && \
        echo "172.16.1.200  work01" >> /etc/hosts && \
        echo "172.16.1.179  work02" >> /etc/hosts && \
        apt install -y git && \
        apt install -y apt-file && \
        apt install -y busybox && \
        apt install -y libsm6 libxext6 libxrender-dev libxrender1 libfontconfig1 && \
        pip3 install requests psutil py-cpuinfo pandas typing hdfs pyhdfs minio matplotlib numpy imutils opencv-python sklearn \
        -i http://pypi.douban.com/simple/ --trusted-host pypi.douban.com && \
        rm -rf /var/lib/apt/lists/*

ADD bootstrap.sh /etc/bootstrap.sh
ADD save.py /etc/save.py

ENTRYPOINT ["/etc/bootstrap.sh"]
