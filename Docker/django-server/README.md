# 运行
```sh
# 生成 django-admin 项目
$ docker-compose run web django-admin startproject django_example .
由于 web 服务所使用的镜像并不存在，所以 Compose 会首先使用 Dockerfile 为 web 服务构建一个镜像，
接着使用这个镜像在容器里运行 django-admin startproject django_example 指令。

# 修改 django_example/settings.py 文件中 DATABASES = ... 定义的节点内容。
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': 'postgres',
        'USER': 'postgres',
        'HOST': 'db',
        'PORT': 5432,
        'PASSWORD': 'postgres',
    }
}

$ docker-composer up

# 同步数据库 下面这个命令过时了，运行不了了 
$ docker-compose run web python manage.py syncdb
```