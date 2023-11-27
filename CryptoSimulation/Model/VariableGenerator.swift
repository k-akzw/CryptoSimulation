//
//  VariableGenerator.swift
//  CryptoSimulation
//
//  Created by Kento Akazawa on 11/10/23.
//

import Foundation

class VariableGenerator: NSObject {

  // Singleton instance of this class
  static let shared: VariableGenerator = VariableGenerator()

  // MARK: - Properties

  var primeNumbers = [Int]()
  private let primeLower = 4000
  private let primeUpper = 8000

  // MARK: - Initialization

  override init() {
    super.init()
    primeNumbers = generatePrimeNumbers(between: primeLower, and: primeUpper)
  }

  // MARK: - Public Functions

  // returns random prime number from @primeNumbers list
  func getPrimeNumber() -> Int {
    if primeNumbers.isEmpty {
      print("VariableGenerator getPrimeNumber() - there is no prime numbers")
      return -1
    }

    let index = Int.random(in: 0..<primeNumbers.count)
    return primeNumbers[index]
  }

  // MARK: - Private Functions

  // Generates all prime numbers between
  private func generatePrimeNumbers(between lower: Int, and upper: Int) -> [Int] {
    var primes = [Int]()

    for i in lower...upper {
      if isPrime(i) {
        primes.append(i)
      }
    }

    return primes
  }

  // Checks if @num is prime
  private func isPrime(_ num: Int) -> Bool {
    // any number less than 2 is not prime
    if num <= 2 {
      return false
    }

    // divides by all numbers less than @num
    // if the remainder becomes 0 at any point
    // that means @num is divisible by some number
    // so return false
    for i in 2..<num {
      if num % i == 0 {
        return false
      }
    }

    return true
  }
}
