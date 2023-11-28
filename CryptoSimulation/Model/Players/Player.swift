//
//  Player.swift
//  CryptoSimulation
//
//  Created by Kento Akazawa on 11/10/23.
//

import Foundation

class Player {

  // MARK: - Properties

  private var p: Int
  private var q: Int
  private var d: Int
  private var phiN: Int
  var n: Int
  var e: Int
  var balance: Double
  var name: String

  private let symbols: [Character:String] = [".":"10", ",":"11", "-":"12", " ":"13"]

  // MARK: - Initialization

  init(name: String) {
    let extendedEuclidean = ExtendedEuclidean()
    self.p = extendedEuclidean.p
    self.q = extendedEuclidean.q
    self.d = extendedEuclidean.d
    self.phiN = extendedEuclidean.phiN
    self.n = extendedEuclidean.n
    self.e = extendedEuclidean.e
    self.balance = 100.0
    self.name = name
  }

  // MARK: - Public Functions

  func setup() {
    let extendedEuclidean = ExtendedEuclidean()
    p = extendedEuclidean.p
    q = extendedEuclidean.q
    d = extendedEuclidean.d
    n = extendedEuclidean.n
    phiN = extendedEuclidean.phiN
    e = extendedEuclidean.e
  }

  // encode and encrypt @message
  // return cipher text as list of 8 digits
  func tx(message: String) -> [Int] {
    print(message)
    let encodedMessage = encode(message)
    var cipherText = [Int]()
    for m in encodedMessage {
      cipherText.append(fastExponentiation(base: m, power: d, mod: n))
    }
    return cipherText
  }

  // validate the transaction by decrypting @cipherText
  func validate(cipherText: [Int], e: Int, n: Int) -> String {
    var decryptedMessage = [String]()
    var temp = ""
    for m in cipherText {
      temp = String(fastExponentiation(base: m, power: e, mod: n))
      for _ in 0..<8 - temp.count {
        temp = "0" + temp
      }
      decryptedMessage.append(temp)
    }

    temp = ""
    for m in decryptedMessage {
      temp += m
    }

    return decode(temp)
  }
  
  func reduceBalance(by amount: String) -> Bool {
    if let doubleAmount = Double(amount) {
      if doubleAmount > balance {
        return false
      }
      balance -= doubleAmount
      return true
    }
    return false
  }
  
  func addBalance(of amount: Double) {
    balance += amount
  }

  // MARK: - Private Functions

  // convert each symbol into correspoinding digits
  // group every 4 digits
  // and return the list of those 4 digits
  private func encode(_ message: String) -> [Int] {
    var intMessage = ""

    // convert each symbol into corresponding digits
    // and add 0 in front of all the numbers to make them 2 digits
    for m in message {
      if symbols.keys.contains(m) {
        intMessage += symbols[m]!
      } else {
        intMessage += "0" + String(m)
      }
    }

    var messages = [String]()

    // group every 8 numbers and store them in @messages
    for i in stride(from: 0, to: intMessage.count, by: 8) {
      let startIndex = intMessage.index(intMessage.startIndex, offsetBy: i)
      let endIndex = intMessage.index(startIndex, offsetBy: 8, limitedBy: intMessage.endIndex) ?? intMessage.endIndex
      messages.append(String(intMessage[startIndex..<endIndex]))
    }

    var res = [Int]()

    for m in messages {
      res.append(Int(m) ?? 0)
    }

    return res
  }

  private func decode(_ message: String) -> String {
    var res = ""
    for i in stride(from: 0, to: message.count, by: 2) {
      let startIndex = message.index(message.startIndex, offsetBy: i)
      let endIndex = message.index(startIndex, offsetBy: 2, limitedBy: message.endIndex) ?? message.endIndex
      let temp = String(message[startIndex..<endIndex])
      if let key = symbols.someKey(forValue: temp) {
        res += String(key)
      } else {
        res += String(temp[temp.index(temp.startIndex, offsetBy: 1)])
      }
    }
    return res
  }

  private func fastExponentiation(base: Int, power: Int, mod: Int) -> Int {
    // maximum exponenet it needs to calculate
    let max: Int = Int(floor(log2(Double(power))))

    var vals = [Int]()

    // first element of vals is the base
    vals.append(base % mod)

    // keep squaring the previous element in mod @mod
    // and append to the list, @vals
    for i in 1...max {
      vals.append((vals[i-1]*vals[i-1]) % mod)
    }

    let binaryNum = String(power, radix: 2)
    var res = 1

    for (i, ch) in binaryNum.reversed().enumerated() {
      if ch == "1" {
        res *= vals[i]
        res %= mod
      }
    }

    return res
  }
}

extension Dictionary where Value: Equatable {
  func someKey(forValue val: Value) -> Key? {
    return first(where: { $1 == val })?.key
  }
}
