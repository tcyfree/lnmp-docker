# LNMP Docker - 在国内快速构建LNMP容器环境

快速构建开发、测试、生产L(Alpine Linux ) + N(Nginx) + M(MariaDB) + P(PHP7.1.14) + Supervisor + Redis + Crontab Docker 容器应用环境，



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
安装 [ctop](https://github.com/bcicen/ctop) 工具可以帮助查看容器在主机的使用情况。

```bash
 $ ctop
 ctop - 15:36:35 CST      10 containers

   NAME                        CID                         CPU                         MEM                         NET RX/TX                   IO R/W                      PIDS
 ◉  lnmp-mariadb                bd3cecff945e                             0%                     179M / 7.64G        90K / 276K                  27M / 0B                    0
 ◉  lnmp-nginx                  f4452c868dcc                             0%                      8M / 7.64G         14M / 5M                    5M / 0B                     0
 ◉  lnmp-php-fpm                a68c55c28995                             0%                      72M / 7.64G        1M / 13M                    20M / 0B                    0
 ◉  lnmp-php-supervisor         15182399966b                             1%                     1.8G / 7.64G        92M / 145M                  26M / 0B                    0
 ◉  lnmp-redis                  279b2f995b2a                             0%                      8M / 7.64G         62M / 16M                   2M / 0B                     0
 ◉  lnmp-www                    09c684094c18                              -                           -             -                           -                           -  
```
