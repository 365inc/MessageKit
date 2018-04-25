//
//  MockFileMediaItem.swift
//  ChatExample
//
//  Created by 鈴木治 on 2018/04/23.
//  Copyright © 2018年 MessageKit. All rights reserved.
//

import UIKit
import MessageKit

struct FileMediaItem: MediaItem {
    
    var url: URL?
    var image: UIImage?
    var placeholderImage: UIImage
    var size: CGSize
    
    private(set) var fileData: Data?
    private(set) var fileName: String?
    private(set) var expireDate: Date?
    private(set) var fileSize: UInt?
    private(set) var isOutgoing: Bool = false
    private(set) var contentType: Int = ContentType.pdf.rawValue
    
    init() {
        self.size = CGSize(width: 240, height: 100)
        self.placeholderImage = UIImage()
        
        self.fileName = "プレジニア求人票_我妻良樹様2_180426.docx"//"プレジニア求人票_我妻良樹様2_180426.docx"
        self.expireDate = Date().addingTimeInterval(30000)
        self.fileSize = 123456
        self.contentType = ContentType.word.rawValue
        
    }
    
    
}

enum ContentType: Int {
    case text = 1
    case image = 2
    case movie = 3 //no-use
    case voice = 4 //no-use
    case location = 7 //no-use
    case sticker = 8 //no-use
    case tel = 10 //no-use
    case pdf = 11
    case word = 12
    case excel = 13
    case powerpoint = 14
    case otherfile = 15
}
