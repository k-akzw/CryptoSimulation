//
//  ResultView.swift
//  CryptoSimulation
//
//  Created by Kento Akazawa on 11/26/23.
//

import SwiftUI

struct ResultView: View {
  var body: some View {
    VStack {
      List(Simulation.shared.results, id: \.self) { result in
        ResultCell(result: result)
      }
    }
  }
}

struct ResultCell: View {

  // MARK: - Properties

  var result: Result

  var body: some View {
    VStack {
      HStack {
        Text("Decrypted Text")
        Spacer()
        Text(result.decrypted)
      }

      HStack {
        Text("Sender")
        Spacer()
        Text(result.sender)
      }

      HStack {
        Text("Amount")
        Spacer()
        Text(result.amount)
      }

      HStack {
        Text("e")
        Spacer()
        Text(result.e)
      }

      HStack {
        Text("n")
        Spacer()
        Text(result.n)
      }

      HStack {
        Text("Verified")
        Spacer()
        Text(result.verified.description)
      }
    }
  }
}

#Preview {
  ResultView()
}
