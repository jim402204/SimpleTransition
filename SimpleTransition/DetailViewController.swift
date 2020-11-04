//
//  ViewController.swift
//  SimpleTransition
//
//  Created by 江俊瑩 on 2020/11/3.
//

import UIKit

class DetailViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func dismissAsPopAction(_ sender: Any) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let mainVC = sb.instantiateViewController(identifier: "MainNavigation")
        mainVC.modalPresentationStyle = .fullScreen
        mainVC.transitioningDelegate = PresentAsPushTransitionDelegate.share
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func dismissAsPopLayerAction(_ sender: Any) {
        
        dismiss()
    }
    
    @IBAction func otherAnimateAction(_ sender: Any) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let mainVC = sb.instantiateViewController(identifier: "MainNavigation")
        mainVC.modalPresentationStyle = .fullScreen
        mainVC.transitioningDelegate = ScaleTransitionDelegate.share
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func presentAction(_ sender: Any) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let mainVC = sb.instantiateViewController(identifier: "MainNavigation")
        mainVC.modalPresentationStyle = .custom
        mainVC.transitioningDelegate = self
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension DetailViewController: UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        let presentVC = PresentVC(presentedViewController: presented, presenting: presenting)
        presentVC.dismissHandle = {
            source.dismiss(animated: true, completion: nil)
        }
        
        return presentVC
    }
    
}
