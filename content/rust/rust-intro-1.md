+++
title = "[Bài 1] Giới thiệu lập trình Rust"
date = 2022-09-16
description = 'Ngôn ngữ lập trình Rust'
template = 'page.html'

[taxonomies]
rustseries = ['Rust']

[extra]
image = 'assets/img/demo/1.jpg'
+++

Series này hướng đến mục tiêu là nắm được cơ bản về Rust.

## Tài liệu tham khảo

- Rust by examples 54: Học Rust kết hợp với thực hành online. Nếu bạn học một mình và cảm thấy khá là chán khi chỉ ngồi đọc docs và (có thể) phải loay hoay với việc cài đặt đủ thứ thì học ở trang này nhanh, gọn, lẹ.

- The Rust Official Docs – Second Edition 20: Trang chủ của ebook học Rust.

- The Rust Standard Library 11: Tài liệu cho thư viện chuẩn.

- Docs.rs 8: Trang tài liệu cho các thư viện (viết bằng Rust) khác.

- stackoverflow.com: Học cho đã cũng đừng quên chúng ta còn stackoverflow.com nhé :wink:

Những trang khác:

- Rust Playground 10: bạn có thể test nhanh code trên trình duyệt.

- The Rustonomicon 6: Chuyên sâu về Rust (chắc là mình không viết bài về cái này đâu, ai thích thì có thể tham khảo, mình thấy nó cũng không khó hiểu gì lắm đâu).

- Rust Sụbrédđít 6: the Rust Programming Language subreddit, nơi đây cập nhật tin tức đủ thứ về Rust :crab:

## Đặc tính nổi bật

Rust cũng có các điểm thuận lợi và bất lợi. Ngay từ trang chủ, đập vào mắt là Rust:

