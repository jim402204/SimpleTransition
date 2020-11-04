//
//  SimpleTransitionDelegate.swift
//  SimpleTransition
//
//  Created by 江俊瑩 on 2020/11/3.
//

import UIKit

class PresentAsPushTransitionDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    static var share = PresentAsPushTransitionDelegate()
    
    let transition = SimpleTransitionObject()
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.status = .present
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.status = .dismiss
        return transition
    }
}


