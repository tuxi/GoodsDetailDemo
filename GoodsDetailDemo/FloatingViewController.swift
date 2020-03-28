//
//  FloatingViewController.swift
//  GoodsDetailDemo
//
//  Created by xiaoyuan on 2020/3/28.
//  Copyright © 2020 enba. All rights reserved.
//

import UIKit

class FloatingViewController: UIViewController {
    
    lazy var headerView = {
        return UINib(nibName: "FloatingHeaderView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! FloatingHeaderView
    }()
    
    lazy var bgBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        btn.alpha = 1.0
        return btn
    }()
    
    private var bgBtnTopConstraint: NSLayoutConstraint?
    
    class func showTo(parent: UIViewController) {
        let vc = FloatingViewController()
        vc.view.frame = parent.view.bounds
        parent.addChild(vc)
        parent.view.addSubview(vc.view)
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        vc.view.leadingAnchor.constraint(equalTo: parent.view.leadingAnchor).isActive = true
        vc.view.trailingAnchor.constraint(equalTo: parent.view.trailingAnchor).isActive = true
        vc.view.topAnchor.constraint(equalTo: parent.view.topAnchor).isActive = true
        vc.view.bottomAnchor.constraint(equalTo: parent.view.bottomAnchor).isActive = true
        vc.view.layoutIfNeeded()
        DispatchQueue.main.async {
            vc.show()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
    }
    
    private func setupUI() {
        [headerView, bgBtn].forEach { (subview) in
            self.view.addSubview(subview)
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
        
        bgBtn.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0.0).isActive = true
        bgBtn.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0.0).isActive = true
        bgBtnTopConstraint = bgBtn.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0.0)
        bgBtn.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0.0).isActive = true
        bgBtnTopConstraint?.isActive = true
        
        headerView.bottomAnchor.constraint(equalTo: bgBtn.topAnchor, constant: 0.0).isActive = true
        headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0.0).isActive = true
        headerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0.0).isActive = true
        
        bgBtn.addTarget(self, action: #selector(clickBgBtn(sender:)), for: .touchUpInside)
    }

    @objc private func clickBgBtn(sender: UIButton) {
        
        sender.isEnabled = false
        bgBtnTopConstraint?.constant = 0.0
        self.view.setNeedsLayout()
        UIView.animate(withDuration: 0.25, animations: {
            self.view.layoutIfNeeded()
            self.bgBtn.alpha = 0.0
        }) { (isFinised) in
            self.view.removeFromSuperview()
            self.removeFromParent()
            self.didMove(toParent: nil)
        }
    }
    
    fileprivate func show() {
        self.bgBtnTopConstraint?.constant = self.headerView.frame.size.height
        self.view.setNeedsLayout()
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        }) { (isFinished) in
            self.bgBtn.alpha = 1.0
        }
    }
}
