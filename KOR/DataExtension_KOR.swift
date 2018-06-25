//
//  DataExtension_KOR.swift
//  dfae
//
//  Created by maccli1 on 2018. 6. 25..
//  Copyright © 2018년 myoung. All rights reserved.
//

import Foundation
import UIKit

extension Data {
    
    func dataSizeOtherFormat(_ unit: ByteCountFormatter.Units) -> String {
        /*
         - Data 타입의 사이즈를 저장 용량 단위로 리턴해주는 멤버 함수
         - 반환값의 타입은 String
         - ex) Data.dataSizeOtherFormat([.useKB]) -> "1 KB"
        */
        
        let bcf = ByteCountFormatter()
        bcf.allowedUnits = unit // option: .useBytes, .useKB, .useMB, .useGB ...
        bcf.countStyle = .file
        return bcf.string(fromByteCount: Int64(self.count))
    }
    
}
