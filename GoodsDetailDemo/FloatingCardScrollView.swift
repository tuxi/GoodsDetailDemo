//
//  FloatingCardScrollView.swift
//  GoodsDetailDemo
//
//  Created by xiaoyuan on 2020/3/28.
//  Copyright © 2020 enba. All rights reserved.
//

import UIKit

protocol FloatingCardScrollViewDelegate {
    func numberOfCards() -> Int
    func cardReuseView(_ reuseView: UIView, floatingCardScrollView: FloatingCardScrollView, atIndex index: Int) -> UIView
    func didChangeIndex(_ index: Int)
}


class FloatingCardScrollView: UIView {

    enum ScrollDirection {
        case left
        case rigt
    }
    
    
}
