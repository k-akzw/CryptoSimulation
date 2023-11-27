//
//  ContentView.swift
//  CryptoSimulation
//
//  Created by Kento Akazawa on 11/10/23.
//

import SwiftUI

struct ContentView: View {

  var body: some View {
    VStack {
      List(Simulation.shared.results, id: \.self) { result in
        ResultCell(result: result)
      }
    }
  }
}

#Preview {
  ContentView()
}
