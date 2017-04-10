//
//  ApiService.swift
//  youtube
//
//  Created by Brian Voong on 6/30/16.
//  Copyright © 2016 letsbuildthatapp. All rights reserved.
//

import UIKit

class ApiService: NSObject {

    static let sharedInstance = ApiService()
    
    let baseUrl = "https://s3-us-west-2.amazonaws.com/youtubeassets"
    
    func fetchVideos(_ completion: @escaping ([Video]) -> ()) {
        fetchFeedForUrlString("\(baseUrl)/home_num_likes.json", completion: completion)
    }
    
    func fetchTrendingFeed(_ completion: @escaping ([Video]) -> ()) {
        fetchFeedForUrlString("\(baseUrl)/trending.json", completion: completion)
    }
    
    func fetchSubscriptionFeed(_ completion: @escaping ([Video]) -> ()) {
        fetchFeedForUrlString("\(baseUrl)/subscriptions.json", completion: completion)
    }
    
    func fetchFeedForUrlString(_ urlString: String, completion: @escaping ([Video]) -> ()) {
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            
            if error != nil {
                print(error)
                return
            }
            
            do {
                if let unwrappedData = data, let jsonDictionaries = try JSONSerialization.jsonObject(with: unwrappedData, options: .mutableContainers) as? [[String: AnyObject]] {
                    
                    DispatchQueue.main.async(execute: {
                        completion(jsonDictionaries.map({return Video(dictionary: $0)}))
                    })
                }
                
            } catch let jsonError {
                print(jsonError)
            }
            }) .resume()
    }

    
}

//let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers)
//
//var videos = [Video]()
//
//for dictionary in json as! [[String: AnyObject]] {
//    
//    let video = Video()
//    video.title = dictionary["title"] as? String
//    video.thumbnailImageName = dictionary["thumbnail_image_name"] as? String
//    
//    let channelDictionary = dictionary["channel"] as! [String: AnyObject]
//    
//    let channel = Channel()
//    channel.name = channelDictionary["name"] as? String
//    channel.profileImageName = channelDictionary["profile_image_name"] as? String
//    
//    video.channel = channel
//    
//    videos.append(video)
//}
//
//dispatch_async(dispatch_get_main_queue(), {
//    completion(videos)
//})




//                    let numbersArray = [1, 2, 3]
//                    let doubledNumbersArray = numbersArray.map({return $0 * 2})
//                    let stringsArray = numbersArray.map({return "\($0 * 2)"})
//                    print(stringsArray)

//                    var videos = [Video]()
//
//                    for dictionary in jsonDictionaries {
//                        let video = Video(dictionary: dictionary)
//                        videos.append(video)
//                    }
