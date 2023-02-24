//
//  TreeView.swift
//  FolderTree
//
//  Created by Lilly Cham on 18/02/2023.
//

import Foundation
import SwiftUI

struct TreeView: View {
  @State var dirs: [URL]
  var body: some View {
    ForEach(dirs, id: .valueType.self) { idx in
      Text("\(dirs[idx])")
    }
  }
}
