# flutter_bili_app

## 设计一个网络库的思路：
- 支持网络库，不干扰业务
- 简单易用，支持配置来进行请求
- Adapter 设计，可扩展
- 统一异常和返回处理

## 底层 request 封装
- 封装 HiNet 网络请求