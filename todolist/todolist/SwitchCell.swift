//
//  SwitchCell.swift
//  todolist
//
//  Created by MustafaYektaTaraf on 11.09.2025.
//

import UIKit

class SwitchCell: UITableViewCell{
    static let identifier = "SwitchCell"
    
    private let iconContainer: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 4
        view.layer.masksToBounds = true
        return view
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .label
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    public let mySwitch: UISwitch = {
       let mySwitch = UISwitch()
        mySwitch.onTintColor = .systemRed
        mySwitch.setOn(false, animated: true)
        return mySwitch
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(label)
        contentView.addSubview(iconContainer)
        contentView.addSubview(mySwitch)
        iconContainer.addSubview(iconImageView)
        
        contentView.clipsToBounds = true
        accessoryType = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let containerSize: CGFloat = 36
        iconContainer.frame = CGRect(x: 15, y: (contentView.frame.height - containerSize)/2,
                                     width: containerSize, height: containerSize)
        
        let imageSize: CGFloat = 24
        iconImageView.frame = CGRect(x: (iconContainer.frame.width - imageSize)/2,
                                     y: (iconContainer.frame.height - imageSize)/2,
                                     width: imageSize, height: imageSize)
        
        mySwitch.sizeToFit()
        mySwitch.frame = CGRect(
            x: contentView.frame.width - mySwitch.frame.width - 20,
            y: (contentView.frame.height - mySwitch.frame.height)/2,
            width: mySwitch.frame.width,
            height: mySwitch.frame.height
        )
        
        label.frame = CGRect(
            x: iconContainer.frame.maxX + 15,
            y: 0,
            width: contentView.frame.width - iconContainer.frame.maxX - mySwitch.frame.width - 40,
            height: contentView.frame.height
        )
    }
    
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
        label.text = nil
        iconContainer.backgroundColor = nil
        mySwitch.isOn = false
    }
    
    public func configure(with model: SettingsSwitchOption) {
        label.text = model.title
        iconImageView.image = model.icon
        iconContainer.backgroundColor = model.iconBackgroundColor
        mySwitch.setOn(false, animated: false)
    }
}
