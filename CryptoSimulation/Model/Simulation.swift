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

  let players = [Player1.shared, Player2.shared, Player3.shared, Player4.shared, Player5.shared, Player6.shared, Player7.shared, Player8.shared, Player9.shared]
  var transactions = [(String, Int)]()
  let numOfTransactions = 20
  // max amount a player can send at a time
  let maxAmount = 100
  // pattern of message
  // used when validating
  let pattern = /(?<amount>\d+(\.\d+)?)-(?<e>\d+),(?<n>\d+)/

  var results = [Result]()

  // MARK: - Initialization

  init() {
    generateTransactions()
    simulate()
  }

  // MARK: - Public Functions

  // generate trasactions by generating random amount, sender, receiver
  // and create message based on those
  func generateTransactions() {
    for _ in 0..<numOfTransactions {
      // generate random amount to send
      let amount: Double = Double(Int.random(in: 0...maxAmount*100))/100
      // generate random sender
      let senderIndex: Int = Int.random(in: 0..<players.count)
      // generate random receiver
      var receiverIndex: Int = Int.random(in: 0..<players.count)
      
      // receiver cannot be same as sender
      // so if they're same, keep assigning new receiver
      while senderIndex == receiverIndex {
        receiverIndex = Int.random(in: 0..<players.count)
      }
      
      let message = String(amount) + "-" + String(players[receiverIndex].e) + "," + String(players[receiverIndex].n)
      // all transactions need message and sender
      transactions.append((message, senderIndex))
    }
  }

  func simulate() {
    // verify all transactions and change balance accordingly
    // @transaction is tuple where 0th element is message and 1 st is sender index
    for transaction in transactions {
      let sender = players[transaction.1]
      let cipherText = sender.tx(message: transaction.0)
      // Player10 validates all transactions
      let decryptedText = Player10.shared.validate(cipherText: cipherText, e: sender.e, n: sender.n)

      var res = Result(decrypted: decryptedText, sender: sender.name)
      // verifying the transaction
      // if @decryptedText matches @pattern, transaction can be verified
      if let message = try? pattern.wholeMatch(in: decryptedText) {
        res.amount = String(message.amount)
        res.e = String(message.e)
        res.n = String(message.n)
        res.verified = true
        
        let receiver = getReceiver(e: res.e)
        res.receiver = receiver.name
        
        // update balance
        if sender.reduceBalance(by: res.amount) {
          receiver.addBalance(of: Double(res.amount) ?? 0.0)
        } else {
          res.verified = false
        }
      }
      results.append(res)
    }
  }
  
  // MARK: - Private Functions
  
  func getReceiver(e: String) -> Player {
    for player in players {
      if String(player.e) == e {
        return player
      }
    }
    // Note: should not run
    return Player10.shared
  }
}

struct Result: Hashable {
  var decrypted: String
  var sender: String
  var receiver: String = ""
  var amount: String = ""
  var e: String = ""
  var n: String = ""
  var verified: Bool = false
}
