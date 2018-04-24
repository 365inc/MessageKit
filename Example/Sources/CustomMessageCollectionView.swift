//
//  CustomMessageCollectionView.swift
//  ChatExample
//
//  Created by 鈴木治 on 2018/04/22.
//  Copyright © 2018年 MessageKit. All rights reserved.
//

import UIKit
import MessageKit

class CustomMessagesCollectionView: MessagesCollectionView {

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: CustomMessagesCollectionViewFlowLayout())
    }    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
