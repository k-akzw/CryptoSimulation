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

  // list of prime numbers
  var primeNumbers = [Int]()
  // min and max value of prime number to generate
  private let primeLower = 4000
  private let primeUpper = 10000

  // MARK: - Initialization

  override init() {
    super.init()
    // generate all prime number between @primeLower and @primeUpper
    // and store them in @primeNumbers
    primeNumbers = generatePrimeNumbers(between: primeLower, and: primeUpper)
  }

  // MARK: - Public Functions

  // returns random prime number from @primeNumbers list
  func getPrimeNumber() -> Int {
    // if there is no prime number in @primeNumber
    // Note: should not run
    if primeNumbers.isEmpty {
      print("VariableGenerator getPrimeNumber() - there is no prime numbers")
      return -1
    }

    // generate random number between index range
    // and return prime number at that index
    let index = Int.random(in: 0..<primeNumbers.count)
    return primeNumbers[index]
  }

  // MARK: - Private Functions

  // Generates all prime numbers between
  private func generatePrimeNumbers(between lower: Int, and upper: Int) -> [Int] {
    var primes = [Int]()

    // check all numbers between @lower and @upper
    // if that number is a prime number
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
