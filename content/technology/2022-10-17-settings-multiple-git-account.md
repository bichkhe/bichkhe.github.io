+++
title = "[GIT] Thiết lập nhiều git accounts trên cùng một máy tính"
date = 2022-10-17
description = 'Nhiều khi chúng ta có nhiều tải khoản git và cùng 1 lúc lại làm việc trên nhiều project với mỗi tài khoản khác nhau.'
template = 'page.html'
draft = false
[taxonomies]

[extra]
image =  'assets/img/demo/5.jpg'
+++

# Đặt vấn đề

Nhiều khi chúng ta có nhiều tải khoản git và cùng 1 lúc lại làm việc trên nhiều project với mỗi tài khoản khác nhau. Cách nào để có thể  sử dụng nhiều hơn 1 tài khoản git cùng trên 1 máy


Giả sử có 2 projects
- project1 với folder /home/bichkhe/project1 ->account git là `bichkhe2, mr.bichkhe2@gmail.com`
- project 2 với folder /home/bichkhe/project2 --> account git là `bichkhe2, mr.bichkhe2@gmail.com`

Trong thư mục `~/.ssh/` chúng ta có 2 bộ cặp key `~/.ssh/id_rsa_bichkhe1` và `~/.ssh/id_rsa_bichkhe2`

Mục đích là khi ở thư mục project1 thì chúng ta là `bichkhe1` và ở project 2 chúng ta là `bichkhe2` và sử dụng những cặp key khác nhau

Bạn có thể thắc mắc là sao ko dùng chung 1 key thì lúc xác thực cho tiện. Là bởi vì, khi sử dụng github bạn add 1 key ở 1 tài khoản, thì tài khoản kia sẽ ko thể thêm key đó vào được nữa

# Solution

Chúng ta sử dung includeIf trong file .gitconfig
## Cấu hình 2 accounts

Tạo 2 files .gitconfig-bichkhe1 trong /home/bichkhe/project1/.gitconfig-bichkhe1 và file
.gitconfig-bichkhe1  trong /home/bichkhe/project2/.gitconfig-bichkhe2

Nội dung 2 files như sau:

### .gitconfig-bichkhe1
```yaml
[user]
email = mr.bichkhe1@gmail.com
name = bichkhe1

[github]
user = “bichkhe1”

[core]
sshCommand = ssh -i ~/.ssh/id_rsa_bichkhe1                                    
```
### .gitconfig-bichkhe2
```yaml

[user]
email = mr.bichkhe2@gmail.com
name = bichkhe2

[github]
user = “bichkhe2”

[core]
sshCommand = ssh -i ~/.ssh/id_rsa_bichkhe2                                  
```


### Cấu hình trong file .gitconfig thư mục ~/.gitconfig

```yaml
[includeIf "gitdir:~/project1/"]
    path = ~/project1/.gitconfig-bichkhe1
[includeIf "gitdir:~/project2/"]
    path = ~/project2/.gitconfig-bichkhe2
```
Cầu hình trên nghĩa là khi vào thư mục ~/project1/ thì theo cấu hình `~/project1/.gitconfig-bichkhe1` và 
trong thư mục ~/project2/ thì ăn theo cấu hình `~/project2/.gitconfig-bichkhe2`

### Kiểm tra
Vào thư mục ~/project1 và gọi 
```shell
git config user.name
``` 
--> Nếu ra bichkhe1 là đúng

Tương tự,
Vào thư mục ~/project2 và gõ 
```shell
git config user.name
```
Kì vọng chúng ta sẽ ra bichkhe2


# Một số command hữu dụng

## Liệt kê danh sách cấu hình

```bash
git config --list 
```

## Debug khi không thể lấy pull hoặc push  từ remote 
```bash
ssh -vT git@github.com:bichkhe/<project_name>.git
```
## Sử dụng ssh thay vì dùng https

Ở chế độ này bạn mới có thể dùng key được, nên command này rất cần thiết
```bash
git config --global url.ssh://git@github.com/.insteadOf https://github.com/
```

## Tạo cặp key

```bash
ssh-keygen 
```


Hi vọng bạn đã có thể thiết lập cho bản thân mình