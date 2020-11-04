//
//  ViewController.swift
//  SimpleTransition
//
//  Created by 江俊瑩 on 2020/11/3.
//

import UIKit

class MainViewController: UIViewController {

    var detailVC: UIViewController = {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        return sb.instantiateViewController(identifier: "DetailViewController")
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func presentAsPushAction(_ sender: Any) {
        
        let detailNVC = UINavigationController(rootViewController: detailVC)
        
        detailNVC.modalPresentationStyle = .fullScreen
        //transitioningDelegate 為VC的方法
        detailNVC.transitioningDelegate = PresentAsPushTransitionDelegate.share
        
        present(detailNVC, animated: true, completion: nil)
    }
    
    @IBAction func presentAsPushLayerAction(_ sender: Any) {
        
        let detailNVC = UINavigationController(rootViewController: detailVC)
        present(detailNVC)
    }
    
    @IBAction func otherAnimateAction(_ sender: Any) {
        
        let detailNVC = UINavigationController(rootViewController: detailVC)
        
        detailNVC.modalPresentationStyle = .fullScreen
        detailNVC.transitioningDelegate = ScaleTransitionDelegate.share
        
        present(detailNVC, animated: true, completion: nil)
    }
    
    @IBAction func presentAction(_ sender: Any) {
        
        let viewController = detailVC
        viewController.modalPresentationStyle = .custom
        viewController.transitioningDelegate = self
        self.present(viewController, animated: true)
    }
    
}

extension MainViewController: UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        let presentVC = PresentVC(presentedViewController: presented, presenting: presenting)
        presentVC.dismissHandle = { 
            source.dismiss(animated: true, completion: nil)
        }
        
        return presentVC
    }
    
}
