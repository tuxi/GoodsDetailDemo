//
//  GoodsDetailViewController.swift
//  GoodsDetailDemo
//
//  Created by xiaoyuan on 2020/2/25.
//  Copyright © 2020 enba. All rights reserved.
//

import UIKit

class GoodsDetailViewController: UIViewController {
    
    @IBOutlet weak var leftLayout: NSLayoutConstraint!
    @IBOutlet weak var topLayout: NSLayoutConstraint!
    @IBOutlet weak var bottomLayout: NSLayoutConstraint!
    @IBOutlet weak var headTopLayout: NSLayoutConstraint!
    @IBOutlet weak var backScrollView: UIScrollView!
    @IBOutlet weak var headScrollView: UIScrollView!
    @IBOutlet weak var detailScrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var headView: UIView!
    @IBOutlet weak var headLine: UIView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var detailTipLbl: UILabel!
    @IBOutlet weak var detailTipTopLayout: NSLayoutConstraint!
    @IBOutlet weak var rightTipLbl: UILabel!
    @IBOutlet weak var rightTipLeftLayout: NSLayoutConstraint!
    @IBOutlet weak var backTipLbl: UILabel!
    @IBOutlet weak var backTipBottomLayout: NSLayoutConstraint!
    @IBOutlet weak var headerViewHeight: NSLayoutConstraint!
    
    var lastAlpha: CGFloat = 0.0
    var lastAlphaCur: CGFloat = 0.0
    var isDetail: Bool = false
    var isDetailFromRight: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        rightTipLbl.text = "滑\n动\n查\n看\n图\n文\n详\n情";
        backScrollView.delegate = self
        headScrollView.delegate = self
        detailScrollView.delegate = self
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        if #available(iOS 11.0, *) {
            headerViewHeight.constant = (UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0.0) + 44.0
        } else {
            headerViewHeight.constant = 64.0
        }
    }
    
    fileprivate func changeNav() {
        if lastAlphaCur == lastAlpha {
            return
        }
        lastAlphaCur = lastAlpha
        headView.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: lastAlphaCur)
        headLine.backgroundColor = UIColor(red: 234.0/255.0, green: 234.0/255.0, blue: 234.0/255.0, alpha: lastAlphaCur)
    }
    
    fileprivate func showDetailFromRight() {
        if isDetailFromRight == true {
            return
        }
        detailView.isHidden = false
        isDetailFromRight = true
        topLayout.constant = -(detailScrollView.frame.size.height + 20)
        leftLayout.constant = self.view.frame.size.width
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
        leftLayout.constant = 0.0
        self.view.setNeedsLayout()
        lastAlpha = 1.0
        detailTipLbl.alpha = 0
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
            self.changeNav()
            self.backBtn.alpha = 1.0
        }) { (isFinised) in
            
        }
    }
    
    fileprivate func showDetail() {
        
        if isDetail == true {
            return
        }
        detailView.isHidden = false
        isDetail = true
        topLayout.constant = 0
        bottomLayout.priority = UILayoutPriority(rawValue: 249.0)
        self.view.setNeedsLayout()
        UIView.animate(withDuration: 0.25) {
            self.view.layoutIfNeeded()
        }
    }
    
    fileprivate func showFoot() {
        
    }
    
    fileprivate func hideDetail() {
        if isDetail == false {
            return
        }
        isDetail = false
        bottomLayout.priority = UILayoutPriority(rawValue: 750)
        self.view.setNeedsLayout()
        UIView.animate(withDuration: 0.25) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func hideDetailToRight() {
        if isDetailFromRight == false {
            return;
        }
        isDetailFromRight = false
        leftLayout.constant = self.view.frame.size.width
        lastAlpha = 0.0
        self.view.setNeedsLayout()
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
            self.changeNav()
        }) { (isFinished) in
            self.topLayout.constant = 0
            self.leftLayout.constant = 0
        }
    }
    
    
    // MARK: - Actions

    @IBAction func backBtnAction(_ sender: Any) {
        hideDetailToRight()
    }
}

extension GoodsDetailViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == backScrollView {
            if scrollView.contentOffset.y > 0 {
                headTopLayout.constant = scrollView.contentOffset.y * 0.5
                backTipBottomLayout.constant = 0.0
            }
            else {
                headTopLayout.constant = 0.0
                backTipBottomLayout.constant = scrollView.contentOffset.y
                if scrollView.contentOffset.y < -40.0 {
                    backTipLbl.text = "释放查看更多精彩"
                }
                else {
                    backTipLbl.text = "下拉查看更多精彩"
                }
            }
            
            if scrollView.contentOffset.y > headScrollView.frame.size.height - headerViewHeight.constant {
                lastAlpha = 1.0
                self.changeNav()
            }
            else if scrollView.contentOffset.y >= 0.0 {
                lastAlpha = scrollView.contentOffset.y / (headScrollView.frame.size.height - headerViewHeight.constant)
                self.changeNav()
            }
            if isDetail == false {
                if scrollView.contentOffset.y + scrollView.frame.size.height > scrollView.contentSize.height {
                    topLayout.constant = -(scrollView.contentOffset.y + scrollView.frame.size.height - scrollView.contentSize.height)
                }
                else {
                    topLayout.constant = 0
                }
            }
        }
        else if scrollView == headScrollView {
            
            if scrollView.contentOffset.x + scrollView.frame.size.width > scrollView.contentSize.width {
                rightTipLeftLayout.constant = 15.0 - (scrollView.contentOffset.x + scrollView.frame.size.width - scrollView.contentSize.width)
            }
            else {
                rightTipLeftLayout.constant = 15
            }
            
            if scrollView.contentOffset.x + scrollView.frame.size.width > scrollView.contentSize.width + 40.0 {
                rightTipLbl.text = "释\n放\n查\n看\n图\n文\n详\n情"
            } else {
                rightTipLbl.text = "滑\n动\n查\n看\n图\n文\n详\n情"
            }
        }
        else if scrollView == detailScrollView {
            if isDetailFromRight == false {
                if scrollView.contentOffset.y < 0.0 {
                    if scrollView.contentOffset.y < -30.0 {
                        detailTipLbl.alpha = 1.0
                    } else {
                        detailTipLbl.alpha = -scrollView.contentOffset.y / 30.0
                    }
                } else {
                    detailTipLbl.alpha = 0.0
                }
                if scrollView.contentOffset.y < -40.0 {
                    detailTipLbl.text = "释放，返回宝贝详情"
                    detailTipTopLayout.constant = 55.0 - 40.0 - scrollView.contentOffset.y
                } else {
                    detailTipLbl.text = "下拉，返回宝贝详情"
                    detailTipTopLayout.constant = 55.0
                }
            }
        }
        
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
         if scrollView == backScrollView {
            if scrollView.contentOffset.y + scrollView.frame.size.height - scrollView.contentSize.height > 40.0 {
                self.showDetail()
             } else if scrollView.contentOffset.y < -40.0 {
                self.showFoot()
             }
         } else if scrollView == detailScrollView {
            if isDetail && scrollView.contentOffset.y < -40.0 {
                self.hideDetail()
             }
         } else if scrollView == headScrollView {
            if scrollView.contentOffset.x + scrollView.frame.size.width - scrollView.contentSize.width > 40.0 {
                 showDetailFromRight()
             }
         }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == headScrollView {
            pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
        }
    }

}
