//
//  StringExtension.swift
//  Swift_Wiki_Extension
//
//  Created by myoung on 2018. 6. 18..
//  Copyright © 2018년 myoung. All rights reserved.
//

import Foundation
import UIKit

//MARK: ## String Extension ##
extension String {
    
    /**
     로컬라이징한 텍스트를 반환하는 연산 프로퍼티
     - 반환값 타입은 String
     - ex) "mainPageTitle".localized
     */
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    /**
     로컬라이징한 텍스트를 반환하고, 코멘트를 적을 수 있는 메소드
     - 반환값 타입은 String
     - ex) "mainPageTitle".localizedWithComment(comment: "Title in main page")
     */
    func localizedWithComment(comment: String) -> String {
        return NSLocalizedString(self, comment:comment)
    }
    
    /**
     텍스트의 길이와 높이를 폰트에 따라 리턴해주는 메소드
     - 반환값 타입은 CGSize
     - ex) "안녕하세요".sizeFromFont(UIFont.systemFont(ofSize: 15.0)) -> (64.875, 17.900390625)
     */
    func textSizeFromFont(_ font: UIFont) -> CGSize {
        return self.size(withAttributes: [.font: font])
    }
    
    /**
     문자열을 반대로 출력해주는 연산 프로퍼티
     - 반환값 타입은 String
     - ex) "Hello".reversed -> olleH
     */
    var reversed: String {
        return self.reversed().map { String($0) }.joined(separator: "")
    }
    
    /**
     문자열을 받아서 초성으로 구성된 문자열로 바꿔는 연산 프로퍼티
     - 반환값 타입은 String
     - ex) "안녕하세요".initialKorea -> ㅇㄴㅎㅅㅇ
     */
    var initialKorea: String {
        var initialString = ""
        let koreaInitials: [String] = ["ㄱ","ㄲ","ㄴ","ㄷ","ㄸ","ㄹ","ㅁ","ㅂ","ㅃ","ㅅ","ㅆ","ㅇ","ㅈ","ㅉ","ㅊ","ㅋ","ㅌ","ㅍ","ㅎ"]
        for element in self {
            for ch in element.unicodeScalars {
                if ch.value >= 44032 && ch.value <= 55203 { // korean
                    let unicode = ch.value-44032
                    let resultInitial = unicode / 21 / 28
                    initialString += koreaInitials[Int(resultInitial)]
                } else {
                    initialString += String(element)
                }
            }
        }
        return initialString
    }
    
    /**
     11자리 휴대폰번호를 만들어주는 연산 프로퍼티
     - 반환값 타입은 String
     - ex) "01011112222".makePhoneNumber -> 010-1111-2222
     */
    var makePhoneNumber: String {
        return self.replacingOccurrences(of: "(\\d{3})(\\d+)(\\d{4})", with: "$1-$2-$3", options: .regularExpression, range: nil)
    }
    
    /**
     문자열에서 NSRange값에 따라서 분리한 문자열을 반환하는 멤버 함수
     - 반환값 타입은 String
     - ex) print("안녕하세요".selectTextRange(NSMakeRange(2, 2))) -> 하세요
     */
    func selectTextFromRange(_ range: NSRange) -> String {
        var result = ""
        for (i, element) in self.enumerated() {
            if i >= range.location && i <= (range.length + range.location) {
                result.append(element)
            }
        }
        return result
    }
    
    /**
     인자로 포멧을 받아 문자열을 Date형식으로 바꿔주는 멤버 함수
     - 반환값 타입은 Date
     - ex) "20180710".stringToDate("yyyyMMdd") -> 2018-07-09 15:00:00 +0000
     */
    func stringToDate(_ format: String) -> Date {
        
        let formatter = DateFormatter()
        formatter.dateFormat = format
        guard let date = formatter.date(from: self) else { return Date() }
        return date
    }
    
    /**
     개수에 따라 마지막 문자를 원하는 문자로 치환하는 멤버 함수
     - 반환값의 타입은 String
     - ex) "Swift is Awesome!!".reduceFromCount(15, want: "...") -> Swift is Awesome...
     */
    func reduceFromCount(_ reduceCount: Int, want substitution: String) -> String {
        var value = "", count = 0
        for element in self {
            let temp = String(element)
            
            if temp.utf8.count == 1 { count += 1 }
            else { count += 2 }
            
            value.append(element)
            if count > reduceCount {
                value = String(value.dropLast())
                value.append(substitution)
                break
            }
        }
        return value
    }
    
    /**
     정규식을 통해 유효한 이메일인지 판단해주는 멤버 변수
     - 반환값의 타입은 Bool
     - ex) "myoungsc.dev@gamil.com".isCheckValidEmail -> true
     */
    var isCheckValidEmail: Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{1,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        
        return emailPredicate.evaluate(with: self)
    }
    
    /**
     문자열 안에 있는 숫자만 원하는 폰트로 처리 해주는 멤버 함수
     - 반환값의 타입은 NSMutableAttributedString
     - ex) "a1b2c3d4".differentNumberFont(UIFont.boldSystemFont(ofSize: 13),
     otherFont: UIFont.systemFont(ofSize: 13))
     */
    func differentNumberFont(_ numberFont: UIFont, otherFont: UIFont) -> NSMutableAttributedString {
        let attr = NSMutableAttributedString(string: self)
        let digitSet = CharacterSet.decimalDigits
        for (index, ch) in self.unicodeScalars.enumerated() {
            let font = digitSet.contains(ch) ? numberFont : otherFont
            attr.addAttributes([.font: font], range: NSMakeRange(index, 1))
        }
        return attr
    }
    
    /**
     글자 수와 폰트에 따라 width, height 넘겨주기
     - 반환값의 타임은 CGSize
     - ex) "Hello".sizeFromFont(UIFont.systemFont(ofSize: 15)) -> (34.951171875, 17.900390625)
     */
    func sizeFromFont(_ font: UIFont) -> CGSize {
        return self.size(withAttributes: [.font: font])
    }
}
