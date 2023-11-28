//
//  VariableView.swift
//  CryptoSimulation
//
//  Created by Kento Akazawa on 11/27/23.
//

import SwiftUI

struct VariableView: View {
  
  var body: some View {
    List(Simulation.shared.players, id: \.name) { player in
      VariableViewCell(player: player)
    }
  }
}

struct VariableViewCell: View {
  
  var player: Player
  
  var body: some View {
    VStack {
      Text(player.name)
      
      HStack {
        Spacer(minLength: 40)
        Text("e")
        Spacer()
        Text("\(player.e)")
        Spacer(minLength: 40)
      }
      
      HStack {
        Spacer(minLength: 40)
        Text("n")
        Spacer()
        Text("\(player.n)")
        Spacer(minLength: 40)
      }
    }
  }
}

//#Preview {
//  VariableView()
//}
