//
//  SearchViewModel.swift
//  FoodAPI
//
//  Created by dimas pendriansyah on 23/04/21.
//

import SwiftUI
import SwiftyJSON

class SearchViewModel: ObservableObject {
  @Published var search = ""
  @Published var food: [Food] = []
  @Published var foodFiltered: [Food] = []
  
  func filterFood(){
    withAnimation(.linear){
      self.foodFiltered = self.food.filter{
        return $0.strCategory.lowercased().contains(self.search.lowercased())
        
      }
    }
   
      
    }
  init() {
    let url = "https://www.themealdb.com/api/json/v1/1/categories.php"
    let session = URLSession(configuration: .default)
    
    session.dataTask(with: URL(string: url)!){ (data, _,error) in
      
      if error != nil{
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
          self.food.append(Food(strCategory: strCategory, strCategoryThumb: strCategoryThumb, strCategoryDescription: strCategoryDescription))
        }
      }
    }.resume()
  }
  }


