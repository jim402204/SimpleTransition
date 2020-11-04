//
//  SKSimpleTransition.swift
//  SimpleTransition
//
//  Created by 江俊瑩 on 2020/11/3.
//

import UIKit

class SimpleTransitionObject: NSObject, UIViewControllerAnimatedTransitioning {
    
    enum Status {
        case present
        case dismiss
    }
    
    fileprivate var duration: TimeInterval = 1
    var status: Status
    
    init(status: Status = .present) {
        self.status = status
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
//        let fromVC = transitionContext.viewController(forKey: .from)
//        let fromView = fromVC?.view
        
        let toVC = transitionContext.viewController(forKey: .to)
        let navigationToVC = toVC as? UINavigationController
        let newVC = navigationToVC?.viewControllers.first
        /// 動畫的結果View
        let containerView = transitionContext.containerView
        
        guard let toVCView = toVC?.view else { return transitionContext.completeTransition(false) } //false 不執行轉跳
        
        containerView.addSubview(toVCView)
        
        guard let toView = newVC?.view else { return transitionContext.completeTransition(false) }
        
        var startOffsetX: CGFloat = toView.bounds.width
        let endOffsetX: CGFloat = 0
        
        startOffsetX = (status == .dismiss) ?  -startOffsetX : startOffsetX
    
        let startOffset = CGRect(origin: CGPoint(x: startOffsetX, y: 0), size: toView.frame.size)
        let endOffset = CGRect(origin: CGPoint(x: endOffsetX, y: 0), size: toView.frame.size)

        preformAnimate(toView: toView, startOffset: startOffset, endOffset: endOffset, transitionContext: transitionContext)
        
    }
    
    
    func preformAnimate(toView: UIView, startOffset: CGRect, endOffset: CGRect, transitionContext: UIViewControllerContextTransitioning) {
        
        toView.frame = startOffset
       
        UIView.animate(withDuration: 0.4) {
            
            toView.frame = endOffset
            
        } completion: { bool in
            transitionContext.completeTransition(true)
        }
    }
    
}
