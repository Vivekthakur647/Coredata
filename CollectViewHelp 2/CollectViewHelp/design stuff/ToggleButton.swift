
//  ToggleButton.swift
//  PuttMetricsAPP
//
//  Created by User on 12/2/17.
//  Copyright © 2017 DustinPerry. All rights reserved.
//

import UIKit


class ToggleButton: UIButton {
    
    
    var isOn = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initButton()
    }
    
    func initButton() {
        
        layer.borderWidth = 2.0
        layer.borderColor = UIColor.green.cgColor
        layer.cornerRadius = frame.size.height/2
        
        setTitleColor(UIColor.green, for: .normal)
        addTarget(self, action: #selector(ToggleButton.buttonPressed), for: .touchUpInside)
    }
    
    @objc func buttonPressed() {
        activateButton(bool: !isOn)
    }
    func activateButton(bool: Bool){
        isOn = bool
        
        let color = bool ? UIColor.green : .clear
        let title = bool ? "Following" : "Follow"
        let titleColor = bool ? .white : UIColor.green
        
        setTitle(title, for: .normal)
        setTitleColor(titleColor, for: .normal)
        backgroundColor = color
        
    }
    
}
class RoundedEdgesTallButton: UIButton {
    
    
    var isOn = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initButton()
    }
    
    func initButton() {
        layer.cornerRadius = frame.size.width/2
    }
    
    
}

class minusButton: UIButton {
    
    
    var isOn = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initButton()
    }
    
    func initButton() {
        
        layer.cornerRadius = frame.size.height/2
        
        setTitleColor(UIColor.white, for: .normal)
        
    }
    
    
}

class additionButton: UIButton {
    
    
    var isOn = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initButton()
    }
    
    func initButton() {
        
        layer.cornerRadius = frame.size.height/2
        
        setTitleColor(UIColor.white, for: .normal)
        
    }
    
    
}

