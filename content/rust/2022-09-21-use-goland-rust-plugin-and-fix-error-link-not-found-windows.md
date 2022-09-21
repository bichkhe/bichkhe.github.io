+++
title = "[Rust] Lập trình Rust trên Window sử dụng Goland-plugin Rust và sửa lỗi not found link.exe"
date = 2022-09-21
description = 'Trong bài này mình sẽ hướng dẫn các bạn cài đặt và lập trình Rust trên Windows - Khắc phục lỗi not found linke.exe khi dùng toolchain msvc'
template = 'page.html'

[taxonomies]
rustlang = ['Rust']

[extra]
image = 'assets/img/rust/2022-09-21_rust-in-window.png'
+++

Trong bài này mình sẽ hướng dẫn các bạn cài đặt và lập trình Rust trên Windows

# Cài đặt Rust Toolchain trên

Đầu tiên bạn vào trang chủ và download

<img src="/assets/img/rust/2022-09-21_rust-in-window1.png" alt="download rust">

Nhấn vào file exe và chọn 1 để cài đặt mặc định

# Cài đặt Golang và download Rust plugin

Các bước:

- Cài đặt golang
- Dowload rust plugin
- Import vào Goland

Bước 1.
Bạn lên trang [Download Goland Editor](https://www.jetbrains.com/go/download/#section=windows) và tiến hành cài đặt như bình thường

Bước 2. Download Rust plugin

[Rust plugin](https://plugins.jetbrains.com/plugin/8182-rust/versions#tabs)
Chúng ta được 1 file dạng: `intellij-rust-xxx.zip`. Của mình là

```
intellij-rust-0.4.178.4873-222.zip
```

Bước 3: Import vào Goland

<img src="/assets/img/rust/2022-09-21_rust-in-window2.png" alt="download rust">

Làm theo các bước mình note ở trong ảnh nhé

# Khắc phục lỗi not found link.exe

Nguyên nhân lỗi này là bạn lập trình trên windows đang dùng toolchain là
`stable-x86_64-pc-windows-msvc (default)`
mà lại chưa cài bộ Vs studio Build Tool nên thiếu mất chương trình `link.exe`

Có 2 cách

1. Download vsToolBuild
   Đào mộ cài ảnh cũ
   <img src="/assets/img/rust/2022-09-21_rust-in-window4.png" alt="download rust">

Giao diện khi cài đặt
<img src="/assets/img/rust/2022-09-21_rust-in-window3.png" alt="download rust">

2. Cài toolchain gnu
   `stable-x86_64-pc-windows-gnu (default)`

# Cách kiểm tra đang dùng toolchain gì

<img src="/assets/img/rust/2022-09-21_rust-in-window5.png" alt="download rust">

```shell
rustup show
```

Thay đổi toolchain bằng câu lệnh sau

```shell
rustup default stable-x86_64-pc-windows-gnu
```

Giờ bạn có thể chạy chương trình mà không bị lỗi `"not found link.exe"`

```rust
C:/Users/Admin/.cargo/bin/cargo.exe run --color=always --package tauri-app --bin tauri-app
   Compiling tauri-app v0.1.0 (D:\2022\TuanPA\RustProjs\tauri-app)
    Finished dev [unoptimized + debuginfo] target(s) in 0.36s
     Running `target\debug\tauri-app.exe`
Hello, world!
```
