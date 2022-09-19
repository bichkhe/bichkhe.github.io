+++
title = "[Rust Series] Cài đặt môi trường WSL để lập trình Rust"
date = 2022-09-20
description = 'Sự khác nhau giữa String vs &str trong ngôn ngữ lập trình Rust. Cách hiểu chính xác'
template = 'page.html'

[taxonomies]
rustlang = ['Rust']

[extra]
image = 'assets/img/intro/rust.png'
+++

Chúng ta nên sử dụng Linux để có thể lập trình Rust. Bạn đang dùng windows mà muốn có môi trường linux nhưng lại không muốn cài đặt máy ảo

WSL là thứ mà bạn cần

# WSL là gì?

Windows Subsytem Linux

WSL (Windows Subsystem for Linux) là một tính năng có trên Windows x64 (từ Windows 10, bản 1607 và trên Windows Server 2019), nó cho phép chạy hệ điều hành Linux (GNU/Linux) trên Windows. Với WSL bạn có thể chạy các lệnh, các ứng dụng trực tiếp từ dòng lệnh Windows mà không phải bận tâm về việc tạo / quản lý máy ảo như trước đây. Cụ thể, một số lưu ý mà Microsoft liệt kê có thể làm với WSL:

Chọn sử dụng distro Linux từ Microsoft Store: Hiện giờ đang có các Distro Linux rất gọn nhẹ trên Store sử dụng được ngày như Ubuntu, Debian ...
Chạy được từ dòng lệnh các lệnh linux như ls, grep, sed ... hoặc bất kỳ chương trình nhị phân 64 bit (ELF-64) nào của Linux
Chạy được các công cụ như: vim, emacs ...; các ngôn ngữ lập trình như NodeJS, JavaScript, C/C++, C# ..., các dịch vụ như MySQL, Apache, lighthttpd ...
Có thể thực hiện cài đặt các gói từ trình quản lý gói của Distro đó (như lệnh apt trên Ubuntu)
Từ Windows có thể chạy các ứng dụng Linux (dòng lệnh)
Từ Linux có thể gọi ứng dụng của Windows

## Môi trường

Đảm bảo windows của bạn phiên bản >= 16.07

Kiểm tra bằng dòng lệnh

```shell

PS C:\Users\ASUS> [System.Environment]::OSVersion.Version

Major  Minor  Build  Revision
-----  -----  -----  --------
10     0      22000  0
```

Như máy mình là bản 22000 nên okie

## Kích hoạt tính năng Subsystem

```shell
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux

dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all
```

## Kiểm tra distro linux nào đã cài đặt

```shell
wsl -l --all
```

Hiện tại chưa bản nào cài đặt

## Cài đặt ubuntu 20.04

Truy cập vào Store theo link trên, trong danh sách Distro Linux tùy chọn cài đặt cái nào muốn dùng, ví dụng nếu chọn Ubuntu thì chọn biểu tượng Ubuntu

<img src="https://raw.githubusercontent.com/xuanthulabnet/windows/master/docs/windows-005.png" alt="Cài đặt Ubuntu Subsystem Linux">

## Kiểm tra sau khi cài đặt

```shell
wsl -l -all

wsl -l --running

wsl

```

Sau khi gõ `wsl` chung ta sẽ vào được màn hình như sau là thành công

<img src="/assets/img/rust/wsl-1.png" alt="Môi trường Ubuntu Subsystem Linux - Lập trình Rust">

- Kiểm tra version

```shell
wsl --set-default-version 2
PS C:\Users\ASUS>  wsl --list --verbose
  NAME      STATE           VERSION
* Ubuntu    Running         2
```

Chúng ta đang dùng WSL2

Giờ bạn đã có môi trường Linux trên windows rồi. Không cần phải cài máy ảo

Cùng bắt đầu cài đặt Rust và Editor để code Rust thôi!

Đón đọc bài tiếp: `Cài đặt môi trường Rust và Editor để lập trình Rust`
