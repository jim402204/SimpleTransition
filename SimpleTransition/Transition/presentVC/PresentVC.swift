//
//  File.swift
//  SimpleTransition
//
//  Created by 江俊瑩 on 2020/11/4.
//

import UIKit

public protocol PresentBottomVCProtocol {
    var controllerHeight: CGFloat {get}
}

class PresentVC: UIPresentationController, PresentBottomVCProtocol {
    
    /// black layer
    lazy var blackView: UIView = {
        let view = UIView()
        if let frame = self.containerView?.bounds {
            view.frame = frame
        }
        view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(sendHideNotification))
        view.addGestureRecognizer(gesture)
        return view
    }()
    
    var controllerHeight: CGFloat = 200
    
    var dismissHandle: (()->())? = nil
    
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        //戴上參數
        
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
    }
    
    /// add blackView to the container and let alpha animate to 1 when show transition will begin
    override func presentationTransitionWillBegin() {
        blackView.alpha = 0
        containerView?.addSubview(blackView)
        UIView.animate(withDuration: 0.5) {
            self.blackView.alpha = 1
        }
    }
    
    /// let blackView's alpha animate to 0 when hide transition will begin.
    override func dismissalTransitionWillBegin() {
        UIView.animate(withDuration: 0.5) {
            self.blackView.alpha = 0
        }
    }
    
    /// remove the blackView when hide transition end
    ///
    /// - Parameter completed: completed or no
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        if completed {
            blackView.removeFromSuperview()
        }
    }
    
    /// define the frame of bottom view
    override var frameOfPresentedViewInContainerView: CGRect {
        return CGRect(x: 0, y: UIScreen.main.bounds.height-controllerHeight, width: UIScreen.main.bounds.width, height: controllerHeight)
    }
    
    
    @objc func sendHideNotification() {
        dismissHandle?()
    }
    
}