- Nhanh, Rust là ngôn ngữ biên dịch và không có GC (garbage collector: bộ dọn rác) như các ngôn ngữ thông dịch hay biên dịch (như Go) khác. Tốc độ thực tiệm cận với C/C++. Tham khảo chỉ mang tính tham khảo the benchmarksgame 16.
- Move semantics (không biết dịch sao cho vừa lòng) và Guaranteed Memory Safety (đảm bảo an toàn bộ nhớ): nghĩa là khi một biến gán giá trị cho một biến khác thì cũng sẽ chuyển quyền sở hữu của nó cho biến đó, dĩ nhiên là nó không thể nào đọc/ghi được giá trị nữa. Thực tế: bạn không thể nào có quyển sách đó nếu bạn đã đưa nó cho người khác. Xét 2 ví dụ đơn giản giữa C++ và Rust (xem ở cuối section này).
- Type inference: Rust compiler có khả năng suy luận ra kiểu của biến. Như ví dụ bên dưới: mình hoàn toàn bỏ qua được `rust Vec<int>` trong let `v: Vec<int>` ..., Rust compiler vẫn biết được kiểu của v là Vec<int>.
  Prevent data races: Khi bạn sử dụng nhiều threads cùng đọc ghi đồng thời vào một vùng nhớ sẽ dẫn đến data races, Rust không cho phép điều này xảy ra. Ví dụ thực tế, cả lớp (các threads) cùng tự ý ghi vào bảng (vùng nhớ) thì sẽ dẫn đến một mớ hỗn độn, kết quả là dữ liệu bên trong vùng nhớ không còn chính xác nữa (bạn có thể tham khảo với từ khóa data races là gì với Google.
  R- ust hỗ trợ generics, pattern matching (powered by some functional programming languages). Rust code có thể gọi C code, có nghĩa là: bạn vẫn có thể dùng các thư viện có sẵn khác mà không cần phải đợi thư viện đó viết bằng Rust, và cũng như, bạn có thể viết các thư viện cho các ngôn ngữ khác như Python, Java, … với native code.
- Rust đi chung với toolchains rất hiệu quả. Chỉ với lệnh cargo, bạn chỉ cầm thêm tên thư viện vào file Cargo.toml của projet rồi chạy cargo build --release là nó sẽ làm từ A-Z cho bạn: tải thư viện, biên dịch, optimize luôn. Không có khó khăn gì ở đây hết!
  Trình biên dịch của Rust cho ra lỗi rất hữu ích (hầu hết các trường hợp). Hữu ích đến nỗi, bạn có thể nhắm mắt làm theo hướng dẫn của trình biên dịch mà không cần dùng não. (Đùa thôi, bạn phải dùng não, nhưng đó cũng là sự thật của mình lúc mới học Rust).
  Còn nữa … (chừng nào nhớ ra với dịch được thì update tiếp :joy: )

```c++
// C++
#include <iostream>
#include <vector>
int main() {
    std::vector<int> v = {0, 1, 2, 3};
    std::vector<int> v2 = v;
    std::cout << "v[1]: " << v[1] << std::endl;
    return 0;
}

```

```rust
fn main() {
    let v: Vec<int> = vec![0, 1, 2, 3];
    let v2 = v;
    println!("v[1]: {}", v[1]);
}
```

Trong 2 ví dụ trên, C++ hoàn toàn có thể compile và chạy được nhưng Rust không cho phép compile vì sau khi gán, v không còn quyền truy cập tới vùng nhớ đó nữa.
Đây cũng là một trong các quy tắc nghiêm ngặt của Rust. Cũng vì các quy tắc đó làm cho chương trình của Rust xanh sạch đẹp và không có lỗi runtime.

Rust cũng có nhiều điểm bất lợi, ý kiến riêng của mình:
Phức tạp: Rust đã phức tạp và cả phức tạp dần theo thời gian. Team Rust làm việc rất tâm huyết :triumph: ngôn ngữ ngày có nhiều cập nhật và đổi mới, mình nghĩ đây cũng là điểm mạnh và cũng là điểm yếu. Vì thay đổi quá nhiều dẫn đến ngôn ngữ “không ổn định”, các thư viện cũ sẽ gặp nhiều rắc rối nếu không được update thường xuyên (mặc dù đã có các tools. Bạn nên học dần để dễ dàng bắt kịp :3 Mình không cho là Rust khó học, Rust chỉ “hơi” phức tạp một xíu, concepts hơi lạ so với bạn một chút xíu và sẽ mất thời gian hơn một xíu nhưng cũng đáng mà :smiley:
Mọi thứ cần rõ ràng: vì lý do rustc cũng chỉ là “cái máy” nên nó không thật sự linh hoạt. Code bạn viết ra cần rõ ràng, đôi khi thứ tự khai báo biến cũng là nguyên nhân dẫn đến lỗi.
Có thể còn nhiều điểm yếu khác nữa mà mình chưa biết …
Chi tiết và sinh động hơn, các bạn hãy đọc bài của chú thefullsnack tại đây 21 (chú trả tiền cho con vì pr dùm chú đi :stuck_out_tongue: ).

## Cài đặt

Đối với các bạn sử dụng \*nix thì vẫn có các package riêng lẻ như `rustc`, `cargo`, … mình thấy nó sẽ khá rối và update thì phải đợi mirror. Mình muốn đơn giản thì chỉ cần theo hướng dẫn là đủ. Nếu trong quá trình cài đặt xuất hiện lỗi thì bạn có thể reply post này, mình sẽ cố gắng hỗ trợ. (Mình không có lưu ý gì vì mình chưa cài lỗi bao giờ :smile:)

## Q&A

Q: Kinh nghiệm kiểu abc, xyz,… như tui thì có học được không?

A: Muốn thì được hết. Nhưng có thể sẽ phức tạp hơn các ngôn ngữ bạn từng học nên cần thời gian. Vì phức tạp nên cũng dễ nản, chuyện đương nhiên mà! Nhưng đừng lo, nó sẽ đáng công sức bạn bỏ ra. Lý do?

Q: Khoảng bao lâu thì tui sẽ nắm vững cơ bản như cú pháp?

A: Tùy vào mỗi người, một vài tuần gì đấy, mình đoán vậy. Chưa bao gồm thời gian học sử dụng macros (cái này nâng cao rồi :3 )

Q: Học Rust thì làm được gì?

A: Ừhm, C/C++ làm được gì thì Rust làm được cái đó! Như: games, browsers, OSes, websites, wasm apps, … và hệ thống nhúng (Rust làm được nhưng chắc chưa bằng C được, mình không rõ mảng này cho lắm).

Q: So sánh Rust với ngôn ngữ X, Y, Z,… đi?

A: Bạn có thể tham khảo Google, cũng khá nhiều. Bản thân Rust phức tạp hơn (và phức tạp dần theo thời gian) so với hầu hết các ngôn ngữ phổ biến khác nên sẽ khó khăn cho nhiều người kể cả người có kinh nghiệm lập trình lâu năm. Nếu bạn chưa học lập trình bao giờ, hoàn toàn ổn nếu bạn chọn Rust là ngôn ngữ đầu tiên, nhưng nếu Rust là ngôn ngữ thứ 2 thì có vẻ căng đấy vì những khái niệm của Rust sẽ làm cho bạn rối với ngôn ngữ bạn vừa học (nếu bạn không bị rối thì quá tốt rồi :smiley: ).

Q: Nói quá trời nói rồi công ty nào xài Rust?

A:

Q: Muốn coi thử một chương trình viết bằng Rust thì trông nó như thế nào?

A:
