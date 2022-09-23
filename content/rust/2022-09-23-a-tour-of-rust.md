+++
title = "[Rust Series] [Bài 5] [P1]  A tour of rust - Kiểu dữ liệu"
date = 2022-09-23
description = 'Trong bài này mình sẽ điểm nhanh một vòng cú pháp'
template = 'page.html'

[taxonomies]
rustlang = ['Rust']

[extra]
image = 'assets/img/rust/tour-of-rust.png'
+++

# Kiểu dữ liệu

## Kiểu dữ liệu nguyên thủy - Primitives Data Types

Xem xét đoạn code khi khai báo kiểu dữ liệu thông thường: interger, float, bool, pointer

### Kiểu số nguyên

```rust
    let i1 = 23;
    let i2: i32 = 1024; // Có dấu 32 bit
    let i3 = 10u32; // số  10 kiểu không dấu 32 bit
    let i4: i32 = 0x11; //hexa 16 bit
    let i5: i32 = 0o12; // dạng octa
    let i6: i64 = 0b101011; // dạng binary chỉ toàn số 0 1
    let i7: i64 = 1_000_000; // 1 triệu
```

### Kiểu số float

```rust
    let f1 = 191.32; //float32
    let f2: f32 = 102.13;
    let f3: f32 = 102.13;
    let f4 = 0.000_001; // 0.0000001
```

### Kiểu bool

```rust
    let b1 = true;
    let b2 = false;
```

### Kiểu slice string, String

```rust
     // Kiểu &str: Tham chiếu đến String
    let str1 = "hello world";
    // Kiểu std::String
    let str2 = "hello world".to_string();
    let str3 = "hello world2".to_owned();

    let str4 =  String::from("test");
    let str5 = &str4; //Kiểu &String
```

### Kiểu tupple

```rust
    // Tupple
    let empty_tupple = ();
    let long_tuple = (
        1u8, 2u16, 3u32, 4u64, -1i8, -2i16, -3i32, -4i64, 0.1f32, 0.2f64, 'a', true,
    );
```

### Kiểu mut - Giá trị có thể thay đổi được

Kiểu này bao trùm mọi dữ liệu. Cứ đặt `mut` trước các kiểu báo hiệu là mình có thể thay đổi giá trị của nó

```rust
 // Kiểu mut có thể thay đổi giá trị được
    let mut i1_mut: i64 = 1_000_000; // 1 triệu
    i1_mut = 2_000_000; // Gán lại được
                        // i1 trên không thể gán lại : i1 = 2_000_000 là không được , báo lỗi
```

### Tóm tắt

```rust
fn main() {
    //  Primitive types
    // Kiểu integer có thể biểu thị dạng 0x, 0o, 0b
    // Có thể dùng _ để biểu thị
    let i1 = 23;
    let i2: i32 = 1024; // Có dấu 32 bit
    let i3 = 10u32; // số  10 kiểu không dấu 32 bit
    let i4: i32 = 0x11; //hexa 16 bit
    let i5: i32 = 0o12; // dạng octa
    let i6: i64 = 0b101011; // dạng binary chỉ toàn số 0 1
    let i7: i64 = 1_000_000; // 1 triệu

    let f1 = 191.32; //float32
    let f2: f32 = 102.13;
    let f3: f32 = 102.13;
    let f4 = 0.000_001; // 0.0000001

    let b1 = true;
    let b2 = false;

    // Kiểu &str: Tham chiếu đến String
    let str1 = "hello world";
    // Kiểu std::String
    let str2 = "hello world".to_string();
    let str3 = "hello world2".to_owned();

    let str4 =  String::from("test");
    let str5 = &str4; //Kiểu &String

    // Tupple
    let empty_tupple = ();
    let long_tuple = (
        1u8, 2u16, 3u32, 4u64, -1i8, -2i16, -3i32, -4i64, 0.1f32, 0.2f64, 'a', true,
    );

    // Kiểu mut có thể thay đổi giá trị được
    let mut i1_mut: i64 = 1_000_000; // 1 triệu
    i1_mut = 2_000_000; // Gán lại được
                        // i1 trên không thể gán lại : i1 = 2_000_000 là không được , báo lỗi
}
```

Vài điểm chú ý:

