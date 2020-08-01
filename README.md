# kms-server-deploy

## 一键搭建kms激活服务端和Windows客户端一键激活脚本

## 再此特别感谢KMS服务器程序的开发者Wind4

## vlmcsd Github主页：[https://github.com/Wind4/vlmcsd](https://github.com/Wind4/vlmcsd)

## 脚本的使用方法：

## 在你的服务器上，执行如下命令即可：

```shell
wget --no-check-certificate https://raw.githubusercontent.com/Mr-xn/kms-server-deploy/master/kms-server-deploy.sh && bash kms-server-deploy.sh
```

## 不会的,请看下面的我的截图操作就知道了

## Linux服务端安装卸载

### 安装

![install_0.png](./image/install_0.png)

![install_1.png](./image/install_1.png)

### 卸载

![uninstall.png](./image/uninstall.png)

## Windows上激活

### 下载(右键另存为---然后解压即可使用) [mrxn_net_kms.zip](https://raw.githubusercontent.com/Mr-xn/kms-server-deploy/master/mrxn_net_kms.zip)

### 下载后右键-以管理员身份运行
![uac_run.png](./image/uac_run.png)

### 激活中...
![going.png](./image/going.png)

### 成功激活
![success.png](./image/success.png)

### cmd（管理员权限）激活office2019专业增强版(VL版本)  
![KMS激活office2019成功](./image/KMS激活office2019成功.png)

> 更新:  
> 添加自启脚本，借鉴至秋水大佬.  
> PS:这个是从vlmcsd仓库拉取编译,安装的时候vlmcsd就是最新版本.  
> 在centos6/7 ubuntu 16 测试成功.如果有任何问题，欢迎提交issue或者是博客留言. 
>
> update：mrxn_net_kms.cmd 的编码和换行为Windows下的CRLF，避免下载后打开闪退[issues【#3】](https://github.com/Mr-xn/kms-server-deploy/issues/3)，请下载ZIP的压缩激活脚本再解压使用。

