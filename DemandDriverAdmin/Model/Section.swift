//
//  Section.swift
//  DemandDriverAdmin
//
//  Created by CZSM2 on 10/04/18.
//  Copyright © 2018 CZSM2. All rights reserved.
//

import Foundation
struct Section {
    var genre: String!
    var movies: [String]!
    var expanded: Bool!
    
    init(genre: String, movies: [String], expanded: Bool) {
        self.genre = genre
        self.movies = movies
        self.expanded = expanded
    }
}
