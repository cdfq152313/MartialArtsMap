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
    
    public func saveToFile(){
        print("Save to file")

        var array = [ [String:String] ]()
        for item in gymArray{
            var content = [String:String]()
            content["name"] = item.name
            content["description"] = item.description
            content["imageSite"] = item.imageSite
            content["address"] = item.address
            content["website"] = item.description
            array.append(content)
        }
        let contents = ["contents": array]
        
        try? FileManager.default.removeItem(at: localUrl)
        print(contents)
        let jsonData = try? JSONSerialization.data(withJSONObject: contents, options: .prettyPrinted)
        print (jsonData)
        try? jsonData?.write(to: localUrl)
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
    
    public func getArray()->[GYMInfo]{
        return gymArray
    }
    
    public func getItem(row:Int)->GYMInfo{
        return gymArray[row]
    }
    
    public func delete(_ row:Int){
        gymArray.remove(at: row)
    }
    
    public func add(_ item:GYMInfo){
        gymArray.append(item)
    }
    
    public func insert(row:Int, item:GYMInfo){
        gymArray.insert(item, at: row)
    }
    
    public func search(keyword:String)->[GYMInfo]{
        var result = [GYMInfo]()
        for item in gymArray{
            if (item.name?.contains(keyword))! {
                result.append(item)
            }
        }
        return result
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
