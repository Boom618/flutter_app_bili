# flutter_bili_app

## 设计一个网络库的思路：
- 支持网络库，不干扰业务
- 简单易用，支持配置来进行请求
- Adapter 设计，可扩展
- 统一异常和返回处理

## 底层 request 封装
- 封装 HiNet 网络请求
- 登录注册接口
- 封装注册输入框
- 登录、注册 页面




## 遗忘知识

> flutter 的三种类型定义：class(类)、abstract class（抽象类）、 Mixin（混入）

class和abstract class与java中的差不多,mixin的类，能很好的对代码进行复用，也能让dart实现“伪多重继承”，同时又不会造成多重继承导致的菱形问题

> dart 的 with、implements、extends

with：无需 super 关键字能直接调用父类方法或者属性
