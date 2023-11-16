FROM dart:stable

ENV PATH="/srv/flutter/bin:$PATH"

RUN apt-get update && \
    apt-get install --no-install-recommends -y \
        clang cmake curl git libgtk-3-dev liblzma-dev \
        libstdc++-12-dev libglu1-mesa pkg-config \
        ninja-build unzip xz-utils zip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    git clone https://github.com/flutter/flutter.git \
        -b stable --depth 1 \
        /srv/flutter && \
    flutter precache && \
    flutter doctor -v
