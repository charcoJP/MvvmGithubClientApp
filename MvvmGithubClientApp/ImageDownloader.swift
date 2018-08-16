//
//  ImageDownloader.swift
//  MvvmGithubClientApp
//
//  Created by user on 2018/08/16.
//  Copyright © 2018年 user. All rights reserved.
//

import Foundation
import UIKit

final class ImageDownloader {
    var cacheImage: UIImage?
    
    func downloadImage(imageUrl: String,
                       success: @escaping (UIImage) -> Void,
                       failure: @escaping (Error) -> Void) {
        
        // キャッシュがあればそれを返す
        if let cacheImage = cacheImage {
            success(cacheImage)
        }
        
        var request = URLRequest(url: URL(string: imageUrl)!)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request)
        { (data, response, error) in
            if let error = error {
                DispatchQueue.main.async {
                    failure(error)
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    failure(APIError.unknown)
                }
                return
            }
            
            guard let imageFromData = UIImage(data: data) else {
                DispatchQueue.main.async {
                    failure(APIError.unknown)
                }
                return
            }
            
            DispatchQueue.main.async {
                success(imageFromData)
            }
            
            // 画像をキャッシュする
            self.cacheImage = imageFromData
        }
        
        task.resume()
    }
}

