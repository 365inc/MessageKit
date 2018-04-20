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

/// An object that adopts the `MessagesDataSource` protocol is responsible for providing
/// the data required by a `MessagesCollectionView`.
public protocol MessagesDataSource: AnyObject {

    /// The `Sender` of new messages in the `MessagesCollectionView`.
    func currentSender() -> Sender

    /// A helper method to determine if a given message is from the current `Sender`.
    ///
    /// - Parameters:
    ///   - message: The message to check if it was sent by the current `Sender`.
    ///
    /// - Note:
    ///   The default implementation of this method checks for equality between
    ///   the message's `Sender` and the current `Sender`.
    func isFromCurrentSender(message: MessageType) -> Bool

    /// The message to be used for a `MessageCollectionViewCell` at the given `IndexPath`.
    ///
    /// - Parameters:
    ///   - indexPath: The `IndexPath` of the cell.
    ///   - messagesCollectionView: The `MessagesCollectionView` in which the message will be displayed.
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType

    /// The number of sections to be displayed in the `MessagesCollectionView`.
    ///
    /// - Parameters:
    ///   - messagesCollectionView: The `MessagesCollectionView` in which the messages will be displayed.
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int

    /// The number of cells to be displayed in the `MessagesCollectionView`.
    ///
    /// - Parameters:
    ///   - section: The number of the section in which the cells will be displayed.
    ///   - messagesCollectionView: The `MessagesCollectionView` in which the messages will be displayed.
    /// - Note:
    ///   The default implementation of this method returns 1. Putting each message in its own section.
    func numberOfItems(inSection section: Int, in messagesCollectionView: MessagesCollectionView) -> Int

    /// The attributed text to be used for cell's top label.
    ///
    /// - Parameters:
    ///   - message: The `MessageType` that will be displayed by this cell.
    ///   - indexPath: The `IndexPath` of the cell.
    ///   - messagesCollectionView: The `MessagesCollectionView` in which this cell will be displayed.
    ///
    /// The default value returned by this method is `nil`.
    func cellTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString?

    /// The attributed text to be used for cell's bottom label.
    ///
    /// - Parameters:
    ///   - message: The `MessageType` that will be displayed by this cell.
    ///   - indexPath: The `IndexPath` of the cell.
    ///   - messagesCollectionView: The `MessagesCollectionView` in which this cell will be displayed.
    ///
    /// The default value returned by this method is `nil`.
    func cellBottomLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString?
    
    
    //osuzuki
    /// The attributed text to be used for cell's side bottom label.
    func cellSideBottomLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString?
    
    //osuzuki
    /// The attributed text to be used for cell's time label.
    func cellTimeLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString?
    
    //osuzuki
    /// The favorite button images to be used for cell's favorite button
    func cellFavoriteButtonImages(for message: MessageType, at indexPath: IndexPath) -> [UIImage]?

    //osuzuki
    /// The favorite button selected flag to be used for cell's favorite button
    func cellIsFavorite(for message: MessageType, at indexPath: IndexPath) -> Bool
}

public extension MessagesDataSource {

    func isFromCurrentSender(message: MessageType) -> Bool {
        return message.sender == currentSender()
    }

    func numberOfItems(inSection section: Int, in messagesCollectionView: MessagesCollectionView) -> Int {
        return 1
    }

    func cellTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        return nil
    }

    func cellBottomLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        return nil
    }
    
    func cellSideBottomLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        return nil
    }
    
    func cellTimeLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        return nil
    }
    
    func cellFavoriteButtonImages(for message: MessageType, at indexPath: IndexPath) -> [UIImage]? {
        return nil
    }
    
    func cellIsFavorite(for message: MessageType, at indexPath: IndexPath) -> Bool {
        return false
    }

}
