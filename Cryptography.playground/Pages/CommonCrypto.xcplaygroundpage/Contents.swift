//: [Previous](@previous)

import Foundation
import CommonCrypto

/**
 
 `Passphrase`
 A password used to protect an identity key. After entered by a user or  administrator, a passphrase is mathematically
 converted into large number which serves as a key that is used to encrypt the identity key. In order to decrypt the
 identity, the passphrase must be entered again so that the same key can be regenerated for decryption.
 
 So passphrase is a secret which consists of some sequence of words or texts, it's longer.
 A passphrase can be said to an easier-to-remember password that is longer and therefore stronger.
 
 A passphrase is a sentencelike string of words used for authentication that is longer than a traditional password,
 easy to remember and difficult to crack. Typical passwords range, on average, from eight to 16 characters, while
 passphrases can reach up to 100 characters or more.
 
 Most common use-case for a passphrase is an encryption key. Passphrase being longer than a password, provides
 better protection against potential attempts to guess or crack it.
 
 Passphrases being generally longer are designed to be more resistant to brute-force attacks.
 
 Passphrases are often used to generate cryptographic keys through a key derivation function (KDF). This process
 makes it computationally expensive for an attacker to guess the passphrase.
 
 `Initialization Vector (IV)`
 
 */

func encryptData(data: Data, passphrase: String, salt: Data, iv: Data) throws -> Data {
    // Derive a key from the passphrase and salt using PBKDF2
    let key = try deriveKey(passphrase: passphrase, salt: salt)

    // Create a cipher context
    var cipherContext = CCCryptorRef()
    let algorithm = CCAlgorithm(kCCAlgorithmAES)
    let options = CCOptions(kCCOptionPKCS7Padding)

    // Perform encryption
    let status = data.withUnsafeBytes { (inputBytes: UnsafeRawBufferPointer) in
        key.withUnsafeBytes { (keyBytes: UnsafeRawBufferPointer) in
            iv.withUnsafeBytes { (ivBytes: UnsafeRawBufferPointer) in
                CCCryptorCreate(
                    CCOperation(kCCEncrypt),
                    algorithm,
                    options,
                    keyBytes.baseAddress,
                    key.count,
                    ivBytes.baseAddress,
                    inputBytes.baseAddress,
                    data.count,
                    nil,
                    0,
                    0,
                    &cipherContext
                )
            }
        }
    }

    guard status == kCCSuccess else {
        throw CryptoError.encryptionFailed
    }

    // Perform encryption and obtain the encrypted data
    var encryptedData = Data(count: data.count + kCCBlockSizeAES128)
    var encryptedDataLength = 0

    _ = try encryptedData.withUnsafeMutableBytes { (encryptedBytes: UnsafeMutableRawBufferPointer) in
        data.withUnsafeBytes { (inputBytes: UnsafeRawBufferPointer) in
            CCCryptorUpdate(
                cipherContext,
                inputBytes.baseAddress,
                data.count,
                encryptedBytes.baseAddress,
                encryptedBytes.count,
                &encryptedDataLength
            )
        }
    }

    // Finalize the encryption
    _ = try encryptedData.withUnsafeMutableBytes { (encryptedBytes: UnsafeMutableRawBufferPointer) in
        CCCryptorFinal(
            cipherContext,
            encryptedBytes.baseAddress,
            encryptedBytes.count,
            &encryptedDataLength
        )
    }

    // Release the cipher context
    CCCryptorRelease(cipherContext)

    // Trim the result to the actual encrypted data length
    encryptedData.count = encryptedDataLength

    return encryptedData
}

func deriveKey(passphrase: String, salt: Data) throws -> Data {
    var derivedKey = Data(count: kCCKeySizeAES256)
    let rounds = UInt32(kCCPBKDF2DefaultRounds)

    let status = passphrase.utf8.withContiguousStorageIfAvailable { (passphraseBytes) in
        salt.withUnsafeBytes { (saltBytes) in
            CCKeyDerivationPBKDF(
                CCPBKDFAlgorithm(kCCPBKDF2),
                passphraseBytes.baseAddress,
                passphraseBytes.count,
                saltBytes.baseAddress,
                saltBytes.count,
                CCPseudoRandomAlgorithm(kCCPRFHmacAlgSHA256),
                rounds,
                derivedKey.withUnsafeMutableBytes { $0.baseAddress },
                derivedKey.count
            )
        }
    }

    guard status == kCCSuccess else {
        throw CryptoError.keyDerivationFailed
    }

    return derivedKey
}

enum CryptoError: Error {
    case encryptionFailed
    case keyDerivationFailed
}

// Example usage
do {
    let dataToEncrypt = "Hello, World!".data(using: .utf8)!
    let passphrase = "SecretPassphrase"
    let salt = Data.random(count: 16) // Generate a random salt
    let iv = Data.random(count: kCCBlockSizeAES128) // Generate a random IV

    let encryptedData = try encryptData(data: dataToEncrypt, passphrase: passphrase, salt: salt, iv: iv)

    // Store the salt and IV securely along with the encrypted data
    print("Salt:", salt.base64EncodedString())
    print("IV:", iv.base64EncodedString())
    print("Encrypted Data:", encryptedData.base64EncodedString())
} catch {
    print("Error:", error)
}


//: [Next](@next)
