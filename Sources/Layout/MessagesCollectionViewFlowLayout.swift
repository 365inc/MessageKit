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
import AVFoundation

/// The layout object used by `MessagesCollectionView` to determine the size of all
/// framework provided `MessageCollectionViewCell` subclasses.
open class MessagesCollectionViewFlowLayout: UICollectionViewFlowLayout {

    open override class var layoutAttributesClass: AnyClass {
        return MessagesCollectionViewLayoutAttributes.self
    }
    
    /** The `MessagesCollectionView` that owns this layout object. */
    public var messagesCollectionView: MessagesCollectionView {
        guard let messagesCollectionView = collectionView as? MessagesCollectionView else {
            fatalError(MessageKitError.layoutUsedOnForeignType)
        }
        return messagesCollectionView
    }
    
    /** The `MessagesDataSource` for the layout's collection view. */
    public var messagesDataSource: MessagesDataSource {
        guard let messagesDataSource = messagesCollectionView.messagesDataSource else {
            fatalError(MessageKitError.nilMessagesDataSource)
        }
        return messagesDataSource
    }
    
    /** The `MessagesLayoutDelegate` for the layout's collection view. */
    public var messagesLayoutDelegate: MessagesLayoutDelegate {
        guard let messagesLayoutDelegate = messagesCollectionView.messagesLayoutDelegate else {
            fatalError(MessageKitError.nilMessagesLayoutDelegate)
        }
        return messagesLayoutDelegate
    }

    public var itemWidth: CGFloat {
        guard let collectionView = collectionView else { return 0 }
        return collectionView.frame.width - sectionInset.left - sectionInset.right
    }

    // MARK: - Initializers

    public override init() {
        super.init()

        sectionInset = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)

        NotificationCenter.default.addObserver(self, selector: #selector(MessagesCollectionViewFlowLayout.handleOrientationChange(_:)), name: .UIDeviceOrientationDidChange, object: nil)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: - Attributes

    open override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attributesArray = super.layoutAttributesForElements(in: rect) as? [MessagesCollectionViewLayoutAttributes] else {
            return nil
        }
        for attributes in attributesArray where attributes.representedElementCategory == .cell {
            let cellSizeCalculator = cellSizeCalculatorForItem(at: attributes.indexPath)
            cellSizeCalculator.configure(attributes: attributes)
        }
        return attributesArray
    }

