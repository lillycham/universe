//
//  NPLibTestApp.swift
//  NPLibTest
//
//  Created by Lilly Cham on 26/01/2023.
//

import NPAPI
import SwiftUI

let nowPlaying = try? NPAPI()

// MARK: - NPLibTestApp

@main
struct NPLibTestApp: App {
  var body: some Scene {
    WindowGroup {
      ContentView()
    }.windowStyle(.hiddenTitleBar)
  }
}
