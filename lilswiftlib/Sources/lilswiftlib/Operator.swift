//
//  Operator.swift
//
//
//  Created by Lilly Cham on 01/02/2023.
//

import Foundation

precedencegroup ForwardPipePrecedence {
  associativity: left
}

precedencegroup BackPipePrecedence {
  associativity: right
}

infix operator |>: ForwardPipePrecedence
func |> <A, B>(lhs: A, rhs: (A) -> B) -> B {
  rhs(lhs)
}

infix operator <|: BackPipePrecedence
func <| <A, B>(lhs: (A) -> B, rhs: A) -> B {
  lhs(rhs)
}

precedencegroup FmapPrecedence {
  associativity: left
}

infix operator .<>.: FmapPrecedence
func .<>. <A, B>(lhs: (A) -> B, rhs: [A]) -> [B] {
  rhs.map(lhs)
}

infix operator <&>: FmapPrecedence
func <&> <A, B>(lhs: [A], rhs: (A) -> B) -> [B] {
  lhs.map(rhs)
}
