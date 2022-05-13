//
//  AlbumModel.swift
//  MachineTest
//
//  Created by Reshma on 19/04/22.
//

import Foundation

// MARK: - AlbumModelElement
struct AlbumModelElement: Codable {
    let  id: Int
    let title: String

    enum CodingKeys: String, CodingKey {
        case id, title
    }
}

typealias AlbumModel = [AlbumModelElement]

