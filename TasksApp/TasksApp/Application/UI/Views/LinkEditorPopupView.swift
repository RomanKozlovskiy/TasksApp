//
//  LinkEditorPopupView.swift
//  TasksApp
//
//  Created by user on 15.05.2024.
//

import UIKit
import RichTextKit
import SnapKit

protocol LinkEditorPopupDelegate: AnyObject {
    func cancelButtonDidTap()
    func saveButtonDidTap(with link: String, at selectedRange: NSRange?)
}

final class LinkEditorPopupView: UIView {
    weak var delegate: LinkEditorPopupDelegate?
    
    var selectedRange: NSRange?

    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    private lazy var richTextView: RichTextView = RichTextView(string: NSAttributedString(string: ""), format: .plainText)
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.addTarget(self, action: #selector(cancelButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    private lazy var clearButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Сlear line", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.addTarget(self, action: #selector(clearButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save", for: .normal)
        button.addTarget(self, action: #selector(saveButtonDidTap), for: .touchUpInside)
        return button
    }()

    private lazy var buttonStack = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .none
        self.frame = UIScreen.main.bounds
        configureContentView()
        configureRichText()
        configureStackView()
        richTextView.becomeFirstResponder()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.cornerRadius = 10
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTextForTextField(text: String) {
        richTextView.text = text
    }
    
    private func configureContentView() {
        addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(200)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(UIScreen.main.bounds.width - 150)
            $0.width.equalTo(UIScreen.main.bounds.width - 40)
        }
    }
    
    private func configureRichText() {
        contentView.addSubview(richTextView)
        
        richTextView.backgroundColor = .white
        richTextView.layer.cornerRadius = 10
        
        richTextView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }
    }
    
    private func configureStackView() {
        contentView.addSubview(buttonStack)
        
        buttonStack.axis = .horizontal
        buttonStack.alignment = .fill
        buttonStack.spacing = 0
        buttonStack.distribution = .fillEqually
        
        buttonStack.addArrangedSubview(cancelButton)
        buttonStack.addArrangedSubview(clearButton)
        buttonStack.addArrangedSubview(saveButton)
        
        buttonStack.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(50)
        }
    }

    @objc private func cancelButtonDidTap() {
        richTextView.resignFirstResponder()
        delegate?.cancelButtonDidTap()
        
    }
    
    @objc private func clearButtonDidTap() {
        richTextView.text = ""
    }
    
    @objc private func saveButtonDidTap() {
        richTextView.resignFirstResponder()
        guard let link = richTextView.text else { return }
        delegate?.saveButtonDidTap(with: link, at: selectedRange)
    }
}
