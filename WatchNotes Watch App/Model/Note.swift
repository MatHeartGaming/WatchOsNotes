//
//  Note.swift
//  WatchNotes Watch App
//
//  Created by Matteo Buompastore on 07/08/23.
//

import Foundation

struct Note : Identifiable, Codable {
    
    let id : UUID
    let text : String
    
}
