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
    
    static let size = CGSize(width: 260, height: 80)
    
    static let nameFont = UIFont.boldSystemFont(ofSize: 13)
    private let kOffsetX: CGFloat = 4
    private let kIcX: CGFloat = 16
    private let kIcW: CGFloat = 26
    private let icY: CGFloat = 10
    private let icH: CGFloat = 26
    private let kNameBaseH: CGFloat = 18
    
    open lazy var iconImageView: UIImageView = {
        let iconImageView = UIImageView()
        iconImageView.frame = CGRect(x: kIcX, y: icY, width: kIcW, height: icH)
        return iconImageView
    }()
    
    open lazy var fileNameLabel: UILabel = {
        let nameX: CGFloat = kIcX + kIcW + kOffsetX
        let nameY: CGFloat = 14
        let nameH: CGFloat = kNameBaseH
        let fileNameLabel = UILabel(frame: CGRect(x: nameX, y: nameY, width: nameLabelWidth(), height: nameH))
        fileNameLabel.textColor = UIColor.black
        fileNameLabel.textAlignment = .left
        fileNameLabel.font = FileMessageCell.nameFont
        fileNameLabel.numberOfLines = 2
        fileNameLabel.adjustsFontSizeToFitWidth = true
        fileNameLabel.minimumScaleFactor = 0.4
        return fileNameLabel
    }()
    
    open lazy var expireLabel: UILabel = {
        let nameX: CGFloat = kIcX + kIcW + kOffsetX
        let nameY: CGFloat = 14
        let nameH: CGFloat = kNameBaseH
        let offsetLabelY: CGFloat = 4
        let expireH: CGFloat = 14
        let expireFont: UIFont = UIFont.boldSystemFont(ofSize: 11)
        let expireY: CGFloat = nameY + nameH + offsetLabelY
        let expireLabel = UILabel(frame: CGRect(x: nameX, y: expireY, width: nameLabelWidth(), height: expireH))
        expireLabel.textColor = UIColor.darkGray
        expireLabel.textAlignment = .left
        expireLabel.font = UIFont.boldSystemFont(ofSize: 11)
        return expireLabel
    }()
    
    open lazy var sizeLabel: UILabel = {
        let nameX: CGFloat = kIcX + kIcW + kOffsetX
        let nameY: CGFloat = 14
        let nameH: CGFloat = kNameBaseH
        let offsetLabelY: CGFloat = 4
        let expireH: CGFloat = 14
        let expireFont: UIFont = UIFont.boldSystemFont(ofSize: 11)
        let expireY: CGFloat = nameY + nameH + offsetLabelY
        let sizeY: CGFloat = expireY + expireH + offsetLabelY
        let sizeLabel = UILabel(frame: CGRect(x: nameX, y: sizeY, width: nameLabelWidth(), height: expireH))
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
        arrowImageView.frame = CGRect(x: FileMessageCell.size.width - arrowW - 10,
                                      y: FileMessageCell.size.height/2 - arrowH/2, //TODO:fix make dynamic height
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
        setupConstraints()
    }
    
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "MM/dd HH:mm"
        return dateFormatter
    }()
    
    override func configure(with message: MessageType, at indexPath: IndexPath, and messagesCollectionView: MessagesCollectionView) {
        super.configure(with: message, at: indexPath, and: messagesCollectionView)
        
        guard let _ = messagesCollectionView.messagesDisplayDelegate else {
            fatalError("displayDelegate not found")
        }
        
        switch message.kind {
        case .custom(let item):
            if let item = item as? FileMediaItem {
                
                iconImageView.image = iconImage(contenTypeRawValue: item.contentType)
                fileNameLabel.text = item.fileName ?? ""
                
                if let expireDate = item.expireDate {
                    expireLabel.text = "有効期限 : 〜" + dateFormatter.string(from: expireDate)
                } else {
                    expireLabel.text = "有効期限 : "
                }
                sizeLabel.text = "サイズ : " + fileSizeString(fileSize: item.fileSize)
            }
        default:
            break
        }
        
    }
    
    private func fileSizeString(fileSize: UInt?) -> String {
        if let fileSize = fileSize {
            if fileSize < 1000 {
                return "\(fileSize) Byte"
            } else if fileSize < 1_000_000 {
                return NSString(format:"%.2f kB",CGFloat(fileSize)/1_000) as String
            } else if fileSize < 1_000_000_000 {
                return NSString(format:"%.2f MB",CGFloat(fileSize)/1_000_000) as String
            } else {
                return "Too Large"
            }
        } else {
            return ""
        }
    }
    
    func mediaViewDisplaySize(item: FileMediaItem) -> CGSize {
        //        Log.d("HEIGHT_MEDIA:(\(self.fileName ?? "")):\(nameBaseLabelHeightToEstimate())")
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
    
    private func iconImage(contenTypeRawValue: Int) -> UIImage {
    
        if contenTypeRawValue == ContentType.excel.rawValue {
            return #imageLiteral(resourceName: "ic_xls")
        } else if contenTypeRawValue == ContentType.word.rawValue {
            return #imageLiteral(resourceName: "ic_doc")
        } else if contenTypeRawValue == ContentType.powerpoint.rawValue {
            return #imageLiteral(resourceName: "ic_ppt")
        } else if contenTypeRawValue == ContentType.pdf.rawValue {
            return #imageLiteral(resourceName: "ic_pdf")
        } else {
            return #imageLiteral(resourceName: "ic_file")
        }
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
