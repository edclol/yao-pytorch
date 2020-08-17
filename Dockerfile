FROM pytorch/pytorch:1.6.0-cuda10.1-cudnn7-runtime

MAINTAINER edclol

USER root

RUN chmod -R 777 /tmp && \
        apt update && \
        echo "172.16.1.127  master" >> /etc/hosts && \
        echo "172.16.1.200  work01" >> /etc/hosts && \
        echo "172.16.1.179  work02" >> /etc/hosts && \
        apt install -y --no-install-recommends git && \
        apt install -y apt-file && \
        apt install -y busybox && \
        pip install requests psutil py-cpuinfo pandas typing hdfs pyhdfs minio matplotlib numpy imutils sklearn \
        -i http://pypi.douban.com/simple/ --trusted-host pypi.douban.com && \
        pip install opencv-python  -i https://pypi.tuna.tsinghua.edu.cn/simple &&\
        rm -rf /var/lib/apt/lists/*

ADD bootstrap.sh /etc/bootstrap.sh
ADD save.py /etc/save.py

ENTRYPOINT ["/etc/bootstrap.sh"]
