+++
title = "Thiết lập hiệu ứng giữa các videos sử dụng ffmpeg"
date = 2022-09-19
description = 'Hiệu ứng chuyển cảnh giữa các video và thêm chữ cũng như nhạc sử dụng ffmpeg'
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

```shell
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

## Thêm text và nhạc

```python
class VideoGenerator:
    def __init__(self, videos, transitions, texts, output_name, duration=3):
        self.command = ''
        self.output = output_name
        self.videos = videos
        self.duration = duration
        self.photos = []
        self.texts = texts
        self.transitions = transitions
        self.vstreams = []
        self.inputs = []
        self.splits = []
        self.trims = []

    def run_export_display(self):
        cmd = 'export DISPLAY=:1'
        os.system(cmd)

    def build_command(self):
        cmd = 'ffmpeg '
        splits = ''
        for k, v in enumerate(self.videos):
            input1 = "-i %s" % v
            self.inputs.append(input1)
            split = '[%d:v]split[v%d00][v%d10];' % (k, k, k)
            # splits += split
            self.splits.append(split)
        cmd += " ".join(self.inputs)
        cmd += ' -i ./media/videos/roar.mp3'  # audio default

        cmd += ' -filter_complex '
        cmd += '\"'
        cmd += "".join(self.splits)
        DRAW_TEXT = 'drawtext=text=\'%s\':fontcolor=white:fontsize=24:box=1:boxcolor=black@0.5:boxborderw=5:x=(w-text_w)/2:y=(h-text_h)/2' % (
            self.texts[random.randint(
                    0, len(self.texts)-1)]
        )
        for k, v in enumerate(self.videos):
            i_stream1 = '[v%d00]' % k
            o_stream11 = '[v%d01]' % k
            i_stream2 = '[v%d10]' % k
            o_stream22x = '[v%d11x]' % k
            o_stream22t = '[v%d11t]' % k
            o_stream22 = '[v%d11]' % k
            trim1 = i_stream1 + 'trim=0:' + \
                str(self.duration) + o_stream11 + "; "
            trim2 = i_stream2 + 'trim=' + \
                str(self.duration) + ':' + \
                str(self.duration+2) + o_stream22x + "; "
            trim3 = o_stream22x + \
                DRAW_TEXT + \
                o_stream22t + "; "
            trim4 = o_stream22t + 'setpts=PTS-STARTPTS' + o_stream22 + '; '
            self.trims.append(trim1+trim2+trim3 + trim4)
            v = VStream(i_stream1, o_stream11, i_stream2,
                        o_stream22t, o_stream22)
            self.vstreams.append(v)

        cmd += "".join(self.trims)

        concat = self.vstreams[0].stream11
        for i in range(len(self.vstreams)-1):
            current_vstream = self.vstreams[i]
            j = i + 1
            next_vstream = self.vstreams[j]
            o_stream = '[vt%d]' % i
            gl = current_vstream.stream22 + next_vstream.stream11
            transition = 'gltransition=duration=' + \
                str(self.duration) + ':source=./media/transitions/' + \
                self.transitions[random.randint(
                    0, len(self.transitions)-1)] + o_stream + ";"
            concat += o_stream
            cmd += gl
            cmd += transition

        concat += self.vstreams[len(self.vstreams)-1].stream22
        concat += 'concat=%d' % (len(self.vstreams) + 1)+'[outv]'
        cmd += concat
        cmd += '\" '

        cmd += '-map [outv] -c:v libx264 -profile:v baseline -preset slow -movflags faststart -pix_fmt yuv420p '
        cmd += '-map %d:a:0 ' % len(self.videos)
        cmd += '-y ./media/results/%s.mp4' % self.output

        self.command = cmd
        print(self.command)

    def run(self):
        self.run_export_display()
        os.system(self.command)
```

Cách sử dụng

```python
def main():
    videos = [
        'outfile/roar3.mp4',
        'outfile/roar4.mp4',
        'outfile/roar5.mp4',
        'outfile/roar6.mp4',
        'outfile/roar7.mp4',
    ]
    transitions =[
        'wind.glsl',
        'circle.glsl'
    ]
    texts = [
        'Học từ quá khứ',
        'Nhìn về tương lai'
    ]
    cli = VideoGenerator(videos, transitions, texts,  "output")
    cli.build_command()
    cli.run()

