from Crypto.Hash import SHA256
from Crypto.Cipher import AES

# Valeurs données
nonce = bytes.fromhex('4242424242424242424242424242424242424242424242424242424242424242')
write_value = bytes.fromhex('004265207374726F6E6720616E64207265616420646174617368656574732061')
encrypted_flag_cipher = bytes.fromhex('40878CBD30C22E590EFB1C9448A3B3AA')

# Concatenation du nonce et de la valeur écrite
data_to_hash = nonce + write_value

# Calcul du hash SHA256
hash_object = SHA256.new(data_to_hash)
TempKey_final = hash_object.digest()

# Déchiffrement du flag
cipher = AES.new(TempKey_final, AES.MODE_ECB)
decrypted_flag = cipher.decrypt(encrypted_flag_cipher)

print("Decrypted Flag:", decrypted_flag.decode())

