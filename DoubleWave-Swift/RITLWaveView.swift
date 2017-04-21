//
//  RITLDoubleWaveView.swift
//  DoubleWave-Swift
//
//  Created by YueWen on 2017/4/20.
//  Copyright © 2017年 YueWen. All rights reserved.
//

import UIKit

/// 双波浪视图
class RITLWaveView: UIView {
    
    // MARK: pulic
    
    /// 波形处理,振幅-周期-index-位移,默认正弦函数
    var waveHandler :((_ waveA :CGFloat,_ waveW :CGFloat,_ index:CGFloat, _ offSet :CGFloat) -> (CGFloat)) = {
     
        return CGFloat($0 * sin($1 * $2 + $3))
    }
    
    /// 波浪颜色
    var waveColor = UIColor(displayP3Red: 86.0 / 255.0, green: 202.0 / 255.0, blue: 139.0 / 255.0, alpha: 1)
    
    /*
     y =Asin（ωx+φ）+C
     A表示振幅，也就是使用这个变量来调整波浪的高度
     ω表示周期，也就是使用这个变量来调整在屏幕内显示的波浪的数量
     φ表示波浪横向的偏移，也就是使用这个变量来调整波浪的流动
     C表示波浪纵向的位置，也就是使用这个变量来调整波浪在屏幕中竖直的位置。
     */
    
    /// 振幅
    var waveA = 12.0
    /// 周期
    var waveW = 0.5 / 30.0
    /// 位移
    var offsetX = 0.0
    /// 水纹速度
    var wavesSpeed = 0.02
    
    /// 水纹宽度
    var wavesWidth : CGFloat {
        
        get{
            return self.frame.width
        }
    }
    
    /// 当前波浪高度Y
    var currentK : CGFloat {
        
        get{
            return self.frame.height / 2.0
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        layer.masksToBounds = true
        
        p_setUpWave()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    // MARK: private
    
    /// 计时器
    fileprivate var waveDisplayLink :CADisplayLink?
    
    /// 动画layer
    fileprivate var waveLayer :CAShapeLayer?
    
    /// 创建波浪
    fileprivate func p_setUpWave(){
        
        //添加shapeLayer
        if waveLayer == nil {
            
            //初始化
            waveLayer = CAShapeLayer()
            waveLayer?.fillColor = waveColor.cgColor
            layer.addSublayer(waveLayer!)
        }
        
        //启动定时器
        waveDisplayLink = CADisplayLink(target: self, selector: #selector(RITLWaveView.p_getCurrentWave(_:)))
        
        //添加至runloop
        waveDisplayLink?.add(to: .main, forMode: .commonModes)
    }
    
    
    /// 获得当前wave
    @objc fileprivate func p_getCurrentWave(_ displayLink:CADisplayLink){
        
        //实时的位移
        offsetX += wavesSpeed
        
        p_setCurrentFirstWaveLayerPath()
    }
    
    
    /// 获得当前第一个的path
    fileprivate func p_setCurrentFirstWaveLayerPath(){
       
        //创建路径
        let path = CGMutablePath()
        
        //获得当前振幅
        var y = currentK
        
        //将点移动到 x = 0,y = currentK的位置
        path.move(to: CGPoint(x: 0, y: y))
        
        for i in 0 ..< Int(wavesWidth) {
            
            y = self.waveHandler(CGFloat(waveA),CGFloat(waveW),CGFloat(i),CGFloat(offsetX)) + CGFloat(currentK)

            //连成线
            path.addLine(to: CGPoint(x: CGFloat(i), y: y))
            
        }
        
        //添加线
        path.addLine(to: CGPoint(x: wavesWidth, y: 0))
        path.addLine(to: CGPoint(x: 0, y: 0))
        
        path.closeSubpath()
        waveLayer?.path = path
    }
    
    deinit {
        
        waveDisplayLink?.invalidate()
    }
}