```

Đầu ra là như sau:

```shell
ffmpeg -i media/videos/blackpink8.mp4 -i media/videos/blackpink9.mp4 -i media/videos/blackpink10_swSTXHi.mp4 -i media/videos/blackpink11_hmmIfrZ.mp4 -i media/videos/blackpink12.mp4 -i media/videos/blackpink13.mp4 -i media/videos/blackpink14.mp4 -i media/videos/blackpink15_kNY3wOj.mp4 -i media/videos/blackpink16.mp4 -i media/videos/blackpink17.mp4 -i media/audios/roar.mp3 -filter_complex "[0:v]split[v000][v010];[1:v]split[v100][v110];[2:v]split[v200][v210];[3:v]split[v300][v310];[4:v]split[v400][v410];[5:v]split[v500][v510];[6:v]split[v600][v610];[7:v]split[v700][v710];[8:v]split[v800][v810];[9:v]split[v900][v910];[v000]trim=0:3[v001]; [v010]trim=3:5[v011x]; [v011x]drawtext=text='Text2':fontcolor=white:fontsize=24:box=1:boxcolor=black@0.5:boxborderw=5:x=(w-text_w)/2:y=(h-text_h)/2[v011t]; [v011t]setpts=PTS-STARTPTS[v011]; [v100]trim=0:3[v101]; [v110]trim=3:5[v111x]; [v111x]drawtext=text='Text2':fontcolor=white:fontsize=24:box=1:boxcolor=black@0.5:boxborderw=5:x=(w-text_w)/2:y=(h-text_h)/2[v111t]; [v111t]setpts=PTS-STARTPTS[v111]; [v200]trim=0:3[v201]; [v210]trim=3:5[v211x]; [v211x]drawtext=text='Text2':fontcolor=white:fontsize=24:box=1:boxcolor=black@0.5:boxborderw=5:x=(w-text_w)/2:y=(h-text_h)/2[v211t]; [v211t]setpts=PTS-STARTPTS[v211]; [v300]trim=0:3[v301]; [v310]trim=3:5[v311x]; [v311x]drawtext=text='Text2':fontcolor=white:fontsize=24:box=1:boxcolor=black@0.5:boxborderw=5:x=(w-text_w)/2:y=(h-text_h)/2[v311t]; [v311t]setpts=PTS-STARTPTS[v311]; [v400]trim=0:3[v401]; [v410]trim=3:5[v411x]; [v411x]drawtext=text='Text2':fontcolor=white:fontsize=24:box=1:boxcolor=black@0.5:boxborderw=5:x=(w-text_w)/2:y=(h-text_h)/2[v411t]; [v411t]setpts=PTS-STARTPTS[v411]; [v500]trim=0:3[v501]; [v510]trim=3:5[v511x]; [v511x]drawtext=text='Text2':fontcolor=white:fontsize=24:box=1:boxcolor=black@0.5:boxborderw=5:x=(w-text_w)/2:y=(h-text_h)/2[v511t]; [v511t]setpts=PTS-STARTPTS[v511]; [v600]trim=0:3[v601]; [v610]trim=3:5[v611x]; [v611x]drawtext=text='Text2':fontcolor=white:fontsize=24:box=1:boxcolor=black@0.5:boxborderw=5:x=(w-text_w)/2:y=(h-text_h)/2[v611t]; [v611t]setpts=PTS-STARTPTS[v611]; [v700]trim=0:3[v701]; [v710]trim=3:5[v711x]; [v711x]drawtext=text='Text2':fontcolor=white:fontsize=24:box=1:boxcolor=black@0.5:boxborderw=5:x=(w-text_w)/2:y=(h-text_h)/2[v711t]; [v711t]setpts=PTS-STARTPTS[v711]; [v800]trim=0:3[v801]; [v810]trim=3:5[v811x]; [v811x]drawtext=text='Text2':fontcolor=white:fontsize=24:box=1:boxcolor=black@0.5:boxborderw=5:x=(w-text_w)/2:y=(h-text_h)/2[v811t]; [v811t]setpts=PTS-STARTPTS[v811]; [v900]trim=0:3[v901]; [v910]trim=3:5[v911x]; [v911x]drawtext=text='Text2':fontcolor=white:fontsize=24:box=1:boxcolor=black@0.5:boxborderw=5:x=(w-text_w)/2:y=(h-text_h)/2[v911t]; [v911t]setpts=PTS-STARTPTS[v911]; [v011][v101]gltransition=duration=3:source=./media/transitions/BookFlip.glsl[vt0];[v111][v201]gltransition=duration=3:source=./media/transitions/BookFlip.glsl[vt1];[v211][v301]gltransition=duration=3:source=./media/transitions/BookFlip.glsl[vt2];[v311][v401]gltransition=duration=3:source=./media/transitions/angular.glsl[vt3];[v411][v501]gltransition=duration=3:source=./media/transitions/angular.glsl[vt4];[v511][v601]gltransition=duration=3:source=./media/transitions/angular.glsl[vt5];[v611][v701]gltransition=duration=3:source=./media/transitions/angular.glsl[vt6];[v711][v801]gltransition=duration=3:source=./media/transitions/BookFlip.glsl[vt7];[v811][v901]gltransition=duration=3:source=./media/transitions/angular.glsl[vt8];[v001][vt0][vt1][vt2][vt3][vt4][vt5][vt6][vt7][vt8][v911]concat=11[outv]" -map [outv] -c:v libx264 -profile:v baseline -preset slow -movflags faststart -pix_fmt yuv420p -map 11:a:0 -y ./media/results/tuanpa3.mp4
```

Chú ý: mặc định tại thư mục `media/videos` có chứa các file mp4, thư mục `media/audios` chứa file `roar.mp3` (hard code)
và `media/transitions/` chứa các hiệu ứng.

Ngồi chờ và tận hưởng thành quả!
