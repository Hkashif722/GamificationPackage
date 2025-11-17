//
//  ResourceUtils.swift
//  GamificationPackage
//
//  Created by Kashif Hussain on 16/11/25.
//


//
//  ResourceUtils.swift
//  SWAYAM 2.0 copy
//
//  Created by Kashif Hussain on 06/03/25.
//  Copyright © 2025 EnthrallTech. All rights reserved.
//

import Foundation


internal struct ResourceUtils {
    
    static func launchS3Resourse(_ filePath: String) -> String {
        
        let defaults = UserDefaults.standard
        
        let isBlobeEnabled = defaults.string(forKey: "isBlobStorageEnabled") == "No" ? false : true
        
        if filePath.contains("content.gogetempowered.com") {
            return filePath
        }
        var pathFinal = filePath
        if pathFinal.contains(":10000"){
            pathFinal = pathFinal.replace(":10000", replacement: APIConst.lxpPath)
        }
       // pathFinal = pathFinal.replace("https:", replacement: "http:")
        pathFinal = pathFinal.replace("\\", replacement: "/")
        if !isBlobeEnabled {
            if pathFinal.contains("https://assets") {
                if let url = URL(string: pathFinal),
                   var components = URLComponents(url: url, resolvingAgainstBaseURL: false),
                   let baseURL = URL(string: APIConst.baseURL),
                   let baseComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: false) {
                    
                    // Replace scheme and host with values from APIConst.baseURL.
                    components.scheme = baseComponents.scheme
                    components.host = baseComponents.host
                    
                    // Directly replace "org-content" with the static oilPath value.
                    components.path = components.path.replacingOccurrences(of: "org-content", with: APIConst.lxpOPath)
                    
                    if let updatedURL = components.url {
                        pathFinal = updatedURL.absoluteString
                    }
                }
            }else if(pathFinal.contains("assets")){
                pathFinal = APIConst.baseURL+"/"+pathFinal
            }else if pathFinal.first == "/"{
                pathFinal = APIConst.baseURL+APIConst.lxpBlobPath+pathFinal
            } else if pathFinal.contains(APIConst.lxpOPath) {
                
            }else  if pathFinal.contains("org-content"){
                pathFinal = pathFinal.replace("org-content", replacement: APIConst.lxpOPath)
            }else{
                pathFinal = APIConst.baseURL+APIConst.lxpBlobPath1+pathFinal
            }
            
        }else{
            if let url = URL(string: pathFinal), url.scheme?.hasPrefix("https") == true {
                pathFinal = pathFinal.replacingHost(with: "content.gogetempowered.com")
                let orgcode = LoginUtility.shared.getOrganizationCode().lowercased()
                if !orgcode.isEmpty {
                    if pathFinal.contains(orgcode), let arrayPath = pathFinal.components(separatedBy: orgcode).last {
                        pathFinal = [APIConst.ContentPath,orgcode].joinWithPathSeparator()
                        pathFinal += arrayPath
                    } else if pathFinal.contains(APIConst.lxpOPath) || pathFinal.contains("org-content") {
                        if let arrayPath = pathFinal.components(separatedBy: "org-content").last {
                            pathFinal = [APIConst.ContentPath, orgcode].joinWithPathSeparator()
                            pathFinal += arrayPath
                        }
                    }
                } else if pathFinal.contains(APIConst.lxpOPath) || pathFinal.contains("org-content") {
                    if let arrayPath = pathFinal.components(separatedBy: "org-content").last {
                        pathFinal = APIConst.ContentPath + arrayPath
                    }
                }
            } else if pathFinal.first == "/" {
                pathFinal = APIConst.ContentPath + pathFinal
            } else if pathFinal.contains(APIConst.lxpOPath) || pathFinal.contains("org-content") {
                if let arrayPath = pathFinal.components(separatedBy: "org-content").last {
                    pathFinal = APIConst.ContentPath + arrayPath
                }
            } else if pathFinal.contains("www") {
                pathFinal = pathFinal.replacingOccurrences(of: "www", with: "content")
            } else {
                pathFinal = APIConst.ContentPath + "/" + pathFinal
            }
        }
        
        //pathFinal = pathFinal.replace("https:", replacement: "http:")
        pathFinal = pathFinal.replace("\\", replacement: "/")
        
