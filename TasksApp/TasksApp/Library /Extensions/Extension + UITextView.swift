//
//  Extension + UITextView.swift
//  TasksApp
//
//  Created by user on 13.05.2024.
//

import UIKit

extension UITextView {

    func resolveHashtag() {
        let hashtagPrefix = "#"
        let nsText: NSString = self.text as NSString
        let words:[String] = nsText.components(separatedBy: " ")
        
        let defaultAttributes = [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16),
            NSAttributedString.Key.foregroundColor : UIColor.black
        ]
        
        let attrString = NSMutableAttributedString(string: nsText as String, attributes: defaultAttributes as [NSAttributedString.Key : Any])
        
        for word in words {
            if word.hasPrefix(hashtagPrefix), word.count >= 3 {
                let matchRange: NSRange = nsText.range(of: word as String)
                var stringifiedWord: String = word as String
                stringifiedWord = String(stringifiedWord.dropFirst())
                
                attrString.addAttribute(NSAttributedString.Key.link, value: "hash:\(stringifiedWord)", range: matchRange)
                attrString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.systemBlue , range: matchRange)
                self.attributedText = attrString
            } else if !word.hasPrefix(hashtagPrefix) {
                let matchRange: NSRange = nsText.range(of: word as String)
                var stringifiedWord: String = word as String
                stringifiedWord = String(stringifiedWord.dropFirst())
                
                attrString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black , range: matchRange)
                self.attributedText = attrString
            }
        }
    }
}
