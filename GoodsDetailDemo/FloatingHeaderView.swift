//
//  FloatingHeaderView.swift
//  GoodsDetailDemo
//
//  Created by xiaoyuan on 2020/3/28.
//  Copyright © 2020 enba. All rights reserved.
//

import UIKit

class FloatingHeaderView: UIView {

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        self.addSubview(self.titleLabel)
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        var topSafePadding: CGFloat = 20.0
        if #available(iOS 11.0, *) {
            topSafePadding = UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0.0
        }
        self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: topSafePadding).isActive = true
        
        self.titleLabel.text = "我的足迹"
    }
}
