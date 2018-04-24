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
    
    //TODO:あとで共通化
    private let kOffsetX: CGFloat = 4
    private let kIcX: CGFloat = 16
    private let kIcW: CGFloat = 26
    private let icY: CGFloat = 10
    private let icH: CGFloat = 26
    private let kNameBaseH: CGFloat = 18
    
    open override func messageContainerSize(for message: MessageType) -> CGSize {

        switch message.kind {
        case .custom(let item):
            //TODO: セルのサイズ Add Custom
            print("custom")
            guard let item = item as? FileMediaItem else {
                return FileMessageCell.size
            }
            return mediaViewDisplaySize(item: item)
        default:
            fatalError("messageContainerSize received unhandled MessageDataType: \(message.kind)")
        }
    }
    
    func mediaViewDisplaySize(item: FileMediaItem) -> CGSize {
        let baseH: CGFloat = isBreakLine(item: item) ? FileMessageCell.size.height + kNameBaseH : FileMessageCell.size.height
        
        return CGSize(width: FileMessageCell.size.width, height: baseH)
    }
    
    
    private func nameBaseLabelHeightToEstimate(item: FileMediaItem) -> CGFloat {
        let nameHeight = heightForView(text: item.fileName ?? "", font:FileMessageCell.nameFont ,width: nameLabelWidth())
        return nameHeight
    }
    
    private func isBreakLine(item: FileMediaItem) -> Bool {
        return nameBaseLabelHeightToEstimate(item: item) > kNameBaseH
    }
    
    private func nameLabelWidth() -> CGFloat {
        return FileMessageCell.size.width - kIcW - kIcX - kOffsetX - 18
    }
    
    func heightForView(text: String, font: UIFont  ,width: CGFloat) -> CGFloat{
        let label = UILabel(frame: CGRect(x:0, y:0, width:width, height:CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = font
        label.text = text
        
        label.sizeToFit()
        return label.frame.height
    }
}
