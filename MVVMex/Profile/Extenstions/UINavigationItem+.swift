//
//  UINavigationItem+.swift
//  MovieLike
//
//  Created by 최정안 on 2/1/25.
//

import UIKit

extension UINavigationItem {
    func setBarTitleView(title: String) {
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.textColor = .black
        self.titleView = titleLabel
    }

}
