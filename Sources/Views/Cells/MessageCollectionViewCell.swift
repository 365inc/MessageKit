/*
 MIT License

 Copyright (c) 2017-2018 MessageKit

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 */

import UIKit

/// A subclass of `UICollectionViewCell` to be used inside of a `MessagesCollectionView`.
open class MessageCollectionViewCell: UICollectionViewCell {

//<<<<<<< HEAD
//    open class func reuseIdentifier() -> String {
//        return "messagekit.cell.base-cell"
//    }
//
//    open var avatarView = AvatarView()
//
//    open var messageContainerView: MessageContainerView = {
//        let containerView = MessageContainerView()
//        containerView.clipsToBounds = true
//        containerView.layer.masksToBounds = true
//        return containerView
//    }()
//
//    open var cellTopLabel: UILabel = {
//        let label = UILabel()
//        label.numberOfLines = 0
//        return label
//    }()
//
//    open var cellBottomLabel: UILabel = {
//        let label = UILabel()
//        label.numberOfLines = 0
//        return label
//    }()
//
//    //osuzuki create label
//    open var cellSideBottomLabel: UILabel = {
//        let label = UILabel()
//        label.numberOfLines = 0
//        return label
//    }()
//
//    //osuzuki create label
//    open var cellTimeLabel: UILabel = {
//        let label = UILabel()
//        label.numberOfLines = 0
//        return label
//    }()
//
//    //osuzuki create favorite button
//    open var cellFavoriteButton: UIButton = {
//        let button = UIButton()
//        return button
//    }()
//
//    open weak var delegate: MessageCellDelegate?
//=======
    // MARK: - Initializers
//>>>>>>> msg/development

