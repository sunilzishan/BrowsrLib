//
//  ToastView.swift
//  BrowsrLib
//
//  Created by Sunil Zishan on 24.07.23.
//

import UIKit

public class ToastView: UIView {
    private let messageLabel = UILabel()
    private let toastBackgroundColor = UIColor.black.withAlphaComponent(0.7)
    private let toastTextColor = UIColor.white
    private let toastCornerRadius: CGFloat = 8.0
    private let toastMargin: CGFloat = 20.0
    private let toastPadding: CGFloat = 16.0
    private let toastDuration: TimeInterval = 2.0
    
    public init() {
        super.init(frame: CGRect.zero)
        setupUI()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupUI() {
        backgroundColor = toastBackgroundColor
        layer.cornerRadius = toastCornerRadius
        clipsToBounds = true
        
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.textColor = toastTextColor
        messageLabel.numberOfLines = 0
        addSubview(messageLabel)
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: toastPadding),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: toastPadding),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -toastPadding),
            messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -toastPadding)
        ])
    }
    
    public func showToast(with message: String) {
        messageLabel.text = message
        let toastWidth = UIScreen.main.bounds.width - (2 * toastMargin)
        
        let size = messageLabel.sizeThatFits(CGSize(width: toastWidth - (2 * toastPadding), height: CGFloat.greatestFiniteMagnitude))
        let toastHeight = size.height + (2 * toastPadding)
        
        frame = CGRect(x: toastMargin, y: UIScreen.main.bounds.height - toastHeight - toastMargin, width: toastWidth, height: toastHeight)
        alpha = 0.0
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let mainWindow = windowScene.windows.first {
            mainWindow.addSubview(self)
        }
        
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 1.0
        }) { (_) in
            self.perform(#selector(self.hideToast), with: nil, afterDelay: self.toastDuration)
        }
    }
    
    @objc private func hideToast() {
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 0.0
        }) { (_) in
            self.removeFromSuperview()
        }
    }
}

