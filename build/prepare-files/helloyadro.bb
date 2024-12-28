SUMMARY = "Hello Yadro program"

LICENSE = "MIT"

LIC_FILES_CHKSUM = "file://../../../../../../../meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"

SRC_URI = "file://helloyadro.c"

S = "/home/ravendexter/poky/build/tmp/work/core2-64-poky-linux/helloyadro/1.0-r0/build"

do_compile() {
        gcc -g -lm /home/ravendexter/poky/build/tmp/work/core2-64-poky-linux/helloyadro/1.0-r0/helloyadro.c -o /home/ravendexter/poky/build/tmp/work/core2-64-poky-linux/helloyadro/1.0-r0/build/helloyadro
}

do_install() {
        install -d /home/ravendexter/poky/build/tmp/work/core2-64-poky-linux/helloyadro/1.0-r0/image/usr/bin
        install -m 0755 /home/ravendexter/poky/build/tmp/work/core2-64-poky-linux/helloyadro/1.0-r0/build/helloyadro /home/ravendexter/poky/build/tmp/work/core2-64-poky-linux/helloyadro/1.0-r0/image/usr/bin/ 
}