    public override init(frame: CGRect) {
        super.init(frame: frame)
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

//<<<<<<< HEAD
//    open func setupSubviews() {
//        contentView.addSubview(messageContainerView)
//        contentView.addSubview(avatarView)
//        contentView.addSubview(cellTopLabel)
//        contentView.addSubview(cellBottomLabel)
//        contentView.addSubview(cellSideBottomLabel)//osuzuki
//        contentView.addSubview(cellTimeLabel)//osuzuki
//        contentView.addSubview(cellFavoriteButton)//osuzuki
//    }
//
//    open override func prepareForReuse() {
//        super.prepareForReuse()
//        cellTopLabel.text = nil
//        cellTopLabel.attributedText = nil
//        cellBottomLabel.text = nil
//        cellBottomLabel.attributedText = nil
//        cellSideBottomLabel.text = nil
//        cellSideBottomLabel.attributedText = nil//osuzuki
//        cellTimeLabel.text = nil
//        cellTimeLabel.attributedText = nil//osuzuki
//        cellFavoriteButton.setImage(UIImage(), for: .normal)
////        cellFavoriteButton.setImage(UIImage(), for: .highlighted)f
//        cellFavoriteButton.setImage(UIImage(), for: .selected)
//    }
//
//    // MARK: - Configuration
//
//    open override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
//        super.apply(layoutAttributes)
//        if let attributes = layoutAttributes as? MessagesCollectionViewLayoutAttributes {
//            avatarView.frame = attributes.avatarFrame
//            cellTopLabel.frame = attributes.topLabelFrame
//            cellBottomLabel.frame = attributes.bottomLabelFrame
//            cellSideBottomLabel.frame = attributes.sideBottomLabelFrame//osuzuki
//            cellTimeLabel.frame = attributes.timeLabelFrame//osuzuki
//            cellFavoriteButton.frame = attributes.favoriteButtonFrame//osuzuki
//            messageContainerView.frame = attributes.messageContainerFrame
//        }
//    }
//
//    open func configure(with message: MessageType, at indexPath: IndexPath, and messagesCollectionView: MessagesCollectionView) {
//        guard let dataSource = messagesCollectionView.messagesDataSource else {
//            fatalError(MessageKitError.nilMessagesDataSource)
//        }
//        guard let displayDelegate = messagesCollectionView.messagesDisplayDelegate else {
//            fatalError(MessageKitError.nilMessagesDisplayDelegate)
//        }
//
//        delegate = messagesCollectionView.messageCellDelegate
//
//        let messageColor = displayDelegate.backgroundColor(for: message, at: indexPath, in: messagesCollectionView)
//        let messageStyle = displayDelegate.messageStyle(for: message, at: indexPath, in: messagesCollectionView)
//
//        displayDelegate.configureAvatarView(avatarView, for: message, at: indexPath, in: messagesCollectionView)
//
//        messageContainerView.backgroundColor = messageColor
//        messageContainerView.style = messageStyle
//
//        let topText = dataSource.cellTopLabelAttributedText(for: message, at: indexPath)
//        let bottomText = dataSource.cellBottomLabelAttributedText(for: message, at: indexPath)
//        let sideBottomText = dataSource.cellSideBottomLabelAttributedText(for: message, at: indexPath)
//        let timeText = dataSource.cellTimeLabelAttributedText(for: message, at: indexPath)
//        let buttonImages = dataSource.cellFavoriteButtonImages(for: message, at: indexPath)
//
//        cellTopLabel.attributedText = topText
//        cellBottomLabel.attributedText = bottomText
//        //osuzuki
//        cellSideBottomLabel.attributedText = sideBottomText
//        cellTimeLabel.attributedText = timeText
//        if let buttonImages = buttonImages {
//            if buttonImages.count == 2 {
//                cellFavoriteButton.setImage(buttonImages[0], for: .normal)
//                cellFavoriteButton.setImage(buttonImages[1], for: .selected)
//            } else if buttonImages.count > 2 {
//                cellFavoriteButton.setImage(buttonImages[0], for: .normal)
//                cellFavoriteButton.setImage(buttonImages[1], for: .highlighted)
//                cellFavoriteButton.setImage(buttonImages[2], for: .selected)
//            }
//            cellFavoriteButton.addTarget(self, action: #selector(MessageCollectionViewCell.didPushFavoriteButton(sender:)), for: .touchUpInside)
//            cellFavoriteButton.isSelected = dataSource.cellIsFavorite(for: message, at: indexPath)
//        }
//    }
//
//    @objc func didPushFavoriteButton(sender: UIButton) {
//        delegate?.didPushFavoriteButton(in: self, button: sender)
//    }
//
//    /// Handle tap gesture on contentView and its subviews like messageContainerView, cellTopLabel, cellBottomLabel, avatarView ....
//    open func handleTapGesture(_ gesture: UIGestureRecognizer) {
//        let touchLocation = gesture.location(in: self)
//
//        switch true {
//        case messageContainerView.frame.contains(touchLocation) && !cellContentView(canHandle: convert(touchLocation, to: messageContainerView)):
//            delegate?.didTapMessage(in: self)
//        case avatarView.frame.contains(touchLocation):
//            delegate?.didTapAvatar(in: self)
//        case cellTopLabel.frame.contains(touchLocation):
//            delegate?.didTapTopLabel(in: self)
//        case cellBottomLabel.frame.contains(touchLocation):
//            delegate?.didTapBottomLabel(in: self)
//        default:
//            break
//        }
//    }
//
//    /// Handle long press gesture, return true when gestureRecognizer's touch point in `messageContainerView`'s frame
//    open override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
//        let touchPoint = gestureRecognizer.location(in: self)
//        guard gestureRecognizer.isKind(of: UILongPressGestureRecognizer.self) else { return false }
//        return messageContainerView.frame.contains(touchPoint)
//    }
//
//    /// Handle `ContentView`'s tap gesture, return false when `ContentView` doesn't needs to handle gesture
//    open func cellContentView(canHandle touchPoint: CGPoint) -> Bool {
//        return false
//    }
//=======
//>>>>>>> msg/development
}
