+++
title = "[Rust Series][Bài 3] Cài đặt VSCode Editor lập trình Rust và các plugin cơ bản"
date = 2022-09-20
description = 'Cài đặt công cụ để lập trình Rust -Editor: Inteliji Rust, VsCode, Vim, Emacs, Notepad++, Atom'
template = 'page.html'

[taxonomies]
rustlang = ['Rust']

[extra]
image = 'assets/img/rust/vscode.jpg'
+++

Một số tools để lập trình **Rust**

- `Inteliji Rust` cài đặt Rust plugin [Link tại đây](https://www.jetbrains.com/rust/)
- `Vim hoặc Emacs`
- `VSCode`
- `Atom`
  ...

Mình nghĩ quen tools nào sẽ dùng tool đó. Nếu code của bạn nằm cùng với hệ điều hành thì dùng bộ Jetbrains Intelijia Rust code sẽ được hỗ trợ tốt.
Debug rất chi là bá đạo

Vim với Emacs code nếu thạo thì code cũng khá bá đạo. Trước mình luyện Emacs màu mè một thời gian nhưng sau không nghịch nữa, tập trung vào code

VSCode thì tools khá xịn nhưng thỉnh thoảng plugin vs debug không được nhậy. Nhưng vì code của mình nằm trong WSL Ubuntu nên mình chọn tool này
VSCode có plugin Remote SSH nên khá ổn

## Cài đặt VSCode trên Windows

Bạn vào đây download và next [Download VSCode](https://code.visualstudio.com/download)

## Sử dụng VScode remote tới WSL Ubuntu

Đầu tiên cài đặt plugin Remote - WSL

<img src="/assets/img/rust/install-vscode-and-plugin1.png" alt="Cài đặt VSCode và Remote WSL">

Sau khi cài đặt xong ta `Ctrl + Shift + P` Gõ `WSL`

<img src="/assets/img/rust/install-vscode-and-plugin2.png" alt="Cài đặt VSCode và Remote WSL">

Chúng ta mở projects và

## Cài đặt các plugin

- `Remote WSL` : Đã cài ở trên
- `rust-analyzer`: Gợi nhắc và support ngôn ngữ Rust
- `Better TOML`
- `crates`: Quản lý các version của dependencies
- `Error Lens`: Hiển thị error ngay khi gõ câu lệnh sai

Tạm đủ lập trình Rust

Dưới đây là 1 số hình ảnh
<img src="/assets/img/rust/install-vscode-and-plugin3.png" alt="Cài đặt VSCode và Remote WSL">
<img src="/assets/img/rust/install-vscode-and-plugin4.png" alt="Cài đặt VSCode và Remote WSL">
<img src="/assets/img/rust/install-vscode-and-plugin5.png" alt="Dò lỗi ngay khi gõ lệnh Error Lens">
