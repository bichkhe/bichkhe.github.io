+++
title = "[Rust] Sự khác nhau giữa String vs &str trong ngôn ngữ lập trình Rust"
date = 2022-09-20
description = 'Sự khác nhau giữa String vs &str trong ngôn ngữ lập trình Rust. Cách hiểu chính xác'
template = 'page.html'

[taxonomies]
rustlang = ['Rust']

[extra]
image = 'assets/img/intro/rust.png'
+++

Hôm nay chúng ta sẽ phân biệt kiểu dữ liệu String và kiểu dữ liệu &str

# Mục đích

- String: Kiểu dữ liệu cấu trúc dữ liệu dạng String
- &str: Kiểu dữ liệu một con trỏ đến một chuỗi

# Giải thích

Giả sử chúng ta có đoạn

```rust
fn main() {
    let str1 = String::from("Lập trình sư: Rót Gia Văn");
    let str2 = &str1;
    let str3 = "Rót Gia Văn";
}
```

Kiểu dữ liệu String luôn tạo dữ liệu trên vùng nhớ heap và sử dụng str1 để trỏ dữ liệu đến vùng này

Dòng `let str3 = "Rót Gia Văn";` thì `"Rót Gia Văn"` sẽ được tạo trong vùng nhớ global và con trỏ `str3` kiểu &str sẽ trỏ đến nó

Dòng `let str2 = &str1;` con trỏ str2 lưu giữ địa chỉ của str1
nhưng cái khác là str1 kiểu &String còn kiểu str2 là &str
Nếu bạn in ra \*str2 và str1 đều như nhau

<img src="/assets/img/rust/rust-string-vs-str-in-rust5.png">

# Nhìn vào bộ nhớ

<img src="/assets/img/rust/rust-string-vs-str-in-rust3.png">

Chúng ta có thể thấy String thực chất là một vector có địa chỉ
`$4 = (*mut alloc::string::String) 0x7fffffffd3c0`
và có con trỏ trở tới địa chỉ `0x5555555a9ad0 "hello world\000"`

Thử in ra giá trị tại ô nhớ này
<img src="/assets/img/rust/rust-string-vs-str-in-rust4.png">

Kết quả là: `Hello world`

# Biến đổi từ String tới &str và ngược lại

## Từ String tới &str

Chúng ta sử dụng `as_str()` hoặc `as_mut_str()`
<img src="/assets/img/rust/rust-string-vs-str-in-rust2.png">

```rust
fn main(){
    let str0 = String::from("Rót Gia Văn")
    let str1 = str0.as_str();
    String str1 = str0.as_mut_str();
}


```

## Từ &str tới String

```rust
fn main(){
    let str0 = "Rót Gia Văn lập trình Rust";
    let str1 = str0.to_string();// String
    let str2 = str0.to_owned(); // String
    let str3 = str0.into();// String
}
```

Sử dụng 2 hàm `to_string()` và `to_owned()`

<img src="/assets/img/rust/rust-string-vs-str-in-rust1.png">

Sự khác nhau là to_string() là hàm biến đổi tất cả các kiểu thực hiện trait
`trait ToString` còn `to_owned()` cấp phát buffer và copy các bytes vào trong buffer này.

## Tóm lại

- Cùng là con trỏ nhưng trỏ đến vùng nhớ khác nhau
- String luôn cấp phát trong vùng heap bộ nhớ
- &str cấp phá trên stack và có thể trỏ đến heap hoặc stack
- Các hàm để biến đổi qua nhau
