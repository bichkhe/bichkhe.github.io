+++
title = "[Rust] Chuyển đổi giữ String, Vec<u8> và &str"
date = 2022-10-18
description = 'Hôm nay chúng ta sẽ học cách biến đổi qua lại giữa các kiểu String, Vec<u8>, Vec<char> và &str'
template = 'page.html'

[taxonomies]
rustlang = ['Rust']

[extra]
image = 'assets/img/intro/rust.png'
+++
Hôm nay chúng ta sẽ học cách biến đổi qua lại giữa chúng. Bài này sẽ khá hữu ích 


### Biến đổi từ Vec<char> tới String và  &str

```rust
let src1: Vec<char> = vec!['j','{','"','i','m','m','y','"','}']; 
  // to String
  let string1: String = src1.iter().collect::<String>();  
  // to str
  let str1: &str = &src1.iter().collect::<String>();
  // to vec of byte
  let byte1: Vec<u8> = src1.iter().map(|c| *c as u8).collect::<Vec<_>>();
  println!("Vec<char>:{:?} | String:{:?}, str:{:?}, Vec<u8>:{:?}", src1, string1, str1, byte1);

```
Ở dòng `let string1: String = src1.iter().collect::<String>();`
// Duyệt qua và gọi hàm collect(). Vì kiểu trả về là T nên ta dùng cú pháp tuborfish ::<> để chỉ rõ kiểu T trả về là gì

Hoặc có thể dùng map để chuyển đổi tới Vec của các bytes

### Khởi tạo từ mảng bytes

```rust
  // -- FROM: vec of bytes --
  // in rust, this is a slice
  // b - byte, r - raw string, br - byte of raw string
  let src2: Vec<u8> = br#"e{"ddie"}"#.to_vec();
  // to String
  // from_utf8 consume the vector of bytes
  let string2: String = String::from_utf8(src2.clone()).unwrap();
  // to str
  let str2: &str = str::from_utf8(&src2).unwrap();
  // to vec of chars
  let char2: Vec<char> = src2.iter().map(|b| *b as char).collect::<Vec<_>>();
  println!("Vec<u8>:{:?} | String:{:?}, str:{:?}, Vec<char>:{:?}", src2, string2, str2, char2);

```

Giải thích: `br#` là bắt đầu mảng raw byte, gọi hàm `to_vec()` để chuyển đổi sang kiểu Vec<u8>
Kiểu String có hàm `from_utf8` --> trả về String
Một số giải thích ở đây 

```
pub fn from_utf8(vec: Vec<u8, Global>) -> Result<String, FromUtf8Error>
Converts a vector of bytes to a String.

A string (String) is made of bytes (u8), and a vector of bytes (Vec<u8>) is made of bytes, so this function converts between the two. Not all byte slices are valid Strings, however: String requires that it is valid UTF-8. from_utf8() checks to ensure that the bytes are valid UTF-8, and then does the conversion.

If you are sure that the byte slice is valid UTF-8, and you don’t want to incur the overhead of the validity check, there is an unsafe version of this function, from_utf8_unchecked, which has the same behavior but skips the check.

This method will take care to not copy the vector, for efficiency’s sake.

If you need a &str instead of a String, consider str::from_utf8.

The inverse of this method is into_bytes.
```
Tương tự với kiểu &str

```rust
let str2: &str = str::from_utf8(&src2).unwrap();
```

### Từ String 

```rust
 // -- FROM: String --
  let src3: String = String::from(r#"o{"livia"}"#);
  let str3: &str = &src3;
  let char3: Vec<char> = src3.chars().collect::<Vec<_>>();
  let byte3: Vec<u8> = src3.as_bytes().to_vec();
  println!("String:{:?} | str:{:?}, Vec<char>:{:?}, Vec<u8>:{:?}", src3, str3, char3, byte3);

```
String gọi hàm as_bytes() hoặc chars() 


### Từ &str 

```rust
 // -- FROM: str --
  let src4: &str = r#"g{'race'}"#;
  let string4 = String::from(src4);
  let char4: Vec<char> = src4.chars().collect();
  let byte4: Vec<u8> = src4.as_bytes().to_vec();
  println!("str:{:?} | String:{:?}, Vec<char>:{:?}, Vec<u8>:{:?}", src4, string4, char4, byte4);

```
Tương tự ta cũng có 2 hàm giống như String: `as_bytes` và `chars`


Hi vọng là biến đổi qua lại như thế này bạn sẽ không gặp khó khăn khi gặp kiểu này

Còn về ý nghĩa của từng kiểu, cần học và cân nhắc khi sử dụng.

