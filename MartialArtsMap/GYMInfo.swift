//
//  GYMInfo.swift
//  MartialArtsMap
//
//  Created by denny on 10/24/16.
//  Copyright © 2016 denny. All rights reserved.
//

class GYMManager{
    private static var instance:GYMManager?
    private var gymArray:[GYMInfo]
    private init(){
        gymArray = [GYMInfo]()
        let test = GYMInfo(name: "飛鐵克競技體能俱樂部 （原吉林拳館）", description: "位於台北市中山區\n提供拳擊、散打、踢拳、兵器格鬥、泰拳及潛水教學。\n上課時間彈性，小班制教學，不用擔心一次上客人太多學不到東西，或是自己的時間無法配合課程。\n對武術有興趣的朋友歡迎留言詢問，LINE cartis7777 王教練。\n上課時間分為：\n星期一~六的18:50~22:00。", imageSite: "http://i.imgur.com/Fv7KNsm.jpg", address: "104 Taipei 中山區吉林路446號2F", website: "https://www.facebook.com/Fatecfight/?fref=ts")
        gymArray.append(test)
    }
    
    public static func getInstance()->GYMManager{
        if GYMManager.instance == nil{
            GYMManager.instance = GYMManager()
        }
        return GYMManager.instance!
    }
    
    public func getSectionCount()->Int{
        return 1
    }
    
    public func getSection(_ section:Int)->[GYMInfo]{
        return gymArray
    }
    
}

class GYMInfo{
    var name:String
    var description:String
    var imageSite:String
    var address:String
    var website:String
    init (name:String,description:String, imageSite:String, address:String,website:String){
        self.name = name
        self.description = description
        self.imageSite = imageSite
        self.address = address
        self.website = website
    }
}
