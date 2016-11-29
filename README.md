#WeexDemo创建到使用 
简介：[Weex][1]的口号是“Write once, run everywhere“，即 iOS，Android,web端复用代码；一套代码，三端运行。
##目录
1. Weex环境配置
2. Weex入门使用
3. Weex语法使用
4. 集成到iOS工程
5. Weex进阶

##Weex环境配置
我们需要先安装[Node][2]。在Mac上也可以通过[Homebrew](http://brew.sh/index_zh-cn.html)直接进行安装：`brew install node`,接着我们需要安装Weex CLI：`npm install -g weex-toolkit`，并确保版本号大于0.1.0.

```
    $ weex --version
      info 0.3.4
```
环境配置完成
##Weex入门使用

###Hello World

创建一个名为`helloweex.we`的文件，并编写以下代码：

```
<template>
  <div>
    <text>Hello Weex</text>
  </div>
</template>
```
通过命令行在helloweex.we文件所在的目录下执行如下命令：

```
$ weex helloweex.we 
info Fri Jul 08 2016 14:30:31 GMT+0800 (CST)WebSocket  is listening on port 8082 
info Fri Jul 08 2016 14:30:31 GMT+0800 (CST)http  is listening on port 8081 
```

此时，浏览器会打开一个新的标签页展示helloweex.we的执行效果：
![image](https://github.com/fallenk/weex-ios/blob/master/image/596dec84fae845caa3564e78c6d306bd21343650.png)
可以进行热更新，修改

###Weex总体结构
上面的示例只是一个非常简单的雏形，而一个比较完整的Weex程序包括三个部分：`模板（Template）`、`样式（Style）`和`脚本（Script）`，相当于web的`html`，`css`,`javaScript`.
Weex页面由`<template>`,`<style>`,`<script>`三个部分构成。
- `<template>`: 必须的, 使用**类HTML**的语法描述页面结构，内容由多个标签组成，不同的标签代表不同的组件。
- `<style>`: 可选的, 使用**类CSS**的语法描述页面的具体展现形式。
- `<script>`: 可选的 , 使用**JavaScript**描述页面中的数据和页面的行为，Weex中的数据定义也在`<script>`中进行。

``` 
<template>
  <div>
    <text class="title" onclick="onClickTitle">Hello Weex</text>
  </div>
</template>

<style>
  .title { color: red; }
</style>

<script>
  module.exports = {
    methods: {
      onClickTitle: function (e) {
        console.log(e);
        alert('title clicked.');
      }
    }
  }
</script>
```
效果图
![image](https://github.com/fallenk/weex-ios/blob/master/image/cb4ba278ccfa21abc577af001d6cb8f70301b090.png)

##Weex结构语法
### `<template>`
`<template>` 中的标签组织类似如下代码:
根节点: 每个 `template` 标签中的最顶层标签，我们称为根节点。下面是目前我们支持的四种不同的根节点:

- `<container>`: 普通根节点
- `<scroller>`: 滚动器根节点,适用于需要全页滚动的场景
- `<list>`: 列表根节点,适用于其中包含重复的子元素的列表场景
- `<div>`: 普通标签，也可作为根节点
目前Weex支持以上四种根节点。

```
注：weex与vue.js相同，只有一个节点，<template>的子标签一个且唯一标签，不能有并列的标签
```
### `<style>`
第一种写法是，你能在标签上，直接通过内联style属性编写样式。第二种写法，通过标签中的class属性与style标签中定义的样式建立对应关系，让style标签中定义的样式作用于特定标签之上。

**注意!**
weex 遵循 [HTML]()属性 命名规范 , 所以属性命名时 请**不要使用陀峰格式**(CamelCase) , 采用以“-”分割的long-name形式。

### `<script>`
`<script>`中的代码遵循 JavaScript(ES5)语法。 描述页面中的数据和页面的行为。 下面是一个例子:

``` 
<template>
  <container>
    <text>The time is {{datetime}}</text>
    <text>{{title}}</text>
    <text>{{getTitle()}}</text>
  </container>
</template>

<script>
  module.exports = {
    data: {
      title: 'Alibaba',
      datetime: null
    },
    methods: {
      getTitle: function () {
        return 'Weex Team'
      }
    },
    created: function() {
      this.datetime = new Date().toLocaleString()
    }
  }
</script>
```
上面`<script>`标签中定义了被赋值给` module.exports` 的对象。其作用是让三个<text>标签显示当前时间,`'Alibaba'` 和 `'Weex Team'`、 `<script>`中的data存储可以用于在`<template>`标签中进行数据绑定的数据, 当这些数据变更时,被进行了数据绑定的标签也会自动更新。这些数据在`<script>`中的各个方法内可以通过`this.x`读写。
更多语法查看[这里](http://alibaba.github.io/weex/doc/syntax/main.html)

##集成到iOS工程
1. 参考[官方文档](http://alibaba.github.io/weex/doc/advanced/integrate-to-ios.html)，我们先从[GitHub](https://github.com/alibaba/weex)下载Weex源码。
2. 解压后将目录下的`ios/sdk`复制到现有的iOS工程目录下，并根据相对路径更新既有工程的podfile，然后执行pod update将Weex iOS SDK集成进既有的iOS项目中；
3. 在iOS Native代码中初始化Weex SDK，然后创建出要展示Weex程序的ViewController，具体见如下描述：

**cocoaPods 引入 Weex iOS SDK到工程**

1. 从[github](git clone https://github.com/alibaba/weex.git)上clone一份代码
2. 把WeexSDK 导入到你已有的项目，如果没有，可以参考新建项目
3. 拷贝 `ios/sdk`下面目录到你的项目目录，在添加依赖之前，确保项目目录有Podfile，如果没有，创建一个，用文本编辑器打开，添加如下依赖

```
    source 'https://github.com/CocoaPods/Specs.git'
    target 'YourTarget' do
               platform :ios, '7.0' 
               pod 'WeexSDK', :path=>'./sdk/'
    end

```
在命令行（terminal）中，切换到当前目录，运行 `pod install`,过一会，项目的 `.workspace`结尾的文件就被创建出来，到这步，依赖已经添加完了

### 初始化 Weex 环境

在AppDelegate.m 文件中做初始化操作，一般会在 didFinishLaunchingWithOptions方法中如下添加

```
//business configuration
[WXAppConfiguration setAppGroup:@"AliApp"];
[WXAppConfiguration setAppName:@"WeexDemo"];
[WXAppConfiguration setAppVersion:@"1.0.0"];

//init sdk enviroment   
[WXSDKEngine initSDKEnviroment];

//register custom module and component，optional
[WXSDKEngine registerComponent:@"MyView" withClass:[MyViewComponent class]];
[WXSDKEngine registerModule:@"event" withClass:[WXEventModule class]];

//register the implementation of protocol, optional
[WXSDKEngine registerHandler:[WXNavigationDefaultImpl new] withProtocol:@protocol(WXNavigationProtocol)];

//set the log level    
[WXLog setLogLevel: WXLogLevelAll];

```

### 渲染 weex Instance

Weex 支持整体页面渲染和部分渲染两种模式，你需要做的事情是用**指定的URL渲染weex的view**，然后添加到它的父容器上，父容器一般都是viewController

```

#import <WeexSDK/WXSDKInstance.h>
- (void)viewDidLoad 
{
    [super viewDidLoad];

    _instance = [[WXSDKInstance alloc] init];
    _instance.viewController = self;
    _instance.frame = self.view.frame; 

    __weak typeof(self) weakSelf = self;
    _instance.onCreate = ^(UIView *view) {
        [weakSelf.weexView removeFromSuperview];
        [weakSelf.view addSubview:weakSelf.weexView];
    };

    _instance.onFailed = ^(NSError *error) {
        //process failure
    };

    _instance.renderFinish = ^ (UIView *view) {
        //process renderFinish
    };
    [_instance renderWithURL:self.url options:@{@"bundleUrl":[self.url absoluteString]} data:nil];
}

```
WXSDKInstance 是很重要的一个类，提供了基础的方法和一些回调，如renderWithURL,onCreate,onFailed等，可以参见 `WXSDKInstance.h`的 声明
3.  销毁Weex Instance
在 viewController的 dealloc 阶段 销毁掉`weexInstance`， 释放内存，避免造成内存泄露

```
- (void)dealloc
{
    [_instance destroyInstance];
}
```

##Weex进阶

### 实现图片下载协议 `WXImgLoaderProtocol`
由于Weex SDK没有提供图片下载能力，需要我们来实现
 1. 定义图片下载Handler

```
#import <WeexSDK/WeexSDK.h>

@interface WeexImageDownloader : NSObject <WXImgLoaderProtocol>

@end
```
2. 实现协议接口
这个类必须遵循WXImgLoaderProtocol协议，并实现该协议定义的接口：

```
#import "WeexImageDownloader.h"
#import <SDWebImage/SDWebImageManager.h>

@implementation WeexImageDownloader

- (id<WXImageOperationProtocol>)downloadImageWithURL:(NSString *)url
                                          imageFrame:(CGRect)imageFrame
                                            userInfo:(NSDictionary *)options
                                           completed:(void(^)(UIImage *image,  NSError *error, BOOL finished))completedBlock {
    return (id<WXImageOperationProtocol>)[[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:url] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        if (completedBlock) {
            completedBlock(image, error, finished);
        }
    }];
}

@end
```
3. 注册Handler
在Appdelegate中：

```
[WXSDKEngine registerHandler:[WeexImageDownloader new] withProtocol:@protocol(WXImgLoaderProtocol)];
```
###自定义UI组件
如果Weex的内置标签不足以满足要求时，我们可以自定义Native组件，然后暴露给.we文件使用。
比如我们可以定义一个`WeexButton`，继承自`WXComponent`，然后将其注册进Weex SDK：

```
[WXSDKEngine registerComponent:@"weex-button" withClass:[WeexButton class]];
```
这样一来，我们就可以在.we文件中使用这个标签了：

```
<weex-button class="button" title="hello"></weex-button>
```
在`WeexButton.m`中，

```
- (instancetype)initWithRef:(NSString *)ref
                       type:(NSString*)type
                     styles:(nullable NSDictionary *)styles
                 attributes:(nullable NSDictionary *)attributes
                     events:(nullable NSArray *)events
               weexInstance:(WXSDKInstance *)weexInstance {
    self = [super initWithRef:ref type:type styles:styles attributes:attributes events:events weexInstance:weexInstance];
    if (self) {
        _title = [WXConvert NSString:attributes[@"title"]];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.innerButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.innerButton.frame = self.view.bounds;
    [self.view addSubview:self.innerButton];
    [self.innerButton setTitle:self.title forState:UIControlStateNormal];
    [self.innerButton addTarget:self action:@selector(onButtonClick:) forControlEvents:UIControlEventTouchUpInside];
}
```
### 自定义模块
**有些时候我们希望JS层面能够调用Native的一些功能，比如通过JS代码让Native打开一个特定的ViewController。这时候，我们可以自定义一个模块向JS层面暴露API：**

```
@synthesize weexInstance;

WX_EXPORT_METHOD(@selector(call:withParam:callback:))
- (void)call:(NSString *)api withParam:(NSDictionary *)param callback:(WXModuleCallback)callback {
```
注意点如下：

1. 需要遵循`WXModuleProtocol`协议；
2. 需要合成`（synthesize）weexInstance`属性；
3. 使用`WX_EXPORT_METHOD`来暴露API；
4. 使用`WXModuleCallback`进行回调；

完成以上编码后，向Weex SDK注册：`[WXSDKEngine registerModule:`，就可以在.we文件中使用了：

```
<script>
  module.exports = {
    methods: {
      onClickTitle: function (e) {
        var mymodule = require('@weex-module/mymodule');
        mymodule.call('api', {}, function(ret) {
        });
      }
    }
  }
</script>
```

##注释
1. Weex只是一套渲染页面的方案，不涉及移动端还是iOS具体的逻辑写法，图片加载，具体文件下载功能需要自己实现
2. 无论是移动端还是web端，最终加载的是js文件(远程时：启动weex服务，生成js文件，移动端通过路由加载; 本地加载：编译生成js文件，工程引用加载)
3. ios上的集成，远程加载（1.通过url加载 2.下载js包加载）与本地加载
  1. 远程加载时，
      1.  通过url加载：在服务端写好同一文件将下放置好多个`.we`文件，终端切换到该目录，执行`weex -s .`,则会运行起Weex server，在移动iOS写法只用获取该路由，指定跳转文件即可 
      2.  下载js包加载，服务端的终端切换到Weex文件夹下，执行`weex ’Weex文件夹该路径‘ -o ‘自己创建的文件夹路径’`，获取所有js的路径，打包。移动端获取该js包下载链接，到本地，解压加载通过的路由该文件。
  2. 移动端本地加载，编译好js文件，引用工程，加载文件

4. 目前建了简单的[Demo](https://github.com/fallenk/weex-ios.git)


## Demo使用流程
1. clone下项目，在终端切换到项目目录下
2. 打开Podfile，执行`pod install`，成功则执行
3. 在终端执行`weex -s .`,启动服务，获取url链接
4. xcode打开`.xcworkspace`文件

---------
[1]:http://alibaba.github.io/weex/doc/tutorial.html
[2]:https://nodejs.org/en/download/


