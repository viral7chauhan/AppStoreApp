//
//  Models.swift
//  AppStore
//
//  Created by Viral Chauhan on 08/02/18.
//  Copyright © 2018 Viral Chauhan. All rights reserved.
//

import Foundation

struct Banner: Decodable {
    let categories: [AppCategory]
}

class AppCategory: Decodable {
    var name: String?
    var apps: [App]?
    var type: String?
    
//    init(json: [String: Any]) {
//        self.name = json["name"] as? String ?? ""
//        self.type = json["type"] as? String ?? ""
//
//        guard let appArray = json["apps"] as? [[String:Any]] else { return }
//
//        self.apps = [App]()
//        for dict in appArray {
//            apps?.append(App(json: dict))
//        }
    
//    }
    
    static func fetchDataFromWeb(completionHandler: @escaping ([AppCategory])-> ()) {
        let urlString = "https://api.letsbuildthatapp.com/appstore/featured"
      
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            print("Do stuff here")
            
            guard let data = data else { return }
            
            do {
                
                let dic = try JSONDecoder().decode(Banner.self, from: data)
                
//                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else {return}
//                print(json)
//
//                var appCategories = [AppCategory]()
//
//                for dic in json["categories"] as! [[String:Any]] {
//                    let appCategory = AppCategory(json: dic)
//                    appCategories.append(appCategory)
//                }
//
//                print(appCategories)
                let apps = dic.categories
                print(apps)
                completionHandler(apps)
                
            } catch let jsonError {
                print ("Seraialize error \(jsonError)")
            }
            
            
        }.resume()
    }

    
}

struct App : Decodable {
    var id: Int?
    var name: String?
    var category: String?
    var price : Float?
    var imageName: String?
    
    init(json: [String: Any]) {
        self.id = json["Id"] as? Int ?? 0
        self.category = json["Category"] as? String ?? nil
        self.imageName = json["ImageName"] as? String ?? nil
        self.name = json["Name"] as? String ?? nil
        self.price = json["Price"] as? Float ?? 0.0
    }
}
