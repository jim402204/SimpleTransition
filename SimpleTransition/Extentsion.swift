//
//  Extentsion.swift
//  SimpleTransition
//
//  Created by 江俊瑩 on 2020/11/4.
//

import UIKit

extension UIViewController {
    
    ///透過window.layer添加動畫
    func present(_ vc: UIViewController) {
        
        vc.modalPresentationStyle = .fullScreen
        addAnimation(direction: .fromRight)
        
        self.present(vc, animated: false, completion: nil)
    }
    
    ///透過window.layer添加動畫
    func dismiss() {
        
        addAnimation(direction: .fromLeft)
        
        self.dismiss(animated: false, completion: nil)
    }
    
    func addAnimation(direction: CATransitionSubtype) {
        
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.push
        transition.subtype = direction
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        //任務抓取當前window方法即可
        view.window?.layer.add(transition, forKey: kCATransition)
    }
    
}
