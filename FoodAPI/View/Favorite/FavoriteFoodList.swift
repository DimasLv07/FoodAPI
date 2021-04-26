//
//  FavoriteFoodList.swift
//  FoodAPI
//
//  Created by dimas pendriansyah on 20/04/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct FavoriteFoodList: View {
  @Environment(\.managedObjectContext) var moc
  @FetchRequest(entity: FavoriteFood.entity(), sortDescriptors: []) var favoriteFood: FetchedResults<FavoriteFood>
  
  var body: some View {
    NavigationView{
      VStack{
        List{
          ForEach(favoriteFood, id: \.self){ item in
            NavigationLink(destination: FavoriteFoodDetail(data: item)){
              HStack{
                if item.strCategoryThumb != ""{
                  WebImage(url: URL(string: item.wrappedImage)!)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 170)
                    .background(Image("loader")
                                  .resizable()
                                  .aspectRatio(contentMode:  .fill)
                                  .frame(width: 60, height: 30))
                    .cornerRadius(10)
                    
                    
                    
                } else{
                  Image("loader")
                    .resizable()
                    .frame(width: 10, height: 170)
                    .cornerRadius(10)
                }
                VStack(alignment: .leading, spacing: 10){
                  Text(item.wrappedTitle).fontWeight(.bold)
                  
                  Text(item.wrappedDesc).font(.caption)
                    .lineLimit(4)
                    .multilineTextAlignment(.leading)
                }
              }
            }
          }.onDelete(perform: deleteFoodList)
        }
      }
      .navigationBarTitle(Text("Favorite Food"))
    }
    }
  
  private func deleteFoodList(at offsets: IndexSet){
    for index in offsets{
      let favorite = favoriteFood[index]
      moc.delete(favorite)
      
      do{
        try moc.save()
      } catch{
        print(error)
      }
    }
  }
  
}

struct FavoriteFoodList_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteFoodList()
    }
}
