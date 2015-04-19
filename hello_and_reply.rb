# xlreg_rb/hello_and_reply.rb

def clientEncryptHello(version, key)
  # Create a 56-byte random value, where iv is 16, aesKey is 32, 
  # salt is 8.  Append the version number, a little-endian 4-btye
  # integer.  This becomes msg.

  # XXX STUB

  # Returns a string, construed as a byte array.  To clarify an
  # obscure point: PKCS#1 v2.0 adds support for OAEP encoding and
  # so is sometimes called PKCS1.2.  PKCS#1 without OAEP is called
  # PKCS#1 v1.5.  But PKCS#1 implementations support both.
  #
  key.public_encrypt(msg, OpenSSL::PKey::RSA::PKCS1_OAEP_PADDING)
