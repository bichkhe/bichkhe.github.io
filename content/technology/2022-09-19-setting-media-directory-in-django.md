+++
title = "Thiết lập đường dẫn khi upload files trong dự án Django"
date = 2022-09-19
description = 'Thiết lập đường dẫn media upload files cho Django'
template = 'page.html'

[taxonomies]

[extra]
image =  'assets/img/demo/3.jpg'
+++

## Django framework

Giả sử chúng ta có dùng câu lệnh sau để tạo

```shell
django create-project videos_system

```

Chúng ta có

```
└── videos_system
    ├── __init__.py
    ├── __pycache__
    │   ├── __init__.cpython-310.pyc
    │   ├── settings.cpython-310.pyc
    │   ├── urls.cpython-310.pyc
    │   └── wsgi.cpython-310.pyc
    ├── asgi.py
    ├── settings.py
    ├── urls.py
    └── wsgi.py
```

Trong file settings.py thêm dòng này vào cuối

```python

import os
SETTINGS_PATH = os.path.dirname(os.path.dirname(__file__))
print('SETTINGS_PATH:', SETTINGS_PATH)
TEMPLATE_DIRS = (
    os.path.join(SETTINGS_PATH, 'templates'),
)
# Static files (CSS, JavaScript, Images)
# https://docs.djangoproject.com/en/4.1/howto/static-files/
SITE_ROOT = SETTINGS_PATH
STATIC_URL = '/static/'
STATIC_ROOT = BASE_DIR / 'static'
STATICFILES_DIRS = (
    os.path.join(SITE_ROOT, 'media'),
)
MEDIA_ROOT = BASE_DIR / 'media'
MEDIA_URL = 'media/'


```

Trong files urls.py trông giống như sau

```python
from django.contrib import admin
from django.urls import path
from django.conf.urls.static import static
from django.contrib.staticfiles.urls import staticfiles_urlpatterns
from . import settings

urlpatterns = [
    path('admin/', admin.site.urls),
] + static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
urlpatterns += staticfiles_urlpatterns()

```

## Sử dụng

Giả sử trong models như sau

```python
from django.db import models
class Video(models.Model):
    video = models.FileField(
        upload_to="videos"
    )
```

Thì thư mục videos nghĩa là `/media/videos`
Thư mục media cùng cấp với thư mục `videos_system` và files `manage.py`