- Các kiểu số: i32, i64, u32,u64, bool, f32, f64
- kiểu dữ liệu slice string: &str
- Mặc định là biến này không thể thay đổi giá trị. Nếu muốn thay đổi giá trị khai báo thêm `mut`.
- Hiểu `mut i32`, `mut &str`... nó là một kiểu dữ liệu và nó khác với `i32`, `i64` cho nhẹ đầu.

## Kiểm dữ liệu phức hợp - Compound

### Strings

```rust
fn main() {
    let question = "How are you ?"; // a &str type
    let person: String = "Bob".to_string();
    let namaste = String::from("नमते"); // unicodes yay!
    println!("{}! {} {}", namaste, question, person);
}
```

Kiểu `String` này cũng khá đặc biệt. Nó có thể chứa giá trị unicode được. Chúng ta hay thao tác với String và với số rất nhiều.
Cũng cần 1 bài để mô tả kỹ và cách dùng nó với unicode.
Dòng `println!("{}! {} {}", namaste, question, person);` để in ra các biến. Nó không phải là hàm mà được gọi là `macro function`
Tất cả các hàm mà có cái đuôi `!` ở cuối là như vậy. Khi nghiên cứu macro sẽ nói về vấn đề này kỹ, còn hiện tại thì cứ hiểu để in ra mấy biến kia.

PS:Rust có mỗi cái in ra biến mà không có cái hàm nào tử tế mà lại đi dùng macro function loằng nhoằng nhỉ. Nhưng có vẻ những người tạo ra ngôn ngữ này có triết lý riêng.

### Structs

```rust

struct Player {
    name: String,
    iq: u8,
    friends: u8,
    score: u16,
}
fn bump_player_score(mut player: Player, score: u16) {
    player.score += 120;
    println!("Updated player stats:");
    println!("Name: {}", player.name);
    println!("IQ: {}", player.iq);
    println!("Friends: {}", player.friends);
    println!("Score: {}", player.score);
}
fn main() {
    let name = "Alice".to_string();
    let player = Player {
        name,
        iq: 171,
        friends: 134,
        score: 1129,
    };
    bump_player_score(player, 120);
}

```

### Struct với phương thức

```rust
struct Player {
    name: String,
    iq: u8,
    friends: u8,
}
impl Player {
    fn with_name(name: &str) -> Player {
        Player {
            name: name.to_string(),
            iq: 100,
            friends: 100,
        }
    }
    fn get_friends(&self) -> u8 {
        self.friends
    }
    fn set_friends(&mut self, count: u8) {
        self.friends = count;
    }
}
fn main() {
    let mut player = Player::with_name("Dave");
    player.set_friends(23);
    println!("{}'s friends count: {}", player.name, player.get_friends());
    // another way to call instance methods.
    let _ = Player::get_friends(&player);
}

```

Các phương thức này luôn có trường đầu tiên khai báo là `&self`, hoặc `self` hoặc `&mut self`
thể hiển chính instance của struct đang thao tác(nghĩa là 1 đối tượng tạo ra). Có hơi hướng giống python khi các hàm thuộc struct đều có trường `self`.

Đối với hàm không có `self` thì nó thuộc struct nghĩa là dùng struct để gọi. Bạn hay gặp hàm `new` mà trở về chính đối tượng.
Trong `Go` thì nó cũng có `pattern` như này, gọi là `contructor` giả.
Dùng toán tử(?) `::` để truy xuất đến hàm nhé

```rust
Player::with_name("Dave");
```

### Struct dạng tupple

```rust
struct Color(u8, u8, u8);
```

Cách sử dụng có vẻ đơn giản.
Truy xuất đến phần tử theo dạng `.0`, `.1`

```rust
fn main() {
    let white = Color(251, 250, 255);
    let red = white.0; // truy xuất đến 251
    let green = white.1; //250
    let blue = white.2; //255
}

```

Destructure giống cha nọi javascript

```rust
    let orange = Color(255, 165, 0);
    let Color(r, g, b) = orange; //desctrutor
```

Ví dụ đầy đủ