        return pathFinal
    }

   

    static func s3_thumbnail_path(filePath: String) -> String {
        
        let defaults = UserDefaults.standard
        
        let isBlobStorageEnabled = defaults.string(forKey: "isBlobStorageEnabled") == "No" ? false : true
        
        if  !isBlobStorageEnabled {
            var pathFinal = filePath.removeExtraCharactor()
            if pathFinal.contains("https://") {
                return pathFinal
            } else if(pathFinal.contains("assets")){
                pathFinal = APIConst.baseURL+"/"+pathFinal
            }else if pathFinal.first == "/"{
                pathFinal = APIConst.baseURL+APIConst.lxpBlobPath+pathFinal
            } else if pathFinal.contains(APIConst.lxpOPath) {
                
            }else  if pathFinal.contains("org-content"){
                pathFinal = pathFinal.replace("org-content", replacement: APIConst.lxpOPath)
            }else{
                pathFinal = APIConst.baseURL+APIConst.lxpBlobPath1+pathFinal
            }
            //  strUrl = strUrl.replace("https:", replacement: "http:")
            pathFinal = pathFinal.replace("\\", replacement: "/")
            return pathFinal
        } else {
            
            if filePath.contains("https://") {
                return filePath
            }
            
            if filePath.contains("content.gogetempowered.com")  {
                return filePath
            }
            var pathFinal = filePath.removeExtraCharactor()
            let orgCode = LoginUtility.shared.getOrganizationCode().lowercased()

            
            pathFinal = pathFinal.replace("http:", replacement: "https:")
            pathFinal = pathFinal.replace("\\", replacement: "/")
            pathFinal = pathFinal.replace(" ", replacement: "%20")
            
            if(pathFinal.contains("assets")){
                if pathFinal.hasPrefix("/") {
                    return APIConst.ContentPath+pathFinal
                } else {
                    return APIConst.ContentPath+"/"+pathFinal
                }
            }
            
            if pathFinal.contains(find: orgCode) {
                let imgURLs = pathFinal.components(separatedBy: orgCode)
                if imgURLs[1].hasPrefix("/") {
                    return APIConst.ContentPath+"/"+orgCode+imgURLs[1]
                } else {
                    return APIConst.ContentPath+"/"+orgCode+"/"+imgURLs[1]
                }
                
            } else {
                if filePath.contains(APIConst.baseURL) {
                    if pathFinal.contains(APIConst.lxpOPath) {
                        return pathFinal
                    } else if pathFinal.contains(":10000"){
                        pathFinal = pathFinal.replace(":10000", replacement: APIConst.lxpBlobPath)
                        return pathFinal
                    } else if pathFinal.contains("org-content") {
                        pathFinal = pathFinal.replace("org-content", replacement: APIConst.lxpOPath)
                        return pathFinal
                    }
                    return pathFinal
                } else {
                    if pathFinal.hasPrefix("/") {
                        return APIConst.ContentPath+pathFinal
                    } else {
                        return APIConst.ContentPath+"/"+pathFinal
                    }
                }
            }
            
        }
    }
    

    static func sanatiseUrlString(_ urlString: String) -> String {
        return urlString.removeExtraCharactor().manageExtraCha()
    }

    static func getResourceURLPath(_ path: String?) -> URL? {
        guard let path = path else { return nil }
        
        let sanitizedPath = sanatiseUrlString(path)
        let resourceFilePath = ResourceUtils.launchS3Resourse(sanitizedPath)
        
        return URL(string: resourceFilePath)
    }
    

    

    static func getParsedThumbnailPath(_ thumbnailPath: String) -> String {
        let path = sanatiseUrlString(thumbnailPath)
        return ResourceUtils.s3_thumbnail_path(filePath: path)
    }
    
    static func getParsedThumbnailPathURL(_ thumbnailPath: String) -> URL? {
        let resourceURL = ResourceUtils.getParsedThumbnailPath(thumbnailPath)
        return URL(string: resourceURL)
    }
    
    
    static func getResourcPath(_ path: String?) -> String {
        guard let path = path else { return "" }
        
        let sanitizedPath = sanatiseUrlString(path)
        let resourceFilePath = ResourceUtils.launchS3Resourse(sanitizedPath)
        
        return  resourceFilePath
    }
    

}
