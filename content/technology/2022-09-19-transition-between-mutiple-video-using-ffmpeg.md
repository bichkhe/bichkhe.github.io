+++
title = "Thiết lập hiệu ứng giữa các videos sử dụng ffmpeg"
date = 2022-09-19
description = 'Thiết lập đường dẫn media upload files cho Django'
template = 'page.html'
draft = true
[taxonomies]

[extra]
image =  'assets/img/demo/3.jpg'
+++

# Thiết lập hiệu ứng giữa các videos sử dụng ffmpeg

Giả sử chúng ta có các file video mp4 trong thư mục outfile
Chúng ta muốn nối các file này với nhau có hiệu ứng

## Môi trường ffmpeg

- ffmpeg v4.2 với các cấu hình sau
  Chú ý: `--enable-filter=gltransition `

```shell
ffmpeg version 4.2 Copyright (c) 2000-2019 the FFmpeg developers
  built with gcc 9 (Ubuntu 9.4.0-1ubuntu1~20.04.1)
  configuration: --prefix=/usr/local --enable-gpl --enable-nonfree --enable-libass --enable-libfdk-aac --enable-libfreetype --enable-libmp3lame --enable-libtheora --enable-libvorbis --enable-libvpx --enable-libx264 --enable-libx265 --enable-opengl --enable-libaom --enable-filter=gltransition --extra-libs='-lGLEW -lglfw'
```

- Download https://github.com/transitive-bullshit/ffmpeg-gl-transition

## Chú ý khi cài đặt

Một số thư viện cần cài đặt

- `glvnd1.0`
- `GLEW`
- `apt install xvfb (Ubuntu)`

## Câu lệnh chạy

Chạy lệnh này trước trên cửa sổ khác

```shell
Xvfb :1 -screen 0 1280x1024x16

```

Chạy lệnh này trên cửa sổ chạy câu lệnh ffmpeg ở dưới

```shell
export DISPLAY=:1
```

Để chạy được bạn cần thư mục các hiệu ứng transitions. Bạn có thể download nó tại https://github.com/gl-transitions/gl-transitions/tree/master/transitions

Ví dụ 1 file `angular.glsl`

```shell
// Author: Fernando Kuteken
// License: MIT

#define PI 3.141592653589

uniform float startingAngle; // = 90;

vec4 transition (vec2 uv) {

float offset = startingAngle _ PI / 180.0;
float angle = atan(uv.y - 0.5, uv.x - 0.5) + offset;
float normalizedAngle = (angle + PI) / (2.0 _ PI);

normalizedAngle = normalizedAngle - floor(normalizedAngle);

return mix(
getFromColor(uv),
getToColor(uv),
step(normalizedAngle, progress)
);
}

```

Câu lệnh của chúng ta

```
ffmpeg \
 -i outfile/roar2.mp4 \
 -i outfile/roar5.mp4 \
 -i outfile/roar1.mp4 \
 -i outfile/roar9.mp4 \
 -i outfile/roar8.mp4 \
 -i outfile/roar10.mp4 \
 -filter_complex " \
 [0:v]split[v000][v010]; \
 [1:v]split[v100][v110]; \
 [2:v]split[v200][v210]; \
 [3:v]split[v300][v310]; \
 [4:v]split[v400][v410]; \
 [5:v]split[v500][v510]; \
 [v000]trim=0:4[v001]; \
 [v010]trim=4:6[v011t]; \
 [v011t]setpts=PTS-STARTPTS[v011]; \
 [v100]trim=0:4[v101]; \
 [v110]trim=4:6[v111t]; \
 [v111t]setpts=PTS-STARTPTS[v111]; \
 [v200]trim=0:4[v201]; \
 [v210]trim=4:6[v211t]; \
 [v211t]setpts=PTS-STARTPTS[v211]; \
 [v300]trim=0:3[v301]; \
 [v310]trim=3:6[v311t]; \
 [v311t]setpts=PTS-STARTPTS[v311]; \
 [v400]trim=0:3[v401]; \
 [v410]trim=3:6[v411t]; \
 [v411t]setpts=PTS-STARTPTS[v411]; \
 [v500]trim=0:3[v501]; \
 [v510]trim=3:9[v511t]; \
 [v511t]setpts=PTS-STARTPTS[v511]; \
 [v011][v101]gltransition=duration=5:source=./transitions/cannabisleaf.glsl[vt0]; \
 [v111][v201]gltransition=duration=5:source=./transitions/BookFlip.glsl[vt1]; \
 [v211][v301]gltransition=duration=5:source=./transitions/DreamyZoom.glsl[vt2]; \
 [v311][v401]gltransition=duration=5:source=./transitions/CircleCrop.glsl[vt3]; \
 [v411][v501]gltransition=duration=5:source=./transitions/directional-easing.glsl[vt4]; \
 [v001][vt0][vt1][vt2][vt3][vt4][v511]concat=n=7[outv]" \
 -map "[outv]" \
 -c:v libx264 -profile:v baseline -preset slow -movflags faststart -pix_fmt yuv420p \
 -c:a copy \
 -y results/roar3-audio.mp4

```

Đầu ra là trong thư mục results/

Ngồi chờ và tận hưởng thành quả!
