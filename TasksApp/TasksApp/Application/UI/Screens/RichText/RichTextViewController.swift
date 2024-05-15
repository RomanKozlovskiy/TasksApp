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
    
    private var boldButton: UIBarButtonItem?
    private var italicButton: UIBarButtonItem?
    private var strikethroughButton: UIBarButtonItem?
    private var underlinedButton: UIBarButtonItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commonConfigure()
        addSubviews()
        applyConstraints()
        configureRichTextView()
        configureToolBar()
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
    }
    
    private func configureToolBar() {
        let flexibleSpace = UIBarButtonItem.flexibleSpace()
        boldButton = UIBarButtonItem(title: "Bold", style: .plain, target: self, action: #selector(boldButtonDidTap))
        italicButton = UIBarButtonItem(title: "Italic", style: .plain, target: self, action: #selector(italicButtonDidTap))
        strikethroughButton = UIBarButtonItem(title: "Strikethrough", style: .plain, target: self, action: #selector(strikethroughButtonDidTap))
        underlinedButton = UIBarButtonItem(title: "Underlined", style: .plain, target: self, action: #selector(underlinedButtonDidTap))
        toolBar.sizeToFit()
        
        guard
            let boldButton, let italicButton, let strikethroughButton, let underlinedButton
        else {
            return
        }
        
        toolBar.setItems([flexibleSpace, boldButton, italicButton, strikethroughButton, underlinedButton, flexibleSpace], animated: true)
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

extension RichTextViewController: UITextViewDelegate {
    func textViewDidChangeSelection(_ textView: UITextView) {
        boldButton?.isSelected = richTextView.richTextStyles.contains(.bold) ? true : false
        italicButton?.isSelected = richTextView.richTextStyles.contains(.italic) ? true : false
        strikethroughButton?.isSelected = richTextView.richTextStyles.contains(.strikethrough) ? true : false
        underlinedButton?.isSelected = richTextView.richTextStyles.contains(.underlined) ? true : false
    }
    
    func textViewDidChange(_ textView: UITextView) {
        richTextView.resolveHashtag()
    }
}
