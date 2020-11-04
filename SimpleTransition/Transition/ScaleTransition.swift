//
//  Transition.swift
//  SimpleTransition
//
//  Created by 江俊瑩 on 2020/11/4.
//

import UIKit

class ScaleTransitionDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    static var share = ScaleTransitionDelegate()
    
    let transition = ScaleTransitionAnimation()
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionAnimationStatus = .present
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionAnimationStatus = .dismiss
        return transition
    }
}

enum TransitionAnimationStatus {
    case present
    case dismiss
}

class ScaleTransitionAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    
    fileprivate var duration = 0.25
    fileprivate var visualEffectView = UIVisualEffectView()
    
    var transitionAnimationStatus: TransitionAnimationStatus
    
    init(status: TransitionAnimationStatus = .present) {
        self.transitionAnimationStatus = status
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        //false alert 直接消失
        guard let fromView = transitionContext.view(forKey: .from) else { return transitionContext.completeTransition(false) }
        guard let toView = transitionContext.view(forKey: .to) else { return transitionContext.completeTransition(false) }
        let containView = transitionContext.containerView
        
        let snapshot = fromView.snapshotView(afterScreenUpdates: false) ?? notFoundView()
        visualEffectView.frame = snapshot.bounds
        
        
        switch transitionAnimationStatus {
        case .present:
            containView.addSubview(snapshot)
            containView.addSubview(visualEffectView)
            containView.addSubview(toView)

            toView.transform = CGAffineTransform(scaleX: 0, y: 0)
            toView.alpha = 0
        case .dismiss:
            
            fromView.transform = CGAffineTransform(scaleX: 1, y: 1)
            fromView.alpha = 1
        }
        
        UIView.animate(withDuration: duration, animations: { [weak self] in
            guard let transitionAnimationStatus = self?.transitionAnimationStatus else { return }
            switch transitionAnimationStatus {
            case .present:
                self?.visualEffectView.effect = UIBlurEffect(style: .light)
                toView.transform = CGAffineTransform(scaleX: 1, y: 1)
                toView.alpha = 1
            case .dismiss:
                self?.visualEffectView.effect = nil
                fromView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                fromView.alpha = 0
            }
        }) { finished in
            transitionContext.completeTransition(true)
        }
    }
    
    /// 截圖失敗墊一個白色的View當背景
    func notFoundView() -> UIView {
        
        let height = UIScreen.main.bounds.height
        let width = UIScreen.main.bounds.width
        let mainFrame = CGRect(origin: .zero, size: CGSize(width: width, height: height))
        let view = UIView()
        view.backgroundColor = .white
        view.frame = mainFrame
        return view
    }
    
}
