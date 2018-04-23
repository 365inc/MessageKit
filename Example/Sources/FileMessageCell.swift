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
    
    private let kBaseMediaViewDisplaySize = CGSize(width: 240, height: 80)
    
    private let kNameFont = UIFont.boldSystemFont(ofSize: 13)
    private let kOffsetX: CGFloat = 4
    private let kIcX: CGFloat = 16
    private let kIcW: CGFloat = 26
    private let icY: CGFloat = 10
    private let icH: CGFloat = 26
    private let kNameBaseH: CGFloat = 18
    
    open lazy var iconImageView: UIImageView = {
        let iconImageView = UIImageView()
        iconImageView.image = iconImage()
        iconImageView.frame = CGRect(x: kIcX, y: icY, width: kIcW, height: icH)
        return iconImageView
    }()
    
    open lazy var fileNameLabel: UILabel = {
        let nameX: CGFloat = kIcX + kIcW + kOffsetX
        let nameY: CGFloat = 14
        let nameH: CGFloat = isBreakLine() ? kNameBaseH * 2 : kNameBaseH
        let fileNameLabel = UILabel(frame: CGRect(x: nameX, y: nameY, width: nameLabelWidth(), height: nameH))
        fileNameLabel.text = "ファイル名"//self.fileName ?? ""
        fileNameLabel.textColor = UIColor.black
        fileNameLabel.textAlignment = .left
        fileNameLabel.font = kNameFont
        fileNameLabel.numberOfLines = 2
        return fileNameLabel
    }()
    
    open lazy var expireLabel: UILabel = {
        let nameX: CGFloat = kIcX + kIcW + kOffsetX
        let nameY: CGFloat = 14
        let nameH: CGFloat = isBreakLine() ? kNameBaseH * 2 : kNameBaseH
        let offsetLabelY: CGFloat = 4
        let expireH: CGFloat = 14
        let expireFont: UIFont = UIFont.boldSystemFont(ofSize: 11)
        let expireY: CGFloat = nameY + nameH + offsetLabelY
        let expireLabel = UILabel(frame: CGRect(x: nameX, y: expireY, width: nameLabelWidth(), height: expireH))
        expireLabel.text = "有効期限 : 2018/3/4"
        expireLabel.textColor = UIColor.darkGray
        expireLabel.textAlignment = .left
        expireLabel.font = UIFont.boldSystemFont(ofSize: 11)
        return expireLabel
    }()
    
    open lazy var sizeLabel: UILabel = {
        let nameX: CGFloat = kIcX + kIcW + kOffsetX
        let nameY: CGFloat = 14
        let nameH: CGFloat = isBreakLine() ? kNameBaseH * 2 : kNameBaseH
        let offsetLabelY: CGFloat = 4
        let expireH: CGFloat = 14
        let expireFont: UIFont = UIFont.boldSystemFont(ofSize: 11)
        let expireY: CGFloat = nameY + nameH + offsetLabelY
        let sizeY: CGFloat = expireY + expireH + offsetLabelY
        let sizeLabel = UILabel(frame: CGRect(x: nameX, y: sizeY, width: nameLabelWidth(), height: expireH))
        sizeLabel.text = "サイズ : 100.86kB"
        sizeLabel.textColor = UIColor.darkGray
        sizeLabel.textAlignment = .left
        sizeLabel.font = expireFont
        return sizeLabel
    }()
    
    open lazy var arrowImageView: UIImageView = {
        let arrowImage = #imageLiteral(resourceName: "ic_arrow")
        let arrowImageView = UIImageView(image: arrowImage)
        let arrowW = arrowImage.size.width
        let arrowH = arrowImage.size.height
        arrowImageView.frame = CGRect(x: self.mediaViewDisplaySize().width - arrowW - 10,
                                      y: self.mediaViewDisplaySize().height/2 - arrowH/2,
                                      width: arrowW, height: arrowH)
        return arrowImageView
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
        messageContainerView.addSubview(iconImageView)
        messageContainerView.addSubview(fileNameLabel)
        messageContainerView.addSubview(expireLabel)
        messageContainerView.addSubview(sizeLabel)
        messageContainerView.addSubview(arrowImageView)
        
//        messageContainerView.addSubview(imageView)
//        messageContainerView.addSubview(playButtonView)
        setupConstraints()
    }
    
    override func configure(with message: MessageType, at indexPath: IndexPath, and messagesCollectionView: MessagesCollectionView) {
        super.configure(with: message, at: indexPath, and: messagesCollectionView)
        
        guard let _ = messagesCollectionView.messagesDisplayDelegate else {
            fatalError("displayDelegate not found")
        }
        
        switch message.kind {
        case .custom(let item):
            if let item = item as? FileMediaItem {
                print(item.fileData ?? "fileData is nil")
            }
        
            //TODO: Add custom imageview
//            imageView.image = mediaItem.image ?? mediaItem.placeholderImage
//            playButtonView.isHidden = true
        default:
            break
        }
        
    }
    
    func mediaViewDisplaySize() -> CGSize {
        //        Log.d("HEIGHT_MEDIA:(\(self.fileName ?? "")):\(nameBaseLabelHeightToEstimate())")
        let baseH: CGFloat = isBreakLine() ? kBaseMediaViewDisplaySize.height + kNameBaseH : kBaseMediaViewDisplaySize.height
        
        return CGSize(width: kBaseMediaViewDisplaySize.width, height: baseH)
    }
    
