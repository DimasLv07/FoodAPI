//
//  FoodList.swift
//  FoodAPI
//
//  Created by dimas pendriansyah on 19/04/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct FoodList: View {
  @ObservedObject var foodViewModel = FoodViewModel()
  
  var body: some View {
    NavigationView{
      List(foodViewModel.data){ item in
        NavigationLink(destination: FoodDetail(food: item)){
          if item.strCategoryThumb != ""{
            WebImage(url: URL(string: item.strCategoryThumb)!)
              .resizable()
              .scaledToFill()
              .frame(width: 120, height: 170)
              .background(Image("loader")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 60, height: 30))
              .cornerRadius(10)
              
          } else {
            Image("loader")
              .resizable()
              .frame(width: 120, height: 170)
              .cornerRadius(10)
          }
          VStack(alignment: .leading, spacing: 10){
            Text(item.strCategory).fontWeight(.bold)
            
            Text(item.strCategoryDescription).font(.caption)
              .lineLimit(4)
              .multilineTextAlignment(.leading)
        }
      }
    }
      .navigationBarTitle(Text("Food"))
  }.navigationViewStyle(StackNavigationViewStyle())
    
  }
 

}

struct FoodList_Previews: PreviewProvider {
  static var previews: some View {
    FoodList()
  }
}

