//
//  ContentView.swift
//  FoodAPI
//
//  Created by dimas pendriansyah on 19/04/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct ContentView: View {
    var body: some View {
      TabView{
        FoodList()
          .tabItem{
            Image(systemName: "house.fill")
            Text("Game")
          }
        SearchList()
          .tabItem{
            Image(systemName: "magnifyingglass")
            Text("Search")
          }
        FavoriteFoodList()
          .tabItem{
            Image(systemName: "heart")
            Text("Favorite")
          }
        Profile()
          .tabItem{
            Image(systemName: "person.fill")
            Text("About")
          }
      }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

