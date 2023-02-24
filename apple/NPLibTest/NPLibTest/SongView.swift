//
//  SongView.swift
//  NPLibTest
//
//  Created by Lilly Cham on 26/01/2023.
//

import Foundation
import NPAPI
import SwiftUI

let formatter = DateComponentsFormatter()

extension NSImage {
  /// Average color of the image, nil if it cannot be found
  var averageColor: Color? {
    // convert our image to a Core Image Image
    guard let inputImage = CIImage(data: tiffRepresentation!) else { return nil }
    
    // Create an extent vector (a frame with width and height of our current input image)
    let extentVector = CIVector(x: inputImage.extent.origin.x,
                                y: inputImage.extent.origin.y,
                                z: inputImage.extent.size.width,
                                w: inputImage.extent.size.height)
    
    // create a CIAreaAverage filter, this will allow us to pull the average color from the image later on
    guard let filter = CIFilter(name: "CIAreaAverage",
                                parameters: [kCIInputImageKey: inputImage, kCIInputExtentKey: extentVector]) else { return nil }
    guard let outputImage = filter.outputImage else { return nil }
    
    // A bitmap consisting of (r, g, b, a) value
    var bitmap = [UInt8](repeating: 0, count: 4)
    let context = CIContext(options: [.workingColorSpace: kCFNull!])
    
    // Render our output image into a 1 by 1 image supplying it our bitmap to update the values of (i.e the rgba of the 1 by 1 image will fill out bitmap array
    context.render(outputImage,
                   toBitmap: &bitmap,
                   rowBytes: 4,
                   bounds: CGRect(x: 0, y: 0, width: 1, height: 1),
                   format: .RGBA8,
                   colorSpace: nil)
    
    // Convert our bitmap images of r, g, b, a to a UIColor
    return Color(red: CGFloat(bitmap[0]) / 255,
                 green: CGFloat(bitmap[1]) / 255,
                 blue: CGFloat(bitmap[2]) / 255,
                 opacity: CGFloat(bitmap[3]) / 255)
  }
}

// MARK: - SongView

/// Shows a player interface for the `Binding` song.
struct SongView: View {
  @Binding var song: NPSong
  
  var body: some View {
    VStack {
      if song.artwork != nil {
        song.artwork!
          .resizable()
          .aspectRatio(contentMode: .fit)
          .cornerRadius(10)
          .padding()
      }
      
      //.shadow(color: song.artwork!.averageColor!, radius: 20)
      Text(song.title)
        .font(.title)
        .bold()
        .padding(0.75)
      Text("\(song.artist) - \(song.album)")
        .font(.title2)
        .bold()
        .padding(0.75)
      Text("Track \(song.track) out of \(song.tracks)")
      // Song progress bar
      HStack {
        Text("\(formatter.string(from: Double(song.elapsed))!)")
          .monospacedDigit()
        
        ProgressView(value: song.elapsed, total: song.duration)
        
        Text("\(formatter.string(from: Double(song.duration))!)")
          .monospacedDigit()
      }
      .padding(.horizontal, 100)
    }
    .padding()
    VStack {}.padding()
  }
}