//    private func createMediaView() {
//        let icY: CGFloat = 10
//        let icH: CGFloat = 26
//
//        let nameH: CGFloat = isBreakLine() ? kNameBaseH * 2 : kNameBaseH
//
//        let baseView = UIView(frame: CGRect(x: 0, y: 0, width: kBaseMediaViewDisplaySize.width, height: mediaViewDisplaySize().height))
//        baseView.backgroundColor = isOutgoing ? UIColor.srg_chatBubbleOutgoingColor() : UIColor.srg_chatBubbleIncommingColor()
//        baseView.clipsToBounds = true
//
//        let iconImageView = UIImageView(image: self.iconImage())
//        iconImageView.frame = CGRect(x: kIcX, y: icY, width: kIcW, height: icH)
//        baseView.addSubview(iconImageView)
//
//        let nameX: CGFloat = kIcX + kIcW + kOffsetX
//        let nameY: CGFloat = 14
//
//        let fileNameLabel = UILabel(frame: CGRect(x: nameX, y: nameY, width: nameLabelWidth(), height: nameH))
//        fileNameLabel.text = self.fileName ?? ""
//        fileNameLabel.textColor = UIColor.black
//        fileNameLabel.textAlignment = .left
//        fileNameLabel.font = kNameFont
//        fileNameLabel.numberOfLines = 2
//        //        fileNameLabel.sizeToFit()
//        baseView.addSubview(fileNameLabel)
//
//        //有効期間
//        let offsetLabelY: CGFloat = 4
//        let expireH: CGFloat = 14
//        let expireFont: UIFont = UIFont.boldSystemFont(ofSize: 11)
//        let expireY: CGFloat = nameY + nameH + offsetLabelY
//        let expireLabel = UILabel(frame: CGRect(x: nameX, y: expireY, width: nameLabelWidth(), height: expireH))
//        if let expireDate = self.expireDate {
//            expireLabel.text = "有効期限 : 〜" + Date.dateTimeFromDate(expireDate)
//        } else {
//            expireLabel.text = "有効期限 : "
//        }
//        expireLabel.textColor = UIColor.darkGray
//        expireLabel.textAlignment = .left
//        expireLabel.font = expireFont
//        //        expireLabel.sizeToFit()
//        baseView.addSubview(expireLabel)
//
//        //サイズ
//        let sizeY: CGFloat = expireY + expireH + offsetLabelY
//        let sizeLabel = UILabel(frame: CGRect(x: nameX, y: sizeY, width: nameLabelWidth(), height: expireH))
//        sizeLabel.text = "サイズ : " + fileSizeString()
//        sizeLabel.textColor = UIColor.darkGray
//        sizeLabel.textAlignment = .left
//        sizeLabel.font = expireFont
//        //        sizeLabel.sizeToFit()
//        baseView.addSubview(sizeLabel)
//
//        //矢印(>)
//        let arrowImage = #imageLiteral(resourceName: "ic_arrow")
//        let arrowImageView = UIImageView(image: arrowImage)
//        let arrowW = arrowImage.size.width
//        let arrowH = arrowImage.size.height
//        arrowImageView.frame = CGRect(x: self.mediaViewDisplaySize().width - arrowW - 10,
//                                      y: self.mediaViewDisplaySize().height/2 - arrowH/2,
//                                      width: arrowW, height: arrowH)
//        baseView.addSubview(arrowImageView)
//
//        JSQMessagesMediaViewBubbleImageMasker.applyBubbleImageMask(toMediaView: baseView, isOutgoing: self.appliesMediaViewMaskAsOutgoing)
        
//        self.cachedMediaView = baseView
//    }
    
    private func nameBaseLabelHeightToEstimate() -> CGFloat {
        let nameHeight = heightForView(text: /*self.fileName ?? ""*/ "ファイル名!", font:kNameFont ,width: nameLabelWidth())
        return nameHeight
    }
    
    private func isBreakLine() -> Bool {
        return nameBaseLabelHeightToEstimate() > kNameBaseH
    }
    
    private func nameLabelWidth() -> CGFloat {
        return kBaseMediaViewDisplaySize.width - kIcW - kIcX - kOffsetX - 18
    }
    
    private func iconImage() -> UIImage {
        return #imageLiteral(resourceName: "ic_pdf")
//        if contentType == ContentType.excel.rawValue {
//            icon = #imageLiteral(resourceName: "ic_xls")
//        } else if contentType == ContentType.word.rawValue {
//            icon = #imageLiteral(resourceName: "ic_doc")
//        } else if contentType == ContentType.powerpoint.rawValue {
//            icon = #imageLiteral(resourceName: "ic_ppt")
//        } else if contentType == ContentType.pdf.rawValue {
//            icon = #imageLiteral(resourceName: "ic_pdf")
//        } else {
//            icon = #imageLiteral(resourceName: "ic_file")
//        }
//        return icon
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
