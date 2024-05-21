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

    func convertHashtags() {
        
        guard let richTextAttrString = mutableAttributedString else { return }
        
        richTextAttrString.beginEditing()
    
        do {
            let hashtagRegex = try NSRegularExpression(pattern: "(?:\\s|^)(#(?:[a-zA-Z-а-яА-Я0-9]{3,}.*?|\\d+[a-zA-Z-а-яА-Я0-9]+.*?))\\b",
                                                options: .anchorsMatchLines)
            
            let results = hashtagRegex.matches(in: text,
                                        options: .withoutAnchoringBounds,
                                        range: NSMakeRange(0, text.count))
            
            let array = results.map { (text as NSString).substring(with: $0.range) }
            
            for hashtag in array {
                let range = (richTextAttrString.string as NSString).range(of: hashtag)
                richTextAttrString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.systemBlue , range: range)
               
            }
            richTextAttrString.endEditing()
        }
        catch {
            richTextAttrString.endEditing()
           
        }
        
        do {
            let defaultRegex = try NSRegularExpression(pattern: "(?:\\s|^)((?:[a-zA-Z-а-яА-Я0-9].*?|\\d+[a-zA-Z-а-яА-Я0-9]+.*?))\\b",
                                                options: .anchorsMatchLines)
            
            let results = defaultRegex.matches(in: text,
                                        options: .withoutAnchoringBounds,
                                        range: NSMakeRange(0, text.count))
            
            let array = results.map { (text as NSString).substring(with: $0.range) }
            
            for hashtag in array {
                let range = (richTextAttrString.string as NSString).range(of: hashtag)
                richTextAttrString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black , range: range)
               
            }
            richTextAttrString.endEditing()
        }
        catch {
            richTextAttrString.endEditing()
           
        }
         setRichText(richTextAttrString)
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