    open override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let attributes = super.layoutAttributesForItem(at: indexPath) as? MessagesCollectionViewLayoutAttributes else {
            return nil
        }
        if attributes.representedElementCategory == .cell {
            let cellSizeCalculator = cellSizeCalculatorForItem(at: attributes.indexPath)
            cellSizeCalculator.configure(attributes: attributes)
        }
//<<<<<<< HEAD
        
//    }
//
//    /// Returns newly created `MessageIntermediateAttributes` for a given `MessageType` and `IndexPath`.
//    ///
//    /// - Parameters:
//    ///   - message: The `MessageType` representing the attributes.
//    ///   - indexPath: The current `IndexPath` of the `MessageCollectionViewCell`.
//    func createMessageIntermediateLayoutAttributes(for message: MessageType, at indexPath: IndexPath) -> MessageIntermediateLayoutAttributes {
//
//        let attributes = MessageIntermediateLayoutAttributes(message: message, indexPath: indexPath)
//
//        // None of these are dependent on other attributes
//        attributes.avatarPosition = avatarPosition(for: attributes)
//        attributes.avatarSize = avatarSize(for: attributes)
//        attributes.messageContainerPadding = messageContainerPadding(for: attributes)
//        attributes.messageLabelInsets = messageLabelInsets(for: attributes)
//
//        // MessageContainerView
//        attributes.messageContainerMaxWidth = messageContainerMaxWidth(for: attributes)
//        attributes.messageContainerSize = messageContainerSize(for: attributes)
//
//        // Cell Bottom Label
//        attributes.bottomLabelAlignment = cellBottomLabelAlignment(for: attributes)
//        attributes.bottomLabelMaxWidth = cellBottomLabelMaxWidth(for: attributes)
//        attributes.bottomLabelSize = cellBottomLabelSize(for: attributes)
//
//        //osuzuki
//        // Cell Side Bottom Label
//        attributes.sideBottomLabelAlignment = cellSideBottomLabelAlignment(for: attributes)
//        attributes.sideBottomLabelMaxWidth = cellSideBottomLabelMaxWidth(for: attributes)
//        attributes.sideBottomLabelSize = cellSideBottomLabelSize(for: attributes)
//
//        //osuzuki
//        // Cell Time Label
//        attributes.timeLabelAlignment = cellTimeLabelAlignment(for: attributes)
//        attributes.timeLabelMaxWidth = cellTimeLabelMaxWidth(for: attributes)
//        attributes.timeLabelSize = cellTimeLabelSize(for: attributes)
//
//        //osuzuki
//        // Favorite Button
//        attributes.favoriteButtonAlignment = cellFavoriteButtonAlignment(for: attributes)
//        attributes.favoriteButtonMaxWidth = cellFavoriteButtonMaxWidth(for: attributes)
//        attributes.favoriteButtonSize = cellFavoriteButtonSize(for: attributes)
//
//        // Cell Top Label
//        attributes.topLabelAlignment = cellTopLabelAlignment(for: attributes)
//        attributes.topLabelMaxWidth = cellTopLabelMaxWidth(for: attributes)
//        attributes.topLabelSize = cellTopLabelSize(for: attributes)
//
//        // Cell Height
//        attributes.itemHeight = cellHeight(for: attributes)
//
//        return attributes
//    }
//
//    /// Configures the `MessagesCollectionViewLayoutAttributes` by applying the layout information
//    /// from `MessageIntermediateLayoutAttributes` and calculating the origins of the cell's contents.
//    ///
//    /// - Parameters:
//    ///   - attributes: The `MessageCollectionViewLayoutAttributes` to apply the layout information to.
//    private func configure(attributes: MessagesCollectionViewLayoutAttributes) {
//
//        let intermediateAttributes = messageIntermediateLayoutAttributes(for: attributes.indexPath)
//
//        intermediateAttributes.cellFrame = attributes.frame
//
//        attributes.messageContainerFrame = intermediateAttributes.messageContainerFrame
//        attributes.topLabelFrame = intermediateAttributes.topLabelFrame
//        attributes.bottomLabelFrame = intermediateAttributes.bottomLabelFrame
//        attributes.sideBottomLabelFrame = intermediateAttributes.sideBottomLabelFrame//osuzuki
//        attributes.timeLabelFrame = intermediateAttributes.timeLabelFrame//osuzuki
//        attributes.favoriteButtonFrame = intermediateAttributes.favoriteButtonFrame//osuzuki
//        attributes.avatarFrame = intermediateAttributes.avatarFrame
//        attributes.messageLabelInsets = intermediateAttributes.messageLabelInsets
//
//        switch intermediateAttributes.message.data {
//        case .emoji:
//            attributes.messageLabelFont = emojiLabelFont
//        case .text:
//            attributes.messageLabelFont = messageLabelFont
//        case .attributedText(let text):
//            guard !text.string.isEmpty else { return }
//            guard let font = text.attribute(.font, at: 0, effectiveRange: nil) as? UIFont else { return }
//            attributes.messageLabelFont = font
//        default:
//            break
//        }
//
//    }
//
//}
//
//// MARK: - Avatar Calculations [ A - C ]
//
//fileprivate extension MessagesCollectionViewFlowLayout {
//
//    // A
//
//    /// Returns the `AvatarPosition` for a given `MessageType`.
//    ///
//    /// - Parameters:
//    ///   - attributes: The `MessageIntermediateLayoutAttributes` containing the `MessageType` object.
//    func avatarPosition(for attributes: MessageIntermediateLayoutAttributes) -> AvatarPosition {
//        var position = messagesLayoutDelegate.avatarPosition(for: attributes.message, at: attributes.indexPath, in: messagesCollectionView)
//
//        switch position.horizontal {
//        case .cellTrailing, .cellLeading:
//            break
//        case .natural:
//            position.horizontal = messagesDataSource.isFromCurrentSender(message: attributes.message) ? .cellTrailing : .cellLeading
//        }
//
//        return position
//    }
//
//    // B
//
//    /// Returns the size of the `AvatarView` for a given `MessageType`.
//    ///
//    /// - Parameters:
//    ///   - attributes: The `MessageIntermediateLayoutAttributes` containing the `MessageType` object.
//    func avatarSize(for attributes: MessageIntermediateLayoutAttributes) -> CGSize {
//        return messagesLayoutDelegate.avatarSize(for: attributes.message, at: attributes.indexPath, in: messagesCollectionView)
//    }
//
//}
//
//// MARK: - General Label Size Calculations
//
//private extension MessagesCollectionViewFlowLayout {
//
//    /// Returns the size required fit a NSAttributedString considering a constrained max width.
//    ///
//    /// - Parameters:
//    ///   - attributedText: The `NSAttributedString` used to calculate a size that fits.
//    ///   - maxWidth: The max width available for the label.
//    func labelSize(for attributedText: NSAttributedString, considering maxWidth: CGFloat) -> CGSize {
//
//        let estimatedHeight = attributedText.height(considering: maxWidth)
//        let estimatedWidth = attributedText.width(considering: estimatedHeight)
//
//        let finalHeight = estimatedHeight.rounded(.up)
//        let finalWidth = estimatedWidth > maxWidth ? maxWidth : estimatedWidth.rounded(.up)
//
//        return CGSize(width: finalWidth, height: finalHeight)
//    }
//
//    /// Returns the size required to fit a String considering a constrained max width.
//    ///
//    /// - Parameters:
//    ///   - text: The `String` used to calculate a size that fits.
//    ///   - maxWidth: The max width available for the label.
//    func labelSize(for text: String, considering maxWidth: CGFloat, and font: UIFont) -> CGSize {
//
//        let estimatedHeight = text.height(considering: maxWidth, and: font)
//        let estimatedWidth = text.width(considering: estimatedHeight, and: font)
//
//        let finalHeight = estimatedHeight.rounded(.up)
//        let finalWidth = estimatedWidth > maxWidth ? maxWidth : estimatedWidth.rounded(.up)
//
//        return CGSize(width: finalWidth, height: finalHeight)
//    }
//
//}
//
//// MARK: - MessageContainerView Calculations [ D - G ]
//
//private extension MessagesCollectionViewFlowLayout {
//
//    // D
//
//    /// Returns the padding to be used around the `MessageContainerView` for a given `MessageType`.
//    ///
//    /// - Parameters:
//    ///   - attributes: The `MessageIntermediateLayoutAttributes` containing the `MessageType` object.
//    func messageContainerPadding(for attributes: MessageIntermediateLayoutAttributes) -> UIEdgeInsets {
//        return messagesLayoutDelegate.messagePadding(for: attributes.message, at: attributes.indexPath, in: messagesCollectionView)
//    }
//
//    // E
//
//    /// Returns the insets for the text of a `MessageLabel` in ` TextMessageCell`.
//    ///
//    /// - Parameters:
//    ///   - attributes: The `MessageIntermediateLayoutAttributes` containing the `MessageType` object.
//    func messageLabelInsets(for attributes: MessageIntermediateLayoutAttributes) -> UIEdgeInsets {
//        // Maybe check the message type here since insets only apply to text messages
//        return messagesLayoutDelegate.messageLabelInset(for: attributes.message, at: attributes.indexPath, in: messagesCollectionView)
//    }
//
//    // F
//
//    /// Returns the max available width for the `MessageContainerView`.
//    ///
//    /// - Parameters:
//    ///   - attributes: The `MessageIntermediateLayoutAttributes` to consider when calculating the max width.
//    func messageContainerMaxWidth(for attributes: MessageIntermediateLayoutAttributes) -> CGFloat {
//
//        switch attributes.message.data {
//        case .text, .attributedText:
//            return itemWidth - attributes.avatarSize.width - attributes.messageHorizontalPadding - attributes.messageLabelHorizontalInsets
//        default:
//            return itemWidth - attributes.avatarSize.width - attributes.messageHorizontalPadding
//        }
//
//    }
//
//    // G
//
//    /// Returns the size of the `MessageContainerView`
//    ///
//    /// - Parameters:
//    ///   - attributes: The `MessageIntermediateLayoutAttributes` to consider when calculating the `MessageContainerView` size.
//    func messageContainerSize(for attributes: MessageIntermediateLayoutAttributes) -> CGSize {
//
//        let message = attributes.message
//        let indexPath = attributes.indexPath
//        let maxWidth = attributes.messageContainerMaxWidth
//
//        var messageContainerSize: CGSize = .zero
//
//        switch attributes.message.data {
//        case .text(let text):
//            messageContainerSize = labelSize(for: text, considering: maxWidth, and: messageLabelFont)
//            messageContainerSize.width += attributes.messageLabelHorizontalInsets
//            messageContainerSize.height += attributes.messageLabelVerticalInsets
//        case .attributedText(let text):
//            messageContainerSize = labelSize(for: text, considering: maxWidth)
//            messageContainerSize.width += attributes.messageLabelHorizontalInsets
//            messageContainerSize.height += attributes.messageLabelVerticalInsets
//        case .emoji(let text):
//            messageContainerSize = labelSize(for: text, considering: maxWidth, and: emojiLabelFont)
//            messageContainerSize.width += attributes.messageLabelHorizontalInsets
//            messageContainerSize.height += attributes.messageLabelVerticalInsets
//        case .photo, .video:
//            let width = messagesLayoutDelegate.widthForMedia(message: message, at: indexPath, with: maxWidth, in: messagesCollectionView)
//            let height = messagesLayoutDelegate.heightForMedia(message: message, at: indexPath, with: maxWidth, in: messagesCollectionView)
//            messageContainerSize = CGSize(width: width, height: height)
//        case .location:
//            let width = messagesLayoutDelegate.widthForLocation(message: message, at: indexPath, with: maxWidth, in: messagesCollectionView)
//            let height = messagesLayoutDelegate.heightForLocation(message: message, at: indexPath, with: maxWidth, in: messagesCollectionView)
//            messageContainerSize = CGSize(width: width, height: height)
//        }
//
//        return messageContainerSize
//
//    }
//
//}
//=======
        return attributes
    }
