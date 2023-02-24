//
//  ContentView.swift
//  NPLibTest
//
//  Created by Lilly Cham on 26/01/2023.
//

import NPAPI
import SwiftUI

// MARK: - ContentView

struct ContentView: View {
  @State var song = NPSong()

  var body: some View {
    SongView(song: $song)
      .padding()
  }
}

// MARK: - ContentView_Previews

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
