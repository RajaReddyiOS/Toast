//
//  ToastUtils.swift
//  Toast
//
//  Created by Raja on 31/05/18.
//  Copyright © 2018 Raja. All rights reserved.
//

import UIKit

public class ToastUtil {
    static var sharedInstance:ToastUtil?
    
    fileprivate lazy var containerView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.layer.cornerRadius = 5
        return view
    }()
    
    var setCornerRadius:CGFloat? {
        didSet {
            guard let radius = setCornerRadius else {return}
            containerView.layer.cornerRadius = radius
        }
    }
    
    var setToastTextColor:UIColor? {
        didSet {
            toastLbl.textColor = setToastTextColor
        }
    }
    
    var setToastBackgroundColor:UIColor? {
        didSet {
            containerView.backgroundColor = setToastBackgroundColor
        }
    }
    
    public var dismissDuration:Double = 1.0
    
    fileprivate lazy var toastLbl:UILabel = {
        let lb = UILabel()
        lb.textAlignment = .center
        lb.textColor = UIColor.white
        lb.numberOfLines = 0
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    public class func shared() -> ToastUtil {
        guard let uwShared = sharedInstance else {
            sharedInstance = ToastUtil()
            return sharedInstance!
        }
        return uwShared
    }
    public class func destroy() {
        sharedInstance = nil
    }
    
    public init() {
        
        guard let currentWindow = UIApplication.shared.keyWindow else { return }
        currentWindow.addSubview(containerView)
        
        if #available(iOS 11.0, *) {
            [containerView.rightAnchor.constraint(lessThanOrEqualTo: currentWindow.safeAreaLayoutGuide.rightAnchor, constant: -12),
             containerView.leftAnchor.constraint(greaterThanOrEqualTo: currentWindow.safeAreaLayoutGuide.leftAnchor, constant: 12),
             containerView.bottomAnchor.constraint(equalTo: currentWindow.safeAreaLayoutGuide.bottomAnchor, constant: -40),
             containerView.centerXAnchor.constraint(equalTo: currentWindow.centerXAnchor)].forEach { (constraints) in
                constraints.isActive = true
            }
        }else {
            [containerView.rightAnchor.constraint(lessThanOrEqualTo: currentWindow.rightAnchor, constant: -12),
             containerView.leftAnchor.constraint(greaterThanOrEqualTo: currentWindow.leftAnchor, constant: 12),
             containerView.bottomAnchor.constraint(equalTo: currentWindow.bottomAnchor, constant: -40),
             containerView.centerXAnchor.constraint(equalTo: currentWindow.centerXAnchor)].forEach { (constraints) in
                constraints.isActive = true
            }
        }

        containerView.addSubview(toastLbl)
        [toastLbl.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
         toastLbl.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8),
         toastLbl.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -8),
         toastLbl.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 8)].forEach { (constraints) in
            constraints.isActive = true
        }
        containerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissToast)))
    }
    
    @objc fileprivate func dismissToast() {
        UIView.animate(withDuration: 1.0, animations: {
            self.containerView.alpha = 0
        }) { (isFinish) in
            if isFinish {
                self.containerView.isHidden = true
            }
        }
        
    }
    
    public class func makeToast(_ title:String, duration:Double = ToastUtil.shared().dismissDuration) {
        if title == "" {
            return
        }
        
        ToastUtil.shared().dismissDuration = duration
        print("dismiss duration from param: \(duration) from Toast class: \(ToastUtil.shared().dismissDuration)")
        if sharedInstance == nil {
            _=ToastUtil.shared()
        }
        ToastUtil.shared().containerView.alpha = 1
        ToastUtil.shared().containerView.isHidden = false
        ToastUtil.shared().toastLbl.text = title

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(Int(duration))) {
            ToastUtil.shared().dismissToast()
        }
    }
    
    
}
