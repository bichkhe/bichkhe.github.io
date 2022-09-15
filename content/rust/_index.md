+++
title = 'Rust'
description = "Nhật ký Rust"
template = "rust/section.html"
sort_by = "date"
paginate_by = 5
[taxonomies]
rustlang = ['Rust']
[extra]
image = 'assets/demo/blog5.jpg'
+++

Bài hôm nay chúng ta sẽ tìm hiểu về Rust - Một ngôn ngữ lập trình được cộng đồng lập trình yêu thích nhất 6 năm gần đây

```rust
let str1 = String::from("Rust Tiếng Việt");
```

<h1>Macro là gì?</h1>

Macro không phải là khái niệm mới trong lập trình nhưng Macro trong Rust thực sự lạ và độc đáo.
Có 3 kiểu Macro cơ bản:

- Macro function
- Precedural Macro

```rust
mod cook_food;

use cook_food::american::kfc;
use cook_food::vietnamese;

fn main() {
    println!("Hello, world!");
    vietnamese::pho::cook_pho();
    vietnamese::pho::pho_thin::cook_phothin();
    // Tuy phở thìn fake không public nhưng nhờ thông qua pho_thin mod re-export
    // lại ta có thể gọi được hàm này
    vietnamese::pho::pho_thin::cook_phothin_f();
}
```

Trong nhiều ngôn ngữ lập trình, bạn không thường xuyên phải nghĩ về **stack** và **heap**. Nhưng trong một ngôn ngữ lập trình hệ thống như Rust, việc một giá trị nằm trên stack hay heap sẽ tác động đến cách ngôn ngữ hoạt động và lý do cho những quyết định của bạn. Những phần của ownership sẽ được mô tả trong mối quan hệ với stack và heap ở phần sau trong chương này, ngắn gọn thì có thể giải thích như sau.

Cả stack và heap đều là một phần của bộ nhớ cho code sử dụng khi runtime, nhưng chúng được cấu tạo theo những cách khác nhau. Stack lưu giá trị theo thứ tự nó nhận được và loại bỏ giá trị ở chiều ngược lại. Nó thường được nhắc đến là vào sau ra trước. Hãy tưởng tượng nó như một chồng đĩa: khi bạn thêm đĩa, bạn đặt chúng vào phía trên chồng đĩa, và khi bạn cần một chiếc đĩa, bạn sẽ lấy nó ra từ phía trên. Bạn không thể thêm và bớt đĩa từ phần giữa của chồng đĩa. Việc thêm dữ liệu được gọi là pushing onto the stack, và việc xóa dữ liệu được gọi là popping off the stack.

Tất cả dữ liệu lưu trên stack phải có kích thước cố định được biết trước. Dữ liệu với kích thước không biết trước khi biên dịch hoặc kích thước có thể thay đổi phải được lưu trên heap. Heap ít có tổ chức hơn: khi bạn đưa dữ liệu vào heap, bạn yêu cầu một không gian nhất định. Bộ cấp phát bộ nhớ tìm một khoảng trống trong heap đủ rộng, đánh dấu nó là đang được sử dụng và trả về một con trỏ chính là địa chỉ của vùng đó. Tiến trình này được gọi là allocating on the heap và đôi khi được viết tắt là allocating. Việc đẩy giá trị vào stack không được coi là allocating. Bởi vì con trỏ là một giá trị đã biết, có kích thước cố định, bạn có thể lưu con trỏ trên stack nhưng khi bạn muốn dữ liệu thật sự, bạn phải đi theo con trỏ.

Tưởng tượng như việc tìm chỗ ngồi ở một nhà hàng. Khi bạn vào nhà hàng, bạn nói số người trong nhóm của bạn, nhân viên sẽ tìm một bàn trống đủ chỗ cho mọi và dẫn bạn tới đó. Nếu ai đó trong nhóm đến muộn, họ có thể hỏi chỗ ngồi của bạn ở đâu để tìm bạn.

Đẩy vào stack nhanh hơn so với việc cấp phát trên bộ nhớ heap bởi vì bộ cấp phát không bao giờ phải tìm một nơi để lưu dữ liệu mới; vị trí đó luôn là đỉnh của stack. Cấp phát không gian trên heap yêu cầu nhiều công việc hơn, bởi vì bộ cấp phát trước tiên phải tìm một khoảng không gian đủ lớn để lưu dữ liệu, sau đó thực hiện bookkeeping để chuẩn bị cho lần cấp phát kế tiếp.

Truy cập dữ liệu trên heap chậm hơn với trên stack bởi vì bạn phải theo con trỏ để đến được đó. Các bộ xử lý hiện đại xử lý nhanh hơn nếu chúng nhảy qua lại trong bộ nhớ ít hơn. Tương tự, ví dụ ở một nhà hàng lấy yêu cầu từ nhiều bàn. Cách hiệu quả nhất là lấy tất cả yêu cầu ở một bàn một lần trước khi chuyển sang bàn tiếp theo. Việc lấy yêu cầu từ bàn A, rồi yêu cầu ở bàn B, rồi lại ở bàn A, rồi lại ở bàn B sẽ chậm hơn rất nhiều. Cùng vì lẽ đó, một bộ xử lý có thể làm việc của nó tốt hơn nếu nó làm việc với các dữ liệu gần nhau (như trên stack) thay vì xa nhau (như trên heap). Việc phân bổ một lượng lớn không gian trên heap cũng có thể mất thời gian.

Khi bạn gọi một hàm, những giá trị đã truyền vào hàm (có thể bao gồm cả con trỏ đến dữ liệu trên heap) và những biến cục bộ của hàm được đẩy vào stack. Khi hàm kết thúc, những giá trị này sẽ bị loại khỏi stack.

Luôn theo dõi những phần code nào đang sử dụng dữ liệu gì trên heap, tối thiểu lượng dữ liệu lặp lại trên heap và dọn dẹp dữ liệu không dùng trên heap, do đó bạn sẽ không dùng hết không gian là tất cả những vấn đề mà ownership hướng tới. Một khi bạn hiểu về ownership, bạn sẽ không cần nghĩ về stack và heap thường xuyên nữa, mà biết về việc quản lý dữ liệu heap là lý do ownership tồn tại có thể giúp giải thích tại sao nó lại hoạt động như vậy.
