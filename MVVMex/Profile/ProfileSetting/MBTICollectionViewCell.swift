//
//  MBTICollectionViewCell.swift
//  MVVMex
//
//  Created by 최정안 on 2/9/25.
//

import UIKit

class MBTICollectionViewCell: BaseCollectionViewCell {
    
    static let id = "MBTICollectionViewCell"
    private let charList = ["E", "I", "S", "N", "T", "F", "J", "P"]
    let charLabel = UILabel()
    
    func configData(itemidx : Int) {
        backgroundColor = .white
        charLabel.text = charList[itemidx]
    }
    func changeCellColor(isSelected: Bool) {
        self.isSelected = isSelected
        self.layer.cornerRadius = self.frame.height / 2
        if isSelected {
            self.backgroundColor = .ValidButtonColor
            self.layer.borderColor = UIColor.ValidButtonColor.cgColor
            self.charLabel.textColor = .white
        } else {
            self.backgroundColor = .white
            self.layer.borderColor = UIColor.InvalidButtonColor.cgColor
            self.charLabel.textColor = .InvalidButtonColor
        }
        


        
    }
    override func configureHierachy() {
        contentView.addSubview(charLabel)
    }
    override func configureLayout() {
        charLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func configureView() {
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.InvalidButtonColor.cgColor
        charLabel.textAlignment = .center
        charLabel.textColor = .InvalidButtonColor
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
}
