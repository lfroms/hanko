//
//  GPGContext.swift
//  GPGKit
//
//  Created by Lukas Romsicki on 2022-10-23.
//

import Foundation
import gpgme

/// A context within which all cryptographic operations are performed.
public class GPGContext {
    private var ctx: gpgme_ctx_t?
    
    /// Initializes the context with the given parameters.
    /// - Parameters:
    ///   - protocol: The protocol to use.
    ///   - armor: Whether to return text in ASCII armored format.
    ///   - textMode: Whether to inform the recipient that the input is text.
    ///   - keyListModes: The keylist modes to use.
    ///   - pinEntryMode: The pinentry mode to use.
    ///   - offline: Whether to disallow `dirmngr` from contacting external services.
    public init(
        protocol: Protocol? = nil,
        armor: Bool? = nil,
        textMode: Bool? = nil,
        keyListModes: [KeyListMode]? = nil,
        pinEntryMode: PinEntryMode? = nil,
        offline: Bool? = nil
    ) {
        gpgme_new(&ctx)
        
        if let `protocol` = `protocol` {
            gpgme_set_protocol(ctx, `protocol`.raw)
        }
        
        if let armor = armor {
            gpgme_set_armor(ctx, armor.int32)
        }
        
        if let textMode = textMode {
            gpgme_set_textmode(ctx, textMode.int32)
        }
        
        if let keyListModes = keyListModes {
            var keyListModesValue: UInt32 = 0
            
            keyListModes.forEach { mode in
                keyListModesValue = keyListModesValue | mode.raw
            }

            if keyListModesValue != 0 {
                gpgme_set_keylist_mode(ctx, keyListModesValue)
            }
        }
        
        if let pinEntryMode = pinEntryMode {
            gpgme_set_pinentry_mode(ctx, pinEntryMode.raw)
        }
        
        if let offline = offline {
            gpgme_set_offline(ctx, offline.int32)
        }
    }
    
    deinit {
        gpgme_release(ctx)
    }
    
    /// Returns a collection of keys matching the given parameters.
    /// - Parameters:
    ///   - pattern: The pattern by which to match keys.
    ///   - includingSecret: Whether to include secret keys.
    /// - Returns: An array of `Key`.
    public func keys(matching pattern: String? = nil, secret: Bool = false) -> [Key] {
        gpgme_op_keylist_start(ctx, pattern, secret.int32)
        
        var key: gpgme_key_t?
        var list: [Key] = []
        
        while gpgme_op_keylist_next(ctx, &key) == 0 {
            list.append(.init(from: key!))
        }
        
        gpgme_op_keylist_end(ctx)
        
        return list
    }
    
    /// Retrieves a single key with the given fingerprint.
    /// - Parameters:
    ///   - fingerprint: The fingerprint of the key to retrieve.
    ///   - includingSecret: Whether to include secret keys.
    /// - Returns: A single `Key` or `nil` if the key was not found.
    public func key(fingerprint: String, includingSecret: Bool = false) -> Key? {
        var key: gpgme_key_t?
        gpgme_get_key(ctx, fingerprint, &key, includingSecret.int32)
    
        guard let key = key else {
            return nil
        }
        
        return Key(from: key)
    }
    
    /// Generates a new key pair and stores it into the user's keyring.
    ///
    /// - Parameters:
    ///   - params: A string containing the payload to use when generating the key.
    public func generateKey(params: String) {
        let error = gpgme_op_genkey(ctx, params, nil, nil)
        print(gpgme_err_code(error))
    }
    
    /// Creates a key pair with the given parameters.
    /// - Parameters:
    ///   - userId: The user ID for the key.
    ///   - algorithm: The algorithm to use for the key pair.
    ///   - expires: The time before the key expires.
    ///   - flags: A collection of flags to use during key creation.
    public func createKey(userId: String, algorithm: String, expiresOn date: Date, flags: [CreateKeyFlag]) {
        var flagsValue: UInt32 = 0
        
        flags.forEach { flag in
            flagsValue = flagsValue | flag.value
        }
        
        gpgme_op_createkey(
            ctx,
            userId,
            algorithm,
            0,
            UInt(date.timeIntervalSince1970),
            nil,
            flagsValue
        )
    }
    
    /// Creates a new subkey for the given `key`.
    /// - Parameters:
    ///   - key: The `Key` to generate the subkey for.
    ///   - algorithm: The algorithm to use for the new key.
    ///   - expires: The time before the key expires.
    ///   - flags: A collection of flags to use during key creation.
    public func createSubkey(key: Key, algorithm: String, expiresOn date: Date, flags: [CreateKeyFlag]) {
        var flagsValue: UInt32 = 0
        
        flags.forEach { flag in
            flagsValue = flagsValue | flag.value
        }
        
        var keyReturned: gpgme_key_t?
        gpgme_get_key(ctx, key.fingerprint, &keyReturned, 1)
        
        let error = gpgme_op_createsubkey(
            ctx,
            keyReturned,
            algorithm,
            0,
            UInt(date.timeIntervalSince1970),
            flagsValue
        )
        
        print(gpgme_err_code(error))
    }
    
    /// Adds a new user ID to the given key.
    /// - Parameters:
    ///   - key: The key to add the user ID to.
    ///   - userId: The user ID to add.
    public func addUserId(key: Key, userId: String) {
        var keyReturned: gpgme_key_t?
        gpgme_get_key(ctx, key.fingerprint, &keyReturned, 1)
    
        gpgme_op_adduid(ctx, keyReturned, userId, 0)
    }
    
    /// Revokes the given user ID from the given key.
    /// - Parameters:
    ///   - key: The key to remove the user ID from.
    ///   - userId: The user ID to remove.
    public func revokeUserId(key: Key, userId: String) {
        var keyReturned: gpgme_key_t?
        gpgme_get_key(ctx, key.fingerprint, &keyReturned, 1)
        
        gpgme_op_revuid(ctx, keyReturned, userId, 0)
    }
    
    /// Sets a flag on the given user ID.
    /// - Parameters:
    ///   - key: The key to which the user ID belongs.
    ///   - userId: The user ID to add the flag to.
    ///   - name: The name of the flag to add.
    ///   - value: The value of the flag.
    public func setUserIdFlag(key: Key, userId: String, named name: String, withValue value: String) {
        var keyReturned: gpgme_key_t?
        gpgme_get_key(ctx, key.fingerprint, &keyReturned, 1)
        
        gpgme_op_set_uid_flag(ctx, keyReturned, userId, name, value)
    }
    
    /// Deletes a key.
    /// - Parameters:
    ///   - key: The key to delete.
    ///   - allowSecret: Whether to also delete the secret key.
    public func deleteKey(key: Key, allowSecret: Bool) {
        var keyReturned: gpgme_key_t?
        gpgme_get_key(ctx, key.fingerprint, &keyReturned, 1)
        
        gpgme_op_delete(ctx, keyReturned, allowSecret.int32)
    }
}
