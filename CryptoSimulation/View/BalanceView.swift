//
//  BalanceView.swift
//  CryptoSimulation
//
//  Created by Kento Akazawa on 11/27/23.
//

import SwiftUI

struct BalanceView: View {
  var body: some View {
    List(Simulation.shared.players, id: \.name) { player in
      BalanceViewCell(player: player)
    }
  }
}

struct BalanceViewCell: View {
  
  var player: Player
  
  var body: some View {
    HStack {
      Text(player.name)
      Spacer()
      Text("\(String(format: "%.2f", player.balance))")
    }
  }
}

#Preview {
  BalanceView()
}