//>>>>>>> msg/development

    // MARK: - Layout Invalidation

    open override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return collectionView?.bounds.width != newBounds.width
    }

    open override func invalidationContext(forBoundsChange newBounds: CGRect) -> UICollectionViewLayoutInvalidationContext {
        let context = super.invalidationContext(forBoundsChange: newBounds)
        guard let flowLayoutContext = context as? UICollectionViewFlowLayoutInvalidationContext else { return context }
        flowLayoutContext.invalidateFlowLayoutDelegateMetrics = shouldInvalidateLayout(forBoundsChange: newBounds)
        return flowLayoutContext
    }

//<<<<<<< HEAD
//}
//
//
////osuzuki
//// MARK: - Cell Side Bottom Label Calculations  [ ZZ - ZZ ]
//
//private extension MessagesCollectionViewFlowLayout {
//
//    // ZZ
//
//    /// Returns the alignment of the cell's bottom label.
//    ///
//    /// - Parameters:
//    ///   - attributes: The `MessageIntermediateLayoutAttributes` containing the `MessageType` object.
//    func cellSideBottomLabelAlignment(for attributes: MessageIntermediateLayoutAttributes) -> LabelAlignment {
//        return messagesLayoutDelegate.cellSideBottomLabelAlignment(for: attributes.message, at: attributes.indexPath, in: messagesCollectionView)
//    }
//
//    // ZZ
//
//    /// Returns the max available width for the cell's bottom label considering the specified layout information.
//    ///
//    /// - Parameters:
//    ///   - attributes: The `MessageIntermediateLayoutAttributes` to consider when calculating the max width.
//    func cellSideBottomLabelMaxWidth(for attributes: MessageIntermediateLayoutAttributes) -> CGFloat {
//        return 44
//    }
//
//    // ZZ
//
//    /// Returns the size of the cell's bottom label considering the specified layout information.
//    ///
//    /// - Parameters:
//    ///   - attributes: The `MessageIntermediateLayoutAttributes` to consider when calculating label's size.
//    func cellSideBottomLabelSize(for attributes: MessageIntermediateLayoutAttributes) -> CGSize {
//
//        let text = messagesDataSource.cellSideBottomLabelAttributedText(for: attributes.message, at: attributes.indexPath)
//
//        guard let bottomLabelText = text else { return .zero }
//        return labelSize(for: bottomLabelText, considering: attributes.sideBottomLabelMaxWidth)
//    }
//
//}
//
//
////osuzuki
//// MARK: - Cell Time Label Calculations  [ ZZ - ZZ ]
//
//private extension MessagesCollectionViewFlowLayout {
//
//    // ZZ
//
//    /// Returns the alignment of the cell's bottom label.
//    ///
//    /// - Parameters:
//    ///   - attributes: The `MessageIntermediateLayoutAttributes` containing the `MessageType` object.
//    func cellTimeLabelAlignment(for attributes: MessageIntermediateLayoutAttributes) -> LabelAlignment {
//        return messagesLayoutDelegate.cellTimeLabelAlignment(for: attributes.message, at: attributes.indexPath, in: messagesCollectionView)
//    }
//
//    // ZZ
//
//    /// Returns the max available width for the cell's bottom label considering the specified layout information.
//    ///
//    /// - Parameters:
//    ///   - attributes: The `MessageIntermediateLayoutAttributes` to consider when calculating the max width.
//    func cellTimeLabelMaxWidth(for attributes: MessageIntermediateLayoutAttributes) -> CGFloat {
//        return 44
//    }
//
//    // ZZ
//
//    /// Returns the size of the cell's bottom label considering the specified layout information.
//    ///
//    /// - Parameters:
//    ///   - attributes: The `MessageIntermediateLayoutAttributes` to consider when calculating label's size.
//    func cellTimeLabelSize(for attributes: MessageIntermediateLayoutAttributes) -> CGSize {
//
//        let text = messagesDataSource.cellTimeLabelAttributedText(for: attributes.message, at: attributes.indexPath)
//
//        guard let bottomLabelText = text else { return .zero }
//        return labelSize(for: bottomLabelText, considering: attributes.timeLabelMaxWidth)
//    }
//}
//
////osuzuki
//// MARK: - Cell Favorite Button Calculations  [ ZZ - ZZ ]
//
//private extension MessagesCollectionViewFlowLayout {
//
//    // ZZ
//
//    /// Returns the alignment of the cell's favorite button.
//    ///
//    /// - Parameters:
//    ///   - attributes: The `MessageIntermediateLayoutAttributes` containing the `MessageType` object.
//    func cellFavoriteButtonAlignment(for attributes: MessageIntermediateLayoutAttributes) -> LabelAlignment {
//        return messagesLayoutDelegate.cellFavoriteButtonAlignment(for: attributes.message, at: attributes.indexPath, in: messagesCollectionView)
//    }
//
//    // ZZ
//
//    /// Returns the max available width for the cell's favorite button
//    ///
//    /// - Parameters:
//    ///   - attributes: The `MessageIntermediateLayoutAttributes` to consider when calculating the max width.
//    func cellFavoriteButtonMaxWidth(for attributes: MessageIntermediateLayoutAttributes) -> CGFloat {
//        return 44
//    }
//
//    // ZZ
//
//    /// Returns the size of the cell's favorite button
//    ///
//    /// - Parameters:
//    ///   - attributes: The `MessageIntermediateLayoutAttributes` to consider when calculating label's size.
//    func cellFavoriteButtonSize(for attributes: MessageIntermediateLayoutAttributes) -> CGSize {
//        return CGSize(width: 24, height: 24)
//    }
//}
//
//// MARK: - Cell Top Label Size Calculations [ L - N ]
//
//private extension MessagesCollectionViewFlowLayout {
//
//    // L
//
//    /// Returns the alignment of the cell's top label.
//    ///
//    /// - Parameters:
//    ///   - attributes: The `MessageIntermediateLayoutAttributes` containing the `MessageType` object.
//    func cellTopLabelAlignment(for attributes: MessageIntermediateLayoutAttributes) -> LabelAlignment {
//        return messagesLayoutDelegate.cellTopLabelAlignment(for: attributes.message, at: attributes.indexPath, in: messagesCollectionView)
//=======
    @objc
    private func handleOrientationChange(_ notification: Notification) {
        invalidateLayout()
//>>>>>>> msg/development
    }

    // MARK: - Cell Sizing

    lazy open var textMessageSizeCalculator = TextMessageSizeCalculator(layout: self)
    lazy open var attributedTextMessageSizeCalculator = TextMessageSizeCalculator(layout: self)
    lazy open var emojiMessageSizeCalculator = TextMessageSizeCalculator(layout: self)
    lazy open var photoMessageSizeCalculator = MediaMessageSizeCalculator(layout: self)
    lazy open var videoMessageSizeCalculator = MediaMessageSizeCalculator(layout: self)
    lazy open var locationMessageSizeCalculator = LocationMessageSizeCalculator(layout: self)

    open func cellSizeCalculatorForItem(at indexPath: IndexPath) -> CellSizeCalculator {
        let message = messagesDataSource.messageForItem(at: indexPath, in: messagesCollectionView)
        switch message.kind {
        case .text:
            return textMessageSizeCalculator
        case .attributedText:
            return attributedTextMessageSizeCalculator
        case .emoji:
            return emojiMessageSizeCalculator
        case .photo:
            return photoMessageSizeCalculator
        case .video:
            return videoMessageSizeCalculator
        case .location:
            return locationMessageSizeCalculator
        case .custom:
            fatalError("Must return a CellSizeCalculator for MessageKind.custom(Any?)")
        }
    }

    open func sizeForItem(at indexPath: IndexPath) -> CGSize {
        let calculator = cellSizeCalculatorForItem(at: indexPath)
        return calculator.sizeForItem(at: indexPath)
    }
}
