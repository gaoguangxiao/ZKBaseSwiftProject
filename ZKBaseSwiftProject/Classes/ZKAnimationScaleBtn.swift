//
//  ZKAnimationScaleBtn.swift
//  RSBridgeLogin
//
//  Created by 高广校 on 2024/3/25.
//  com.readadventure.app.product.continue_buy.vip428_1

import Foundation

//实现一个点击时的放大缩小动画
public class ZKAnimationScaleBtn: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        addTarget(self, action: #selector(zkTouchDragInside), for: .touchDragInside)
        addTarget(self, action: #selector(zkTouchDown), for: .touchDown)
        addTarget(self, action: #selector(zkTouchDragExit), for: .touchDragExit)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func resetLoginBtnStatus() {
        UIView.animate(withDuration: 0.15) {
            self.transform = .identity
        }
    }
    
    /// 控件按压
    @objc func zkTouchDown(sender: UIButton) {
//        print("控件按压")
        UIView.animate(withDuration: 0.15) {
            sender.transform = CGAffineTransformMakeScale(0.9, 0.9)
        }
    }
    
    /// 控件内拖动时
    @objc func zkTouchDragInside(_ sender: UIButton) {

    }
    
    /// 从控件内拖动到外部时
    @objc func zkTouchDragExit(sender: UIButton) {
//        print("控件内拖动到外部时")
        UIView.animate(withDuration: 0.15) {
            sender.transform = .identity
        }
    }
}
