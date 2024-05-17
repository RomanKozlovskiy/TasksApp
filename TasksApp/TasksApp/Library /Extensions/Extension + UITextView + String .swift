//
//  Extension + UITextView.swift
//  TasksApp
//
//  Created by user on 13.05.2024.
//

import UIKit
import RichTextKit

extension String {
    fileprivate func NSRangeFromRange(range: Range<String.Index>) -> NSRange {
        let utf16view = self.utf16
        
        guard let from = String.UTF16View.Index(range.lowerBound, within: utf16view),
              let to = String.UTF16View.Index(range.upperBound, within: utf16view)
        else {
            return NSRange(location: 0, length: 0)
        }
        
        return NSMakeRange(utf16view.distance(from: utf16view.startIndex, to: from),
                           utf16view.distance(from: from, to: to))
    }
}

extension RichTextView {
    
    func resolveHashtag() {
        
        setRichTextAttribute(.font, to: UIFont.systemFont(ofSize: 16), at: rangeBeforeInputCursor)
        
        let scheme = ["hashtag": "#"]
        
        let words = self.text.components(separatedBy: NSCharacterSet.whitespacesAndNewlines)
        
        guard let lastWord = words.last else { return }
        
        let startIndex = text.index(text.endIndex, offsetBy: -lastWord.count)
        let endIndex = text.index(text.endIndex, offsetBy: 0)
        let range = startIndex..<endIndex
        
        if let hashtag = scheme["hashtag"],
           lastWord.hasPrefix(hashtag),
           lastWord.count >= 3 {
           
            setRichTextColor(.foreground, to: UIColor.systemBlue, at: text.NSRangeFromRange(range: range))
        }
        else {
            setRichTextColor(.foreground, to: UIColor.black, at: text.NSRangeFromRange(range: range))
        }
        
        for word in words {
            guard let hashtag = scheme["hashtag"] else { return }
            
            if word.hasPrefix(hashtag), word.count >= 3 {
                let nsText: NSString = self.text as NSString
                let matchRange: NSRange = nsText.range(of: word as String)
                setRichTextAttribute(.foregroundColor, to: UIColor.systemBlue, at: matchRange)
            }
        }
    }
    
    func isValidLink(_ link: String) -> Bool {
        let schemes = ["https://", "www"]
        
        for scheme in schemes {
            if link.hasPrefix(scheme) {
                return true
            }
        }
        return false
    }
    
    func addHyperlink(_ link: String, at selectedRange: NSRange) {
        if link.hasPrefix("https://") {
            let range = NSRange(location: selectedRange.location, length: selectedRange.length - 1)
            setRichTextAttribute(.link, to: link, at: range)
            setRichTextColor(.foreground, to: UIColor.systemBlue, at: selectedRange)
        } else if link.hasPrefix("www") {
            let range = NSRange(location: selectedRange.location, length: selectedRange.length - 1)
            setRichTextAttribute(.link, to: "https://" + link, at: range)
            setRichTextColor(.foreground, to: UIColor.systemBlue, at: selectedRange)
        }
    }
    
    func removeHyperlink(at selectedRange: NSRange) {
        var attributes = richTextAttributes(at: selectedRange)
        let newAttributes = NSAttributedString(string: richText(at: selectedRange).string)
        replaceText(in: selectedRange, with: NSAttributedString(string: richText(at: selectedRange).string))
        setRichTextAttribute(.font, to: UIFont.systemFont(ofSize: 16), at: selectedRange)
    }
    
    func addRowLinkInText(link: String) {
        let nsText: NSString = self.text as NSString
        let matchRange: NSRange = nsText.range(of: link as String)
        let linkRange = NSRange(location: matchRange.location, length: matchRange.length - 1)
        setRichTextAttribute(.link, to: link, at: linkRange)
        setRichTextAttribute(.foregroundColor, to: UIColor.systemBlue, at: matchRange)
    }
}
