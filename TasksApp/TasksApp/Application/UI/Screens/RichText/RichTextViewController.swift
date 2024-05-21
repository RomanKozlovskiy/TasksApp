//
//  RichTextViewController.swift
//  TasksApp
//
//  Created by user on 03.04.2024.
//

import UIKit
import RichTextKit
import SnapKit

final class RichTextViewController: UIViewController {
    
    private let richTextView = RichTextView(string: NSAttributedString(string: ""), format: .plainText)
    private let toolBar = UIToolbar()
    private let placeholderLabel = UILabel()
    
    private var boldButton: UIBarButtonItem?
    private var italicButton: UIBarButtonItem?
    private var strikethroughButton: UIBarButtonItem?
    private var underlinedButton: UIBarButtonItem?
    private var linkButton: UIBarButtonItem?
    
    private var linkedEditorPopup: LinkEditorPopupView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commonConfigure()
        addSubviews()
        applyConstraints()
        configureRichTextView()
        configureToolBar()
        richTextView.setRichTextFontSize(16)
    }
    
    private func commonConfigure() {
        view.backgroundColor = .white
        title = "Rich Text"
    }
    
    private func addSubviews() {
        view.addSubview(richTextView)
    }
    
    private func applyConstraints() {
        richTextView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }
    }
    
    private func configureRichTextView() {
        richTextView.delegate = self
        richTextView.backgroundColor = .lightGray
        richTextView.layer.cornerRadius = 10
        richTextView.inputAccessoryView = toolBar
        richTextView.allowsEditingTextAttributes = true
        richTextView.becomeFirstResponder()
        addPlaceholder()
    }
    
    private func addPlaceholder() {
         placeholderLabel.text = "Enter text..." //TODO: - убрать баг с длинным текстом
         placeholderLabel.font = .italicSystemFont(ofSize: (richTextView.font?.pointSize)!)
         placeholderLabel.sizeToFit()
         richTextView.addSubview(placeholderLabel)
         placeholderLabel.frame.origin = CGPoint(x: 5, y: (richTextView.font?.pointSize)! / 2)
         placeholderLabel.textColor = .tertiaryLabel
         placeholderLabel.isHidden = !richTextView.text.isEmpty
     }
    
    private func configureToolBar() {
        boldButton = UIBarButtonItem(title: "Bold", style: .plain, target: self, action: #selector(boldButtonDidTap))
        italicButton = UIBarButtonItem(title: "Italic", style: .plain, target: self, action: #selector(italicButtonDidTap))
        strikethroughButton = UIBarButtonItem(title: "Strikethrough", style: .plain, target: self, action: #selector(strikethroughButtonDidTap))
        underlinedButton = UIBarButtonItem(title: "Underlined", style: .plain, target: self, action: #selector(underlinedButtonDidTap))
        linkButton = UIBarButtonItem(title: "Link", style: .plain, target: self, action: #selector(linkButtonDidTap))
        toolBar.sizeToFit()
        
        guard
            let boldButton, let italicButton, let strikethroughButton, let underlinedButton, let linkButton
        else {
            return
        }
        
        toolBar.setItems([boldButton, italicButton, strikethroughButton, underlinedButton, linkButton], animated: true)
    }
    
    @objc private func boldButtonDidTap() {
        setRichTextStyle(from: boldButton, style: .bold)
    }
    
    @objc private func italicButtonDidTap() {
        setRichTextStyle(from: italicButton, style: .italic)
    }
    
    @objc private func strikethroughButtonDidTap() {
        setRichTextStyle(from: strikethroughButton, style: .strikethrough)
    }
    
    @objc private func underlinedButtonDidTap() {
        setRichTextStyle(from: underlinedButton, style: .underlined)
    }
    
    @objc private func linkButtonDidTap() {
        richTextView.resignFirstResponder()
        linkedEditorPopup = LinkEditorPopupView()
        guard let linkedEditorPopup else { return }
        linkedEditorPopup.delegate = self
        linkedEditorPopup.selectedRange = richTextView.selectedRange
        
        if richTextView.selectedRange.length != 0 {
            let attributes = richTextView.richTextAttributes(at: richTextView.selectedRange)
            if let link  = attributes[.link] as? String {
                linkedEditorPopup.setTextForTextField(text: link)
            }
        }
        view.addSubview(linkedEditorPopup)
    }
    
    private func setRichTextStyle(from barButton: UIBarButtonItem?, style: RichTextStyle) {
        guard let barButton else { return }
        barButton.isSelected.toggle()
        
        if barButton.isSelected == true {
            richTextView.setRichTextStyle(style, to: barButton.isSelected)
            barButton.tintColor = .systemBlue
        } else {
            richTextView.setRichTextStyle(style, to: barButton.isSelected)
            barButton.tintColor = .none
        }
    }
}

// MARK: - UITextViewDelegate

extension RichTextViewController: UITextViewDelegate {
    func textViewDidChangeSelection(_ textView: UITextView) {
        boldButton?.isSelected = richTextView.richTextStyles.contains(.bold) ? true : false
        italicButton?.isSelected = richTextView.richTextStyles.contains(.italic) ? true : false
        strikethroughButton?.isSelected = richTextView.richTextStyles.contains(.strikethrough) ? true : false
        underlinedButton?.isSelected = richTextView.richTextStyles.contains(.underlined) ? true : false
        
        print(richTextView.richTextStyles)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !richTextView.text.isEmpty

        richTextView.convertHashtags()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        placeholderLabel.isHidden = !richTextView.text.isEmpty
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        placeholderLabel.isHidden = true
    }
}

// MARK: - LinkEditorPopupDelegate

extension RichTextViewController: LinkEditorPopupDelegate {
    func cancelButtonDidTap() {
        linkedEditorPopup?.removeFromSuperview()
        richTextView.becomeFirstResponder()
    }
    
    func saveButtonDidTap(with link: String, at selectedRange: NSRange?) {
        
        linkedEditorPopup?.removeFromSuperview()
        
        if selectedRange?.length == 0 {
            if richTextView.isValidLink(link) {
                richTextView.pasteText(link, at: richTextView.rangeAfterInputCursor.lowerBound)
                richTextView.addRowLinkInText(link: link)
            } else {
                richTextView.pasteText(link, at: richTextView.rangeAfterInputCursor.lowerBound)
            }
            
        } else {
            
            if richTextView.isValidLink(link) {
                richTextView.addHyperlink(link, at: selectedRange!)
            } else {
                richTextView.removeHyperlink(at: selectedRange!)
            }
        }
        richTextView.setRichTextAttribute(.font, to: UIFont.systemFont(ofSize: 16), at: richTextView.rangeBeforeInputCursor)
        richTextView.becomeFirstResponder()
    }
}

