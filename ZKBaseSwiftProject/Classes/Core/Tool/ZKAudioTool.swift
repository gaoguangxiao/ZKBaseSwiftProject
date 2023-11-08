//
//  ZKAudioTool.swift
//  RSReading
//
//  Created by 高广校 on 2023/9/18.
//

import UIKit
import AVFoundation

class ZKAudioTool: NSObject {

    static func audioDurationFromUrl(url:String) -> TimeInterval {
        let dic = [AVURLAssetPreferPreciseDurationAndTimingKey:true]
        var audioAsset : AVURLAsset?
        if url.contains("http://") {
            guard let uurl = URL(string: url) else { return 0}
            audioAsset = AVURLAsset(url:uurl)
        } else {
            audioAsset = AVURLAsset(url:URL(fileURLWithPath: url))
        }
        if let duration = audioAsset?.duration {
            return CMTimeGetSeconds(duration)
        }
        return 0
    }
}
