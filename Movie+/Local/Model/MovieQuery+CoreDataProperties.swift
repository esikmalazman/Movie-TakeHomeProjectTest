//
//  MovieQuery+CoreDataProperties.swift
//  Movie+
//
//  Created by Ikmal Azman on 29/06/2023.
//
//

import Foundation
import CoreData


extension MovieQuery {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieQuery> {
        return NSFetchRequest<MovieQuery>(entityName: "MovieQuery")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var query: String?
    @NSManaged public var results: Data?

}

extension MovieQuery : Identifiable {

}
