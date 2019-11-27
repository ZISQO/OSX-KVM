#!/bin/bash

# qemu-img create -f qcow2 macOS_hdd.img 128G
#
# echo 1 > /sys/module/kvm/parameters/ignore_msrs (이 작업은 필수입니다)

############################################################################
# NOTE: "MY_OPTIONS" 값을 변경하면 부팅 오류를 해결 할 수 있습니다                    #
############################################################################

# 이 스크립트는 모하비처럼 카탈리나를 설치하는 것이며 10.14.6과 10.15.1에서 테스트 되었습니다

MY_OPTIONS="+pcid,+ssse3,+sse4.2,+popcnt,+avx,+aes,+xsave,+xsaveopt,check"

# OVMF=./firmware
OVMF="./"

qemu-system-x86_64 -enable-kvm -m 3072 -cpu Penryn,kvm=on,vendor=GenuineIntel,+invtsc,vmware-cpuid-freq=on,$MY_OPTIONS\
	  -machine q35 \
	  -smp 4,cores=2 \
	  -usb -device usb-kbd -device usb-mouse \
	  -device isa-applesmc,osk="ourhardworkbythesewordsguardedpleasedontsteal(c)AppleComputerInc" \
	  -drive if=pflash,format=raw,readonly,file=$OVMF/OVMF_CODE.fd \
	  -drive if=pflash,format=raw,file=$OVMF/OVMF_VARS-1024x768.fd \
	  -smbios type=2 \
	  -device ich9-intel-hda -device hda-duplex \
	  -device ich9-ahci,id=sata \
	  -drive id=Clover,if=none,snapshot=on,format=qcow2,file=./'Catalina/CloverNG.qcow2' \
	  -device ide-hd,bus=sata.2,drive=Clover \
	  -device ide-hd,bus=sata.3,drive=InstallMedia \
	  -drive id=InstallMedia,if=none,file=BaseSystem.img,format=raw \
	  -drive id=MacHDD,if=none,file=./macOS_hdd.img,format=qcow2 \
	  -device ide-hd,bus=sata.4,drive=MacHDD \
	  -netdev tap,id=net0,ifname=tap0,script=no,downscript=no -device vmxnet3,netdev=net0,id=net0,mac=52:54:00:c9:18:27 \
	  -monitor stdio \
	  -vga vmware

# 이 설치는 QEMU 윈도우를 이용해 직접 설치할 때 사용하며 클린 설치 이외엔 실행할 일이 없습니다
# macOS.xml을 필요에 맞게 변경해 운영체제를 설정을 마감하면 됩니다
