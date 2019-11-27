### 한국어 관련 피드백 안내

이 자료는 Kholia/OSX-KVM을 기반으로 보다 쉬운 카탈리나 10.15.1 설치를 목적으로 하고 있습니다
보다 자세한 방법과 설치중 오류 발생 관련 문제는 [식스플로우](https://sixflow.kr) 질문/답변 게시판을 이용해 주세요

### 설치 필수 요구 사항

* 리눅스 배포판이 필요합니다(서버/웍스/데스크탑 버전 구애 받지 않음) 이를테면 Ubuntu 18.04 LTS 64-bit등을 꼽을 수 있습니다
* QEMU 버전은 2.11.1 이상이어야 사용 가능합니다
* Intel은 VT-x / AMD는 SVM을 지원해야 하며 CMOS 바이오스에서 반드시 활성화 시키도록 합니다
* SSE4.1과 AVX2를 지원하지 않는 경우 카탈리나(10.15.x)는 설치되지 않습니다
* 카탈리나 운영체제 사용은 하스웰 리프레시부터 사용 가능합니다
* 리눅스 설치 과정에서 반드시 스왑 파티션을 만들어 주세요 (64GB 메모리 기준 5GB정도면 됩니다)

### 설치 가이드

```
$ cd ~
$ git clone https://github.com/zisqo/OSX-KVM.git
```
* 홈 폴더에 OSX-KVM 관련 파일을 다운로드 합니다

```
$ sudo apt-get install qemu uml-utilities virt-manager dmg2img git wget libguestfs-tools
```
* QEMU 및 관련 필수 패키지를 다운로드 합니다

```
$ sudo -s
$ cd OSX-KVM
$ echo 1 > /sys/module/kvm/parameters/ignore_msrs
$ sudo cp kvm.conf /etc/modprobe.d/kvm.conf
```
* MSR lock 관련 패치를 진행합니다

```
$ qemu-img create -f qcow2 mac_hdd_ng.img 128G
```
* 가상 머신이 설치될 디스크를 생성합니다
* 만약 식스플로우에서 사전 설치본 (24G)을 다운로드 받는다면 이 과정을 패스해 주세요

___
가상 머신에서 네트워크 설정은 BCM4360을 패스스루 할 것이므로, 별도 설정을 진행하지 않습니다
___
