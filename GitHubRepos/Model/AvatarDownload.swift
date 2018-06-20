//
//  AvatarDownload.swift
//  GitHubRepos
//
//  Created by admin on 19/06/2018.
//  Copyright © 2018 Aviv Eyal. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage
class AvatarDownload{
    
    static let instance = AvatarDownload()
    
    private func saveImageToFile(image:UIImage, name:String){
        print("SAVING IMAGE TO FILE")
        if let data = UIImageJPEGRepresentation(image, 0.3) {
            let filename = getDocumentsDirectory().appendingPathComponent(name)
            try? data.write(to: filename)
        }
    }
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in:
            .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    private func getImageFromFile(name:String)->UIImage?{
        print("GETTING IMAGE FROM LOCAL STORAGE")
        let filename = getDocumentsDirectory().appendingPathComponent(name)
        return UIImage(contentsOfFile:filename.path)
    }
    
    
    func getImageForAvataer(urlStr:String, callback:@escaping (UIImage?)->Void){
        //1. try to get the image from local store
        let url = URL(string: urlStr)
        if(url != nil){
            let localImageName = url!.lastPathComponent
            if let image = self.getImageFromFile(name: localImageName){
                callback(image)
            }else{
                //2. download the image
                Alamofire.request(urlStr).responseImage { (image) in
                    if let image = image.result.value {
                        
                        //3. save the image localy
                        self.saveImageToFile(image: image, name: localImageName)
                    }
                    //4. return the image to the user
                    callback(image.result.value)
                }
            }
        }
    }
    
}
