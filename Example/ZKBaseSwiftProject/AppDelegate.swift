//
//  AppDelegate.swift
//  ZKBaseSwiftProject
//
//  Created by 小修 on 09/14/2023.
//  Copyright (c) 2023 小修. All rights reserved.
//

import UIKit
import ZKBaseSwiftProject

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//        let windowScene = scene;
        
        if UserDefaults.agreePrivacyPolicy {
            self.initInfo()
        } else {
            let mainVc = ZKPrivacyPolicyVC.init()
            //赋值文本显示
            let info = "感谢您下载并使用阅读大冒险！我们非常重视您的个人信息和隐私保护。为确保您正常使用我们的服务，我们需要收集您的设备信息、日志信息； 为了向您提供课程服务，我们会获取您的同意后，再访问您设备的麦克风权限。请您在使用我们服务前，仔细阅读并充分理解《用户协议》、《隐私政策》和《儿童个人信息保护规则及监护人须知》，尤其是相关协议中以粗体标识的条款。如您同意，请点击“同意”后接受我们的服务。"
            mainVc.info = info
            mainVc.privacyUrl = "http://read.risekid.cn/policy/privacy.html"
            mainVc.uesrProtolUrl = "http://read.risekid.cn/policy/userProtocal.html"
            mainVc.childInfoUrl  = "http://read.risekid.cn/policy/children.html"
            mainVc.isAgree = { (agree)in
                if agree {
                    self.initInfo()
                }
            }
            let nav = UINavigationController(rootViewController: mainVc)
            nav.setNavigationBarHidden(true, animated: false)
            self.window?.backgroundColor = .white
            self.window?.rootViewController = nav
            self.window?.makeKeyAndVisible()
        }
        return true
    }
    
    func initInfo(){
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.white//设置window颜色
        let tabbar = KJTabBarViewController()//初始化
        let navtab = UINavigationController(rootViewController: tabbar)
        self.window?.rootViewController = navtab
        self.window?.makeKeyAndVisible()
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

