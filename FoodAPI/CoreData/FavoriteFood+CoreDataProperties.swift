//
//  FavoriteFood+CoreDataProperties.swift
//  FoodAPI
//
//  Created by dimas pendriansyah on 20/04/21.
//
//

import Foundation
import CoreData


extension FavoriteFood {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteFood> {
        return NSFetchRequest<FavoriteFood>(entityName: "FavoriteFood")
    }

    @NSManaged public var strCategoryDescription: String?
    @NSManaged public var id: UUID?
    @NSManaged public var strCategoryThumb: String?
    @NSManaged public var strCategory: String?
  
  public var wrappedId: UUID?{
    id
  }
  
  public var wrappedTitle: String {
    strCategory ?? "unknown title"
  }
  
  public var wrappedImage: String {
    strCategoryThumb ?? "Unknown Image"
  }
  
  public var wrappedDesc: String {
    strCategoryDescription ?? "Unknown Description"
  }

}

extension FavoriteFood : Identifiable {

}
