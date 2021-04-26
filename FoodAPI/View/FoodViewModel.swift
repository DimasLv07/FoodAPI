//
//  FoodViewModel.swift
//  FoodAPI
//
//  Created by dimas pendriansyah on 19/04/21.
//

import Foundation
import Combine
import SwiftyJSON

class FoodViewModel: ObservableObject {
  @Published var data = [Food]()
  
  init() {
    let url = "https://www.themealdb.com/api/json/v1/1/categories.php"
    
    let session = URLSession(configuration: .default)
    
    session.dataTask(with: URL(string: url)!){ (data, _, error) in
      if error != nil {
        print((error?.localizedDescription)!)
        return
      }
      
      let json = try! JSON(data: data!)
      let items = json["categories"].array!
      
      for i in items{
        let strCategory = i["strCategory"].stringValue
        let strCategoryDescription = i["strCategoryDescription"].stringValue
        let strCategoryThumb = i["strCategoryThumb"].stringValue
        
        DispatchQueue.main.async {
          self.data.append(Food(strCategory: strCategory, strCategoryThumb: strCategoryThumb, strCategoryDescription: strCategoryDescription))
        }
      }
    }.resume()
  }
}
