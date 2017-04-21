# RITLDoubleWave

   iOS 双波浪动画-Swift版本，原作者博文以及地址请移步README

   本工程仅是为了学习而用Swift编写，源博文以及github地址如下

简书博文:[iOS 双波浪动画-类似淘宝个人信息状态栏,京东金融等](http://www.jianshu.com/p/908241bf769f)<br>
原作者github:[DoubleWavesAnimation](https://github.com/FTC-Chen/DoubleWavesAnimation)

本demo预览图<br><br>
![波形](https://github.com/RITL/RITLDoubleWave/blob/master/DoubleWave-Swift/wave-Swift.gif)

```
//默认属性

/// 波形处理,振幅-周期-index-位移,默认正弦函数
var waveHandler :((_ waveA :CGFloat,_ waveW :CGFloat,_ index:CGFloat, _ offSet :CGFloat) -> (CGFloat)) = {
 
    return $0 * sin($1 * $2 + $3)
}


/// 振幅
var waveA = 12.0
/// 周期
var waveW = 0.5 / 30.0
/// 位移
var offsetX = 0.0
/// 水纹速度
var wavesSpeed = 0.02
```

```
//添加余弦函数
secondWave = RITLWaveView(frame: CGRect(x: 0, y: -20, width: self.view.frame.width, height: 220))

secondWave?.alpha = 0.6

//设置属性
secondWave?.wavesSpeed = 0.04
secondWave?.waveA = 13
secondWave?.waveW = 0.5 / 30.0

//设置余弦波形
secondWave?.waveHandler = {
    
    $0 * cos($1 * $2 + $3)
}

view.addSubview(secondWave!)
```
