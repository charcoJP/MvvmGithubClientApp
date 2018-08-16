//
//  UserCellViewModel.swift
//  MvvmGithubClientApp
//
//  Created by user on 2018/08/16.
//  Copyright © 2018年 user. All rights reserved.
//

import Foundation
import UIKit

enum ImageDownloadProgress {
    case loading(UIImage)
    case finish(UIImage)
    case error
}

final class UserCellViewModel {
    
    private var user: User
    
    private let imageDownloader = ImageDownloader()
    
    private var isLoading = false
    
    var nickName: String {
        return user.name
    }
    
    var webUrl: URL {
        return URL(string: user.webUrl)!
    }
    
    init(user: User) {
        self.user = user
    }
    
    func downloadImage(progress: @escaping (ImageDownloadProgress) -> Void) {
        if isLoading == true {
            return
        }
        isLoading = true

        let loadingImage = UIImage(color: .gray, size: CGSize(width: 45, height: 45))!
        
        progress(.loading(loadingImage))
        
        imageDownloader.downloadImage(imageUrl: user.iconUrl,
                                      success: { (image) in
                                        progress(.finish(image))
                                        self.isLoading = false
        }) { (error) in
            progress(.error)
            self.isLoading = false
        }
    }
}

extension UIImage {
    convenience init?(color: UIColor, size: CGSize) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else {
            return nil
        }
        
        self.init(cgImage: cgImage)
    }
}
