//
//  CustomMessagesCollectionViewFlowLayout.swift
//  ChatExample
//
//  Created by 鈴木治 on 2018/04/22.
//  Copyright © 2018年 MessageKit. All rights reserved.
//

import UIKit
import MessageKit

class CustomMessagesCollectionViewFlowLayout: MessagesCollectionViewFlowLayout {

    lazy open var customMessageSizeCalculator = CustomMessageSizeCalculator(layout: self)
    
    override func cellSizeCalculatorForItem(at indexPath: IndexPath) -> CellSizeCalculator {
        let message = messagesDataSource.messageForItem(at: indexPath, in: messagesCollectionView)
        switch message.kind {
        case .custom:
            //TODO: Add Custom
            print("custom")
            return customMessageSizeCalculator
        default:
            return super.cellSizeCalculatorForItem(at: indexPath)
        }
    }
}

open class CustomMessageSizeCalculator: MessageSizeCalculator {
    
    open override func messageContainerSize(for message: MessageType) -> CGSize {
        let maxWidth = messageContainerMaxWidth(for: message)
        let sizeForMediaItem = { (maxWidth: CGFloat, item: MediaItem?) -> CGSize in
//            guard let item = item else {
//                return CGSize.zero
//            }
//            if maxWidth < item.size.width {
//                // Maintain the ratio if width is too great
//                let height = maxWidth * item.size.height / item.size.width
//                return CGSize(width: maxWidth, height: height)
//            }
            return CGSize(width: 240, height: 80)
        }
        switch message.kind {
        case .custom(let item):
            return sizeForMediaItem(maxWidth, item as? MediaItem)
        default:
            fatalError("messageContainerSize received unhandled MessageDataType: \(message.kind)")
        }
    }
}
