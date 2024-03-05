//
//  SwiftUISMSQrCodeView.swift
//  RSReading
//
//  Created by 高广校 on 2024/3/1.
//

import SwiftUI
import GGXSwiftExtension
import ZKBaseSwiftProject
import Combine

@available(iOS 13.0, *)
class SwiftUISMSQrCodeViewVc: ZKBaseHostingVc<SwiftUISMSQrCodeView> {
        
    var payCancellable: Cancellable?

    init(qrName: String) {
        
        let image = UIImage.createQRCode(model: QRCreateModel(text: "123"))
        let view = SwiftUISMSQrCodeView(qrImage: image,countdown: 5)
        super.init(rootView: view)
//        self.payCancellable = view.payResult.$payResult.sink(receiveValue: { [weak self] _  in
//            print("pay end result")
//            self?.pop()
//        })
        //
        self.backBtn.zkNormalImgName("navBack")
    }

    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

@available(iOS 13.0, *)
class PayEventHandler: ObservableObject {
    
    @Published var payResult: Bool = false
    
}

@available(iOS 13.0, *)
struct SwiftUISMSQrCodeView: View {
    
    var qrImage: UIImage?  // qrcodePay
    
    @State var countdown: Int = 1800
    
//    @Binding var isShowPay: Bool
    
    @State private var timerCancellable: AnyCancellable?
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    let payResult = PayEventHandler()
    
    var body: some View {
        
        VStack {
            
            Text("剩余时间：\(countdown.bshmmDown)s")
                .font(.largeTitle)
            
//            Button(action: startCountdown) {
//                            Text("开始倒计时")
//                                .padding()
//                                .background(Color.blue)
//                                .foregroundColor(.white)
//                                .cornerRadius(5)
//                        }

            Image(uiImage: qrImage ?? UIImage())
                .resizable()
                .frame(width: 200,height: 200)
            
        }
        .onReceive(timer) { _ in
            if self.countdown > 0 {
                self.countdown -= 1
            } else {
                stopCountdown()
            }
        }
    }
    
    func startCountdown() {
        print("Start Countdown")
        
        // 这里可以添加其他需要执行的操作
        
        //每隔5s获取支付结果
        
        print(self.payResult)
        //
    }
    
    func stopCountdown() {
        print("Stop Countdown")
        
        // 这里可以添加其他需要执行的操作
        
        //关闭界面
        timer.upstream.connect().cancel() // 取消计时器发布者

        //        isShowPay = false
        self.payResult.payResult = true
    }
    
    func getPayResult() {
        
        return
    }
}

//@available(iOS 13.0, *)
//#Preview {
//    
//    SwiftUISMSQrCodeView(qrImage: UIImage.createQRCode(qrCode: "weixin://wxpay/bizpayurl?pr=9UHzAMuzz", szie: CGSizeMake(100, 100)))
//}