```rust
fn main() {
    let white = Color(255, 255, 255);
    // You can pull them out by index
    let red = white.0;
    let green = white.1;
    let blue = white.2;
    println!("Red value: {}", red);
    println!("Green value: {}", green);
    println!("Blue value: {}\n", blue);
    let orange = Color(255, 165, 0);
    // You can also destructure the fields directly
    let Color(r, g, b) = orange;
    println!("R: {}, G: {}, B: {} (orange)", r, g, b);
    // Can also ignore fields while destructuring
    let Color(r, _, b) = orange;
}

```

### Enums

Enums trong Rust đặc biệt hơn các ngôn ngữ khác vì nó có thể chứa struct

### Enums với dữ liệu

```rust

enum Direction {
    N,
    E,
    S,
    W,
}
enum PlayerAction {
    Move { direction: Direction, speed: u8 },
    Wait,
    Attack(Direction),
}
fn main() {
    let simulated_player_action = PlayerAction::Move {
        direction: Direction::N,
        speed: 2,
    };
    match simulated_player_action {
        PlayerAction::Wait => println!("Player wants to wait"),
        PlayerAction::Move { direction, speed } => {
            println!(
                "Player wants to move in direction {:?} with speed {}",
                direction, speed
            )
        }
        PlayerAction::Attack(direction) => {
            println!("Player wants to attack direction {:?}", direction)
        }
    };
}

```

Ví dụ `Move { direction: Direction, speed: u8 }` có thể bao gồm cả `enum` với `speed` dang u8

Kỳ diệu thật
`Move{N, 2}`, `Move{E,4}`... Là những giá trị của nó

Enums sẽ cần được nghiên cứu kỹ ở bài sau. Trong Rust thì dùng điều này rất nhiều và nó còn giúp cả tăng tốc chương trình nữa

### Enums với phương thức

Ngoài ra `Enum` có thể tạo hàm.
Hàm `fn pay(&self, amount: u64)` dưới đây. self đại diện cho chính giá trị của nó.

```rust
enum PaymentMode {
    Debit,
    Credit,
    Paypal,
}
// Bunch of dummy payment handlers
fn pay_by_credit(amt: u64) {
    println!("Processing credit payment of {}", amt);
}
fn pay_by_debit(amt: u64) {
    println!("Processing debit payment of {}", amt);
}
fn paypal_redirect(amt: u64) {
    println!("Redirecting to paypal for amount: {}", amt);
}
impl PaymentMode {
    fn pay(&self, amount: u64) {
        match self {
            PaymentMode::Debit => pay_by_debit(amount),
            PaymentMode::Credit => pay_by_credit(amount),
            PaymentMode::Paypal => paypal_redirect(amount),
        }
    }
}
fn get_saved_payment_mode() -> PaymentMode {
    PaymentMode::Debit
}
fn main() {
    let payment_mode = get_saved_payment_mode();
    payment_mode.pay(512);
}

```

### Closures

```
 let doubler = |x| x * 2;
```

Một số ngôn ngữ thì gọi là lambda.

Cú pháp `|các-biến| { câu lệnh}` hoặc `|các-biến| câu lệnh` (nếu có 1 dòng lệnh)

```rust
let doubler = |x| x * 2;
let big_closure = |b, c| {
        let z = b + c;
        z * twice
      };

```

Khai báo xong nó giống một hàm. Cứ gọi thôi

```rust
//Goi closure 1
let value = 5;
let twice = doubler(value);

// Gọi closure 2
 let some_number = big_closure(1, 2);

```

Ví dụ đầy đủ ỏ đây

```rust
fn main() {
    let doubler = |x| x * 2;
    let value = 5;
    let twice = doubler(value);
    println!("{} doubled is {}", value, twice);
    let big_closure = |b, c| {
        let z = b + c;
        z * twice
    };
    let some_number = big_closure(1, 2);
    println!("Result from closure: {}", some_number);
}

```

Chúng ta đã điểm qua tương đối đầy đủ các cú kiểu dữ liệu. Bạn hoàn toàn có thể đọc được 1 số lượng code Rust rồi.
Còn 1 số vấn đề phức tạp của Struct, Enums, sẽ viết 1 bài riêng khi có lifetimes đi cùng khiến cho code trở nên rối.
Nhưng giữ đầu óc của bạn clear đi đã.

Bài tiếp theo chúng ta điểm qua về các cú pháp điều khiển. Như `if, loop, for, match...`

Hẹn gặp lại.
