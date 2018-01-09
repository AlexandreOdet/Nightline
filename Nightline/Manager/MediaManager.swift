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

    init() {
        self.baseUrl = URL(fileURLWithPath: (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("media"))
        if !fileManager.fileExists(atPath: baseUrl.path) {
            try! fileManager.createDirectory(at: baseUrl, withIntermediateDirectories: true, attributes: nil)
        }
    }

    func saveImage(bar_id: String, image: UIImage) {
        let destination = baseUrl.appendingPathComponent(bar_id)
//        let imageName = "\(String(Date().timestamp))"
        let imageName = Date().toImgName
        let completeFileName = destination.appendingPathComponent(imageName)

        if !fileManager.fileExists(atPath: destination.path) {
            try! fileManager.createDirectory(at: destination, withIntermediateDirectories: true, attributes: nil)
        }
        let imageData = UIImageJPEGRepresentation(image, 0.5)
        fileManager.createFile(atPath: completeFileName.path, contents: imageData, attributes: nil)
        CloudinaryManager.shared.uploadImg(img: image, folder: "establishment/" + bar_id, name: imageName) { return }
    }

    func listFolders() -> [URL] {
        let folders = try! fileManager.contentsOfDirectory(atPath: baseUrl.path)
        let foldersUrls = folders.map {baseUrl.appendingPathComponent($0)}
        return foldersUrls
    }

    func listElemInFolder(bar_id: String) -> [URL] {
        let folder = baseUrl.appendingPathComponent(bar_id)
        if !fileManager.fileExists(atPath: folder.path) {
            log.error("A priori le dossier : \(folder.path) n'existe pas")
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

    func syncBarImages(bar_id: String, callback: @escaping () -> ()) {
        
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




















