//
//  TaskDownTimer.swift
//  ZKBaseSwiftProject_Example
//
//  Created by 高广校 on 2024/8/27.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import SwiftUI
import ZKBaseSwiftProject

class TaskDownTimerModel: ObservableObject {
    var recordTimeTool: GXTaskDownTimer?
    
    func launchRecordtime() {
        recordTimeTool = GXTaskDownTimer()
        recordTimeTool?.initIdleTimer(retaminCount: 10) { [weak self] retain in
            guard let self else { return }
            if retain <= 0 {
                print("停止录音")
            } else {
                print("录音倒计时：\(retain)")
            }
        }
    }
    
    func stopRecordTimer() {
//        self.recordTimeTool?.removeInvalidate()
        self.recordTimeTool = nil
    }
}

struct TaskDownTimer: View {
    
    @ObservedObject var viewModel = TaskDownTimerModel()
    
    var body: some View {
        VStack(content: {
            
            Button(action: {
                viewModel.launchRecordtime()
            }, label: {
                Text("开始")
            })
            
            Button(action: {
                viewModel.stopRecordTimer()
            }, label: {
                Text("停止")
            })
        })
    }
    
    
}

#Preview {
    TaskDownTimer()
}
