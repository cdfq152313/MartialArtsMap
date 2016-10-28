//
//  GYMInfo.swift
//  MartialArtsMap
//
//  Created by denny on 10/24/16.
//  Copyright © 2016 denny. All rights reserved.
//
import UIKit

class GYMManager{
    private static var instance:GYMManager?
    private var gymArray = [GYMInfo]()
    private let localUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("myjson.json")
    
    private init(){
        if FileManager.default.fileExists(atPath: localUrl.path) {
            print("=== Has file ===")
            localFileInit()
        }
        else{
            print("=== Copy file ===")
            let url = Bundle.main.url(forResource: "myjson", withExtension: "json")
            try! FileManager.default.copyItem(at: url!, to: localUrl)
            localFileInit()
        }
    }
    
    deinit{
        saveToFile()
    }
    
    private func localFileInit(){
        let data = try! Data(contentsOf: localUrl)
        if let jsonData = try! JSONSerialization.jsonObject(with: data, options: []) as?[String:Any] {
            print("Read data from local file")
            readjson(jsonData)
        }
    }
    
    private func jsonFileInit(){
        let url = Bundle.main.url(forResource: "myjson", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        if let jsonData = try! JSONSerialization.jsonObject(with: data, options: []) as?[String:Any] {
            print("Read data from myjson")
            readjson(jsonData)
        }
    }
    
    private func saveToFile(){
        
    }
    
    
    public func reset(){
        print("=== Reset file ===")
        let url = Bundle.main.url(forResource: "myjson", withExtension: "json")
        try? FileManager.default.removeItem(at: localUrl)
        try! FileManager.default.copyItem(at: url!, to: localUrl)
        gymArray = [GYMInfo]()
        localFileInit()
    }
    
    func readjson(_ jsonData: [String:Any]){
        if let contents = jsonData["contents"] as? [Any]{
            for _content in contents{
                let gymInfo = GYMInfo()
                let content = _content as? [String:Any]
                gymInfo.name = content?["name"] as? String
                gymInfo.description = content?["description"] as? String
                gymInfo.imageSite = content?["imageSite"] as? String
                gymInfo.address = content?["address"] as? String
                gymInfo.website = content?["website"] as? String
                gymArray.append(gymInfo)
            }
        }
    }
    
    public static func getInstance()->GYMManager{
        if GYMManager.instance == nil{
            GYMManager.instance = GYMManager()
        }
        return GYMManager.instance!
    }
    
    public func count()->Int{
        return gymArray.count
    }
    
    public func getItem(row:Int)->GYMInfo{
        return gymArray[row]
    }
    
    public func delete(_ row:Int){
        gymArray.remove(at: row)
    }
}

class GYMInfo{
    var name:String?
    var description:String?
    var imageSite:String?
    var address:String?
    var website:String?
    init (name:String,description:String, imageSite:String, address:String,website:String){
        self.name = name
        self.description = description
        self.imageSite = imageSite
        self.address = address
        self.website = website
    }
    init (){
        
    }
}
