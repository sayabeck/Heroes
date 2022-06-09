//
//  Hero.swift
//  Heroes
//
//  Created by mac mini on 6/6/22.
//

struct Hero: Decodable {
    let name: String?
    let powerstats: Powerstats?
    let appearance: Appearance?
    let biography: Biography?
    let images: Images?
}

struct Powerstats: Decodable {
    
    let intelligence: Int
    let strength: Int
    let speed: Int
    let durability: Int
    let power: Int
    let combat: Int
}

struct Appearance: Decodable {
    let gender: String
    let race: String?
    let height: [String]
    let weight: [String]
}

struct Biography: Decodable {
    let fullName: String
    let alterEgos: String
    let placeOfBirth: String
    let firstAppearance: String
    let publisher: String?
    let alignment: String
}

struct Images: Decodable {
    let xs: String
    let md: String
    let sm: String
    let lg: String
}
