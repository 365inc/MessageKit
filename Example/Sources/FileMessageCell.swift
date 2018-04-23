//
//  FileMessageCell.swift
//  ChatExample
//
//  Created by 鈴木治 on 2018/04/23.
//  Copyright © 2018年 MessageKit. All rights reserved.
//

import UIKit
import MessageKit

class FileMessageCell: MessageContentCell {
    
    /// The play button view to display on video messages.
    open lazy var playButtonView: PlayButtonView = {
        let playButtonView = PlayButtonView()
        return playButtonView
    }()
    
    /// The image view display the media content.
    open var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    // MARK: - Methods
    
    /// Responsible for setting up the constraints of the cell's subviews.
    open func setupConstraints() {
//        imageView.fillSuperview()
//        playButtonView.centerInSuperview()
//        playButtonView.constraint(equalTo: CGSize(width: 35, height: 35))
    }
    
    override func setupSubviews() {
        super.setupSubviews()
//        messageContainerView.addSubview(imageView)
//        messageContainerView.addSubview(playButtonView)
        setupConstraints()
    }
    
    override func configure(with message: MessageType, at indexPath: IndexPath, and messagesCollectionView: MessagesCollectionView) {
        super.configure(with: message, at: indexPath, and: messagesCollectionView)
        
        guard let displayDelegate = messagesCollectionView.messagesDisplayDelegate else {
            fatalError("displayDelegate not found")
        }
        
        switch message.kind {
        case .custom(let item):
            if let item = item as? MockFileMediaItem {
                print(item.hogehoge)
            }
        
            //TODO: Add custom imageview
//            imageView.image = mediaItem.image ?? mediaItem.placeholderImage
//            playButtonView.isHidden = true
        default:
            break
        }
        
        displayDelegate.configureMediaMessageImageView(imageView, for: message, at: indexPath, in: messagesCollectionView)
    }
}
