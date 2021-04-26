//
//  FoodDetail.swift
//  FoodAPI
//
//  Created by dimas pendriansyah on 19/04/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct FoodDetail: View {
  @Environment(\.managedObjectContext) var moc
  @FetchRequest(entity: FavoriteFood.entity(), sortDescriptors: []) var favoriteFood: FetchedResults<FavoriteFood>
  
  let food: Food
    var body: some View {
      ScrollView{
        VStack(alignment: .leading){
          WebImage(url: URL(string: food.strCategoryThumb))
            .resizable()
            .aspectRatio(contentMode: .fit)
            .clipped()
          VStack(alignment: .leading, spacing: 20){
            Text(food.strCategory)
              .font(.title)
              .fontWeight(.bold)
            Text(food.strCategoryDescription)
              .font(.body)
            HStack(alignment: .center){
              if (checkId(id: food.id) == true){
                Button(action: {
                  self.deleteFavoriteNews(id: food.id)
                  try? self.moc.save()
                }){
                  HStack{
                    Image(systemName: "trash").foregroundColor(.red)
                    Text("Delete from favorite").foregroundColor(.red)
                  }.padding(7)
                  .cornerRadius(30)
                }
              } else {
                Button(action: {
                  self.addFavoriteFood(data: food)
                  try? self.moc.save()
                }){
                  HStack{
                    Image(systemName: "heart").foregroundColor(.blue)
                    Text("Add to favorite").foregroundColor(.blue)
                  }.padding(7)
                  .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.blue, lineWidth: 2))
                }
              }
            }
          }.padding()
        }
      }
      .navigationBarTitleDisplayMode(.inline)
    }
  
  private func checkId(id : UUID) -> Bool {
    for food in favoriteFood{
      if food.wrappedId == id{
        return true
      }
    }
    return false
  }
  
  private func deleteFavoriteNews(id: UUID){
    for food in favoriteFood {
      if food.wrappedId == id{
        moc.delete(food)
      }
    }
  }
  
  private func addFavoriteFood(data: Food){
    let favorite = FavoriteFood(context: self.moc)
    favorite.id = data.id
    favorite.strCategory = data.strCategory
    favorite.strCategoryThumb = data.strCategoryThumb
    favorite.strCategoryDescription = data.strCategoryDescription
  }
  
}

struct FoodDetail_Previews: PreviewProvider {
    static var previews: some View {
      FoodDetail(food: Food(strCategory: "", strCategoryThumb: "", strCategoryDescription: ""))
    }
}
