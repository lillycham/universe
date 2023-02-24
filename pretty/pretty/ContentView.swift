//
//  ContentView.swift
//  pretty
//
//  Created by Lilly Cham on 23/02/2023.
//

import SwiftUI

struct ContentView: View {
  //var (parent, child): (FileHandle, FileHandle)
  var body: some View {
    ZStack {
      PrettyViewController()//child: child, parent: parent).
        .padding()
    }.background(Color(red: 1.00, green: 1.00, blue: 0.92))
  }
}

//struct ContentView_Previews: PreviewProvider {
//  static var previews: some View {
//    ContentView(parent: 0, child: 0)
//  }
//}
