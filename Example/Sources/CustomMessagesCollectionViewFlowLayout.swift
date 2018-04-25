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
            return customMessageSizeCalculator
        default:
            return super.cellSizeCalculatorForItem(at: indexPath)
        }
    }
}

open class CustomMessageSizeCalculator: MessageSizeCalculator {
    
    open override func messageContainerSize(for message: MessageType) -> CGSize {

        switch message.kind {
        case .custom(let item):
            guard let item = item as? FileMediaItem else {
                return FileMessageCell.size
            }
            let maxWidth = messageContainerMaxWidth(for: message)
            return fileBubbleSize(for: item, considering: maxWidth)
        default:
            fatalError("messageContainerSize received unhandled MessageDataType: \(message.kind)")
        }
    }
    
    open override func messageContainerMaxWidth(for message: MessageType) -> CGFloat {
        let maxWidth = super.messageContainerMaxWidth(for: message)
        return maxWidth - 10
    }
    
    func fileBubbleSize(for item: FileMediaItem, considering maxWidth: CGFloat) -> CGSize {
        return CGSize(width: maxWidth, height: FileMessageCell.size.height)
    }
}
