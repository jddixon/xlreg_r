# xlreg_r/hello_and_reply.rb

def clientEncryptHello(version, key)
  # Create a 56-byte random value, where iv is 16, aesKey is 32, 
  # salt is 8.  Append the version number, a little-endian 4-btye
  # integer.  This becomes msg.

  # XXX STUB

  # returns a string, construed as a byte array
  key.public_encrypt(msg, OpenSSL::PKey::RSA::PKCS1_OAEP_PADDING)
