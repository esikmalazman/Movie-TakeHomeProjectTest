//
//  MovieFavourites+CoreDataProperties.swift
//  Movie+
//
//  Created by Ikmal Azman on 30/06/2023.
//
//

import Foundation
import CoreData


extension MovieFavourites {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieFavourites> {
        return NSFetchRequest<MovieFavourites>(entityName: "MovieFavourites")
    }

    @NSManaged public var id: Int32
    @NSManaged public var title: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var posterPath: String?
    @NSManaged public var overview: String?
    @NSManaged public var backdropPath: String?

}

extension MovieFavourites : Identifiable {

}
