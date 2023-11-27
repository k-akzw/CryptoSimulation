//
//  Simulation.swift
//  CryptoSimulation
//
//  Created by Kento Akazawa on 11/26/23.
//

import Foundation

class Simulation {

  // Singleton instance of this class
  static let shared = Simulation()

  // MARK: - Properties

  let players = [Player1.shared, Player2.shared, Player3.shared, Player4.shared, Player5.shared, Player6.shared]
  var transactions = [(String, Int)]()
  let numOfTransactions = 20
  let amounts = [Int]()
  let maxAmount = 20
  let pattern = /(?<amount>\d+(\.\d+)?)-(?<e>\d+),(?<n>\d+)/

  var results = [Result]()

  // MARK: - Initialization

  init() {
    setup()
    simulate()
  }

  // MARK: - Public Functions

  func setup() {
    for _ in 0..<numOfTransactions {
      let amount: Double = Double(Int.random(in: 0...maxAmount*100))/100
      let senderIndex: Int = Int.random(in: 0..<players.count)
      var receiverIndex: Int = Int.random(in: 0..<players.count)
      while senderIndex == receiverIndex {
        receiverIndex = Int.random(in: 0..<players.count)
      }
      let text = String(amount) + "-" + String(players[receiverIndex].e) + "," + String(players[receiverIndex].n)
      transactions.append((text, senderIndex))
    }
  }

  func simulate() {
    for transaction in transactions {
      let sender = players[transaction.1]
      let cipherText = sender.tx(message: transaction.0)
      let decryptedText = Player10.shared.validate(cipherText: cipherText, e: sender.e, n: sender.n)

      var res = Result(decrypted: decryptedText, sender: sender.name)
      if let text = try? pattern.wholeMatch(in: decryptedText) {
        res.amount = String(text.amount)
        res.e = String(text.e)
        res.n = String(text.n)
        res.verified = true
      }
      results.append(res)
    }
  }
}

struct Result: Hashable {
  var decrypted: String
  var sender: String
  var amount: String = ""
  var e: String = ""
  var n: String = ""
  var verified: Bool = false
}
