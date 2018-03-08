import Foundation

/*:
 # Nashville CocoaHeads Coding Challenge
 _February 2018_

 This month we learned about `Codable`, an awesome new protocol in Swift 4.
 Using this protocol, we can easily decode data from external sources (e.g. JSON from an API)
 into structures within our code (and go back the other way).

 The challenge this month is to build on the SWAPI Character example that Blake presented by
 adding all of the other properties that the API supports.

 ### Challenge

 - Flesh out the SWCharacter model with the remaining properties specified in the JSON spec in `CharacterData.swift`.
 - Successfully decode a `SWCharacter` type.
 - Successfully re-encode a `SWCharacter` back to raw data.
 - Newly re-encoded data must match the original character data that you decoded.

 ### Minimum Requirements

 - All properties currently supported by the API must be decoded/encoded.
 - All URLs must be type safe.
 - All Dates must be type safe.

 ### Bonus Requirements

 Feel free to extend you example with any or all of the following for internet points:

 - Make genders type safe.
 - Make colors type safe.

 */

struct SWCharacter: Codable {

    private enum CodingKeys: String, CodingKey {
        case name
        case height
        case mass
        case hairColor = "hair_color"
        case skinColor = "skin_color"
        case eyeColor = "eye_color"
        case birthYear = "birth_year"
        case gender
        case homeworld
        case films
        case species
        case vehicles
        case starships
        case created
        case edited
        case url
    }

    let name: String
    let height: String
    let mass: String
    let hairColor: String
    let skinColor: String
    let eyeColor: String
    let birthYear: String
    let gender: String
    let homeworld: URL
    let films: [URL]
    let species: [URL]
    let vehicles: [URL]
    let starships: [URL]
    let created: Date
    let edited: Date
    let url: URL
}

extension SWCharacter {
    static func ==(_ lhs: SWCharacter, _ rhs: SWCharacter) -> Bool {
        return (
            lhs.name == rhs.name &&
            lhs.height == rhs.height &&
            lhs.mass == rhs.mass &&
            lhs.hairColor == rhs.hairColor &&
            lhs.skinColor == rhs.skinColor &&
            lhs.eyeColor == rhs.eyeColor &&
            lhs.birthYear == rhs.birthYear &&
            lhs.gender == rhs.gender &&
            lhs.homeworld == rhs.homeworld &&
            lhs.films == rhs.films &&
            lhs.species == rhs.species &&
            lhs.vehicles == rhs.vehicles &&
            lhs.starships == rhs.starships &&
            lhs.created == rhs.created &&
            lhs.edited == rhs.edited &&
            lhs.url == rhs.url
        )
    }
}


struct SWAPIConstants {
    static var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        return dateFormatter
    }
}
//: A helper function that decodes a `SWCharacter` from raw `Data`.
//: > Hint: You may need to edit this function. 😉
func decodeCharacter(from data: Data) -> SWCharacter? {
    do {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(SWAPIConstants.dateFormatter)
        
        let character = try decoder.decode(SWCharacter.self, from: data)
        return character
    }
    catch {
        print("Error Decoding: \(error.localizedDescription)")
        return nil
    }
}

//: A helper function that encodes a `SWCharacter` to raw `Data`.
//: > Hint: You may need to edit this function. 😉
func encodeCharacter(_ character: SWCharacter) -> Data? {
    do {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .formatted(SWAPIConstants.dateFormatter)
        
        let characterData = try encoder.encode(character)
        return characterData
    }
    catch {
        print("Error Encoding: \(error.localizedDescription)")
        return nil
    }
}

/*:
 ### Validation Code

 Below is all of the logic that determines if the data is decoded and re-encoded correctly.
 You should not need to edit any code below this point.

 Freshly cloned, this playground should show a successful decode and encode.
 */

// Validate that we can decode a SWCharacter.
guard let character = decodeCharacter(from: originalCharacterData) else {
    fatalError("💥 Unable to decode a SWCharacter!")
}

// Validate that we can re-encode a SWCharacter back to data.
guard let newCharacterData = encodeCharacter(character) else {
    fatalError("💥 Unable to encode a SWCharacter!")
}

//// Validate that we can re-decode a SWCharacter from our data.
guard let newCharacter = decodeCharacter(from: newCharacterData) else {
    fatalError("💥 Unable to decode a SWCharacter!")
}

// Validate that our original character & re-encoded character match.
guard character == newCharacter else {
    fatalError("💥 Re-encoded character did not match originally decoded character!")
}

print("🎉🎉🎉 Success! Everying decoded and re-encoded successfully! 🎉🎉🎉")
