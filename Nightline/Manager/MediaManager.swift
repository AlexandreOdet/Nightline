//
//  MediaManager.swift
//  Nightline
//
//  Created by cedric moreaux on 11/07/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation
import UIKit
//import Cloudinary

class MediaManager {
    static let instance = MediaManager()

    let fileManager = FileManager.default
    let baseUrl : URL
//    let config: CLDConfiguration? = nil
//    let cloudinary: CLDCloudinary?

    init() {
        self.baseUrl = URL(fileURLWithPath: (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("media"))
        if !fileManager.fileExists(atPath: baseUrl.path) {
            try! fileManager.createDirectory(at: baseUrl, withIntermediateDirectories: true, attributes: nil)
        }
//        if let config = CLDConfiguration(cloudinaryUrl: "cloudinary://<781695568757174>:<gasFxenV90DIsNUH__7ELxgvbnk>@<nightline>") {
//        if let config = CLDConfiguration(cloudName: "nightline") {
//            cloudinary = CLDCloudinary(configuration: config)
//         } else {
//            print("Error during Cloudinary initialization")
//            cloudinary = nil
//        }
//        cloudinary = CLDCloudinary(url: "cloudinary://<781695568757174>:<gasFxenV90DIsNUH__7ELxgvbnk>@<nightline>")
    }

    func saveImage(bar_id: String, image: UIImage) {
        let destination = baseUrl.appendingPathComponent(bar_id)
        let imageName = "\(String(Date().timestamp)).jpg"
        let completeFileName = destination.appendingPathComponent(imageName)

        if !fileManager.fileExists(atPath: destination.path) {
            try! fileManager.createDirectory(at: destination, withIntermediateDirectories: true, attributes: nil)
        }
        let imageData = UIImageJPEGRepresentation(image, 0.5)
        fileManager.createFile(atPath: completeFileName.path, contents: imageData, attributes: nil)


//        if cloudinary != nil, let url = URL(string: completeFileName.path) {
//            let params = CLDUploadRequestParams()
//            params.setPublicId("/media/\(bar_id)/\(Date().timestamp)")
//            let uploader = cloudinary?.createUploader()
//            uploader.upload(file: url, params: params) { (response, error) in
//                // Handle response
//            }
//            uploader?.upload(data: fileManager.contents(atPath: String(describing: url))!, uploadPreset: "presetname") { result, error in
//                print(result ?? "Result looks nil")
//                print(error ?? "Error looks nil")
//            }
//        }
    }

    func listFolders() -> [URL] {
        let folders = try! fileManager.contentsOfDirectory(atPath: baseUrl.path)
        let foldersUrls = folders.map {baseUrl.appendingPathComponent($0)}
        return foldersUrls
    }

    func listElemInFolder(bar_id: String) -> [URL] {
        let folder = baseUrl.appendingPathComponent(bar_id)
        if !fileManager.fileExists(atPath: folder.path) {
            print("A priori le dossier : \(folder.path) n'existe pas")
            return []
        }
        let contents = try! fileManager.contentsOfDirectory(atPath: folder.path)
        let paths = contents.map { folder.appendingPathComponent($0) }
        return paths
    }

    func getImagesOfBar(bar_id: String) -> [UIImage] {
        let imagesUrls = listElemInFolder(bar_id: bar_id)
        let images = imagesUrls.map {UIImage(data: fileManager.contents(atPath: $0.path)!)}
        return images as! [UIImage]
    }

    func getAllImages() -> [UIImage] {
        var images : [UIImage] = []
        let folders = listFolders()
        for folder in folders {
            let tmp = getImagesOfBar(bar_id: folder.lastPathComponent)
            for img in tmp {
                images.append(img)
            }
        }
        return images
    }
}

extension Date {
    var timestamp: Int64 {
        return Int64(self.timeIntervalSince1970)
    }
}






















