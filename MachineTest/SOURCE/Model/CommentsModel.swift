//
//  CommentsModel.swift
//  MachineTest
//
//  Created by Reshma on 19/04/22.
//

import Foundation

// MARK: - CommentsModelElement
struct CommentsModelElement: Codable {
    let  id: Int
    let name, email, body: String

    enum CodingKeys: String, CodingKey {
        case id, name, email, body
    }
}
typealias CommentsModel = [CommentsModelElement]
