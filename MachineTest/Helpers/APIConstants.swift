//
//  APIConstants.swift
//
//  Created by Reshma on 19/04/22.
//

import Foundation

struct API_CONSTANTS {
    static let DEBUG = 0
    static let SESSION_TIMEOUT: Int = 5 //Minutes
    static let REQUEST_TIMEOUT: TimeInterval = 120 //600 Second = 10 minutes

    static let DEVICE_TOKEN = "DeviceToken"
    
    //Please change this pointing
    public struct URL_Types {
        static let uat = ""
        static let dev = ""
        static let live = "https://jsonplaceholder.typicode.com/"
    }


    //Urls
    static let BASE_URL = URL_Types.live

    struct BASE_SERVICES {
        static let POST = BASE_URL  + "posts"
        static let USERS = BASE_URL + "users"
        static let GET_ALBUM = BASE_URL + "albums?userId="
        static let GET_PHOTOS = BASE_URL + "photos?albumId="
        static let GET_USERS_POST = BASE_URL + "posts?userId="
        static let GET_POST_COMMENTS = BASE_URL + "comments?postId="

        
    }
}

