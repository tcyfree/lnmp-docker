#ANPSC Docker - 快速构建ANPSC容器环境

快速构建开发、测试、生产Alpine + Nginx + PHP7 + Composer + Supervisor + Crontab + Laravel 的Docker 容器应用环境


##主要特性

+ 基于[Alpine Linux](https://alpinelinux.org/) 最小化Linux环境加速构建镜像。 
+ 支持Nginx虚拟站点、SSL证书服务。配置参考Nginx中`cert`与`conf.d`目录文件。

所有的容器基于Alpine Linux,默认使用`sh` shell，进入容器时使用该命令：

```bash
$ docker exec -it container_name sh
```

运行启动：
[phpinfo](https://github.com/tcyfree/anpsc/blob/master/phpinfo.png)