//
//  PhotosModel.swift
//  MachineTest
//
//  Created by Reshma on 19/04/22.
//

import Foundation

// MARK: - PhotosModelElement
struct PhotosModelElement: Codable {
    let  id: Int
    let title: String
    let url, thumbnailUrl: String

    enum CodingKeys: String, CodingKey {
        case id, title, url
        case thumbnailUrl
    }
}

typealias PhotosModel = [PhotosModelElement]
