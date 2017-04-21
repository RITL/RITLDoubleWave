//
//  ViewController.swift
//  DoubleWave-Swift
//
//  Created by YueWen on 2017/4/20.
//  Copyright © 2017年 YueWen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    var firstWave :RITLWaveView?
    var secondWave :RITLWaveView?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        firstWave = RITLWaveView(frame: CGRect(x: 0, y: -20, width: self.view.frame.width, height: 220))
        
        firstWave?.alpha = 0.6
        
        view.addSubview(firstWave!)
        
        
        //添加余弦函数
        secondWave = RITLWaveView(frame: CGRect(x: 0, y: -20, width: self.view.frame.width, height: 220))

        secondWave?.alpha = 0.6

        //设置属性
        secondWave?.wavesSpeed = 0.04
        secondWave?.waveA = 13
        secondWave?.waveW = 0.5 / 30.0

        //设置路径
        secondWave?.waveHandler = {
            
            $0 * cos($1 * $2 + $3)
        }

        view.addSubview(secondWave!)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        
        return .lightContent
    }


}

