//
//  HomeView.swift
//  StickyHeader
//
//  Created by Alireza Asadi on 1/6/1401 AP.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            NavigationLink("Next") {
                ContentView()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
