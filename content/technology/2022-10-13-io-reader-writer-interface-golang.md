+++
title = "Tìm hiểu về reader và writer interface trong golang"
date = 2022-10-13
description = 'Chúng ta hay gặp 2 interface rất đơn giản nhưng chỉ có 1 hàm nhưng lại gây bao nhiêu khó hiểu'
template = 'page.html'
draft = false
[taxonomies]

[extra]
image =  'assets/img/demo/3.jpg'
+++

Chúng ta hay gặp 2 interface rất đơn giản nhưng chỉ có 1 hàm nhưng lại gây bao nhiêu khó hiểu

```go
type Writer interface {
    Write(p []byte) (n int, err error)
}
```

Giải thích ý nghĩa:
Những Writer là một interface mà gồm một hàm Write mà ghi p bytes vào 1 stream nào đó (stream này có thể là một buffer nào đó, một file, hoặc một luồng http body)
Nghĩa là bạn sẽ nhận được p bytes và tìm cách để ghi p bytes này theo một cách nào đó đến stream khác. 

Ví dụ: Nhận được bytes:  "Tôi học lập trình Rust thông qua lập trình Go" 

--> Khi ghi ra stream ẩn dưới: bạn sẽ chỉ cần ghi 2 từ là "Rust" và "Go" và 2 từ này sẽ được ghi vào 1 file
```go
type LanguageFileWriter interface {
    file *os.File
}

func (*LanguageFileWriter)  Write(p []byte) (n int, err error){
    // filter "Go" and "Rust" in p bytes
    // open file and write it file
}

```

## Một số cấu trúc built-in đã đã thực thi Writer interface
- bytes.Buffer
- os.File

## 
```go
func NewEncoder(w io.Writer) *Encoder

package main

import (
	"fmt"
	"encoding/json"
	"bytes"
)

type user struct {
    Name string `json:"name"`
    Age int `json:"age"`
}

func main() {
    buf := new(bytes.Buffer)
    u := user{
        Name: "bob";,
        Age: 20,
    }
    err := json.NewEncoder(buf).Encode(u)
    if err != nil {
        panic(err)
    }
    fmt.Print(buf.String())
}

```
NewEncoder nhận Writer interface như là stream cần ghi vào. 
Sau khi cấu trúc u được biến đổi sang định dạng json, nó sẽ được ghi vào writer này 

Chú ý ở đây quan niệm là nhận vào p bytes rỗng và trả là p bytes với dữ liệu định dạng json


## Một số  ngữ cảnh khác
- Ghi n bytes từ người dùng nhập nhưng loại bỏ nhưng ký tự đặc biệt và khoảng trắng
Eg: Người dùng nhập : Xin chào bạn #$% j%% 
Đầu ra là Xinchaoban

- JsonEncoder: Nhận vào một writer là mảng byte rỗng và ghi ra writer này mảng byte định dạng json


Hi vọng bài viết giúp cho cách nhìn nhận và hiểu được writer để khi code hoặc đọc không bị khó hiểu