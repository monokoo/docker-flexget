FROM lsiobase/alpine.python3:3.9

ENV S6_BEHAVIOUR_IF_STAGE2_FAILS="2"

# Set python to use utf-8 rather than ascii.
ENV PYTHONIOENCODING="UTF-8"

ENV TZ Asia/Shanghai
ENV LANG C.UTF-8

# Add edge/testing repositories.
RUN printf "\
@edge https://mirrors.ustc.edu.cn/alpine/edge/main\n\
@testing https://mirrors.ustc.edu.cn/alpine/edge/testing\n\
@community https://mirrors.ustc.edu.cn/alpine/edge/community\n\
" > /etc/apk/repositories

# Copy local files.
COPY etc/ /etc
RUN chmod -v +x \
    /etc/cont-init.d/*  \
    /etc/services.d/*/run

# Ports and volumes.
EXPOSE 6566/tcp
VOLUME /config
