//
//  ExtendedEuclidean.swift
//  CryptoSimulation
//
//  Created by Kento Akazawa on 11/10/23.
//

import Foundation

class ExtendedEuclidean {

  // MARK: - Properties

  var p = -1
  var q = -1
  var n = -1
  var phiN = -1
  var d = -1
  var e = -1

  // MARK: - Initialization

  init(p: Int = 1, q: Int = 1, n: Int = 1, phiN: Int = 1, d: Int = 1, e: Int = 1) {
    self.p = p
    self.q = q
    self.n = n
    self.phiN = phiN
    self.d = d
    self.e = e

    self.setup()
  }

  // MARK: - Public Functions

  func setup() {
    p = VariableGenerator.shared.getPrimeNumber()
    q = VariableGenerator.shared.getPrimeNumber()
    n = p*q
    phiN = (p-1)*(q-1)
    d = VariableGenerator.shared.getPrimeNumber()
    e = getInverse(of: d, in: phiN)
  }

  // MARK: - Private Functions

  // Returns the inverse of @d in mod @phiN using Euclidean algorithm
  private func getInverse(of d: Int, in phiN: Int) -> Int {
    var r1 = phiN
    var r2 = d
    var q: Int
    var t1 = 0
    var t2 = 1

    // run Euclidean algorithm until the remainder becomes 0
    // in which case t2 will store the inverse of initial r2 (d)
    while r2 != 1 {
      q = r1/r2
      var temp = r2
      r2 = r1%r2
      r1 = temp

      temp = t2
      t2 = t1-q*t2
      t1 = temp
    }

    while t2 <= 0 {
      t2 += phiN
    }

    return t2
  }
}
