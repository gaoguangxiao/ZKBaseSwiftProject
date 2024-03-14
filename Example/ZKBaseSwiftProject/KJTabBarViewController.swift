//
//  KJTabBarViewController.swift
//  gxx-swiftkj
//
//  Created by 高广校 on 2023/9/11.
//

import UIKit
import ZKBaseSwiftProject

@available(iOS 13.0, *)
class KJTabBarViewController : ZKTabBarViewController {
    
    override func viewDidLoad() {
        
        let login = KJLoginViewController()
        let vc = KJHomeViewController();
        let user = KJUserViewController()
        self.viewControllers = [vc,login,user]
        
        ConfigTabBarImage()
    }
    
    
    //    //配置tabbar图片
    func ConfigTabBarImage()  {

//        let itemNameSelectArray:[String] = ["tabbar_msg_1","tabbar_mine_1"]
//        let itemNameArray:[String] = ["tabbar_msg","tabbar_mine"]
        let itemTitle : [String] = ["功能","首页","我的"]
        let titleSelectColor : UIColor = .hex(0x1B84F5)
        let titleColor : UIColor = .hex(0x818181)
        //背景颜色是统一的
        self.tabBar.barTintColor = .hex(0xFFFFFF)
        self.tabBar.isTranslucent = false
        if #available(iOS 13.0, *) {
            let barAppearance = UITabBarAppearance()
            barAppearance.backgroundColor = .white
            barAppearance.shadowColor = .clear
            self.tabBar.standardAppearance = barAppearance
            if #available(iOS 15.0, *) {
                self.tabBar.scrollEdgeAppearance = barAppearance
            } else {
                // Fallback on earlier versions
            }
        } else {
            // Fallback on earlier versions
        }
        
        
        var count : Int = 0
        let items = self.tabBar.items
        for item in items! {
//            var image:UIImage = UIImage.init(named: itemNameArray[count])!
//            var selectImage : UIImage = UIImage.init(named: itemNameSelectArray[count])!
            
//            image =  image.withRenderingMode(UIImage.RenderingMode.alwaysOriginal);
//            selectImage = selectImage.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
            //                            item.badgeValue = "10"
//            item.selectedImage = selectImage
//            item.image         = image
            item.title         = itemTitle[count]
            item.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:titleColor,NSAttributedString.Key.font:UIFont.systemFont(ofSize: 10.0)], for: .normal)
            item.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:titleSelectColor,NSAttributedString.Key.font:UIFont.systemFont(ofSize: 10.0)], for:.selected)
            count = count + 1
        }
        
    }
}
