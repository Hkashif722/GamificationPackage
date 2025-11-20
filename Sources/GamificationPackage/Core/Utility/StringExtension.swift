//
//  File.swift
//  GamificationPackage
//
//  Created by Kashif Hussain on 16/11/25.
//

import Foundation


extension String {
    func removeExtraCharactor() -> String{
        var outPutString: String = self
        if self.contains("../"){
            outPutString = self.replace("../", replacement: "")
        }
        return outPutString
    }
    
    func replace(_ string:String, replacement:String) -> String {
        return self.replacingOccurrences(of: string, with: replacement, options: NSString.CompareOptions.literal, range: nil)
    }
    
    func removeWhitespace() -> String {
        return self.replace(" ", replacement: "")
    }
    func trim() -> String{
        return self.trimmingCharacters(in: NSCharacterSet.whitespaces)
    }
    
    
    func replacingHost(with newHost: String) -> String {
        guard var components = URLComponents(string: self), components.host != nil else {
            return self
        }
        components.host = newHost
        return components.string ?? self
    }
    
    func manageExtraCha() -> String{
        var outPutString = self
        if self.contains("\\"){
            outPutString = self.replace("\\", replacement: "/")
        }
        return outPutString
    }
}



