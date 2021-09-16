//
//  NotificationButton.swift
//  NotificationButton
//
//  Created by Awais Iqbal on 16/09/2021.
//

import UIKit

struct NotificationButtonViewModel {
    let notificationCount : Int
    let buttonImageName : String
    let notificationBadgeBackgroundColor : UIColor
}

class NotificationButton: UIButton {
    
    // Mark - views
    private var notificationCountLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .white
        label.text = "0"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    private var notificationView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.red
        return view
    }()
    
    private var notificationImage : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.image = UIImage(systemName: "cart")
        image.tintColor = .black
        return image
    }()
    
    //Mark - properties
    var viewModel : NotificationButtonViewModel?
    
    //Mark - Life cycle
    init(with viewModel : NotificationButtonViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        configure(with: viewModel)
        backgroundColor = .clear
        addSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
        addSubviews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        notificationView.frame = CGRect(x: frame.width - ((frame.height*0.7)/2), y: (-((frame.height*0.7)/2)), width: frame.height * 0.7, height: frame.height * 0.7).integral
        notificationView.layer.cornerRadius = notificationView.frame.height / 2
        notificationView.clipsToBounds = true
        notificationCountLabel.frame = CGRect(x: frame.width - ((frame.height/2)/2), y: (-((frame.height/2)/2)), width: frame.height / 2, height: frame.height / 2).integral
        notificationImage.frame = CGRect(x: (frame.width/2 - ((frame.width)/2)), y: frame.height/2 - ((frame.height)/2), width: frame.width, height: frame.height)
        bringSubviewToFront(notificationView)
        bringSubviewToFront(notificationCountLabel)//(notificationCountLabel)
    }
    
    //Mark - Action
    private func addSubviews() {
        addSubview(notificationView)
        addSubview(notificationImage)
        addSubview(notificationCountLabel)
    }
    
    public func configure(with viewModel : NotificationButtonViewModel) {
        
        backgroundColor = .clear
        setNotificationCount(count: viewModel.notificationCount)
        setNotificationImage(withImageName: viewModel.buttonImageName)
        notificationView.backgroundColor = viewModel.notificationBadgeBackgroundColor
        addSubviews()
    }
    
    public func setNotificationCount(count : Int) {
        if count > 99 {
            notificationCountLabel.text = String(99)
        }
        notificationCountLabel.text = String(count)
    }
    
    public func setNotificationViewBackgroundColor(withColor color : UIColor) {
        notificationView.backgroundColor = color
    }
    
    public func setNotificationImage(withImageName imageName : String) {
        guard let image = UIImage(named: imageName)  else {
            print("NotificationButton Error: Invalid Image Name.")
            return
        }
        notificationImage.image = image
    }
    
    public func setNotificationCountTextSize(withSize size : CGFloat) {
        self.notificationCountLabel.font = UIFont.boldSystemFont(ofSize: (size))
    }
}
