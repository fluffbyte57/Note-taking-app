//
//  NoteFiles(hell).swift
//  Note taking app
//
//  Created by Yacov Vladimirovich on 7/24/26.
//

import Foundation

struct Note: Identifiable, Codable, Hashable{
    var id: UUID
    var name: String
    var text: String
}
