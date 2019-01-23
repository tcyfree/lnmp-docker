# LNPSC Docker - 快速构建LNPSC容器环境

快速构建开发、测试、生产L(Alpine Linux ) + N(Nginx) + P(PHP7.1.14) + Supervisor + Crontab 的Docker 容器应用环境，


## 主要特性

+ 基于PHP 7.1.14版本，构建干净、轻量级PHP依赖环境。
+ 基于[Alpine Linux](https://alpinelinux.org/) 最小化Linux环境加速构建镜像。 使用 [Ali-OSM](http://mirrors.aliyun.com/) 在国内3分钟完成整个镜像构建。
+ 内置PHP Composer，支持PHP CLI/FPM两种运行模式。PHP CLI 适用于命令行、后台PHP服务。PHP FPM基于CLI基础镜像，独立安装FPM模块。Nginx容器与PHP-FPM采用Socket方式连接，提供PHP Web应用环境。
+ 提供PHP CLI模式独立运行模式参考：`call-websockt` 与 `php-superviosr`。`call-websockt` 是基于[workman](http://www.workerman.net/) 的PHP Socket服务。`php-supervior` 实现基于Supervisor的队列服务。
+ 可独立配置容器运行时环境参数，支持容器运行日志、数据与宿主机分离，方便调试与维护。
+ 支持Nginx虚拟站点、SSL证书服务。配置参考Nginx中`cert`与`conf.d`目录文件。

所有的容器基于Alpine Linux ，默认使用`sh` shell，进入容器时使用该命令：*docker exec -it container_name sh*

```bash
$ docker exec -it lnmp-nginx sh
```