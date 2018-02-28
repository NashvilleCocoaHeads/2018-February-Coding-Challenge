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
