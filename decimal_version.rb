# xlreg_r/decimal_version.rb

require 'bindata'

# See bindata wiki.  Note particularly the array: f field in the example,
# which is :uint32.  Also note how PascalStringReader is implemented,
# with the length returned by :read_length

class DecimalVersion < BinData::Record
  endian :big
  uint32 :val

  def initialize(aIn, bIn, cIn, dIn)
    raise if aIn.nil?
    raise unless aIn.is_a(Numeric)
    raise unless (0 <= aIn) && (aIn < 256)
    a = aIn

    if bIn.nil? 
      a = 0
    else  
      raise unless bIn.is_a(Numeric)
      raise unless (0 <= bIn) && (bIn < 256)
      b = bIn
    end

    if cIn.nil?
      c = nil
    else
      raise unless cIn.is_a(Numeric)
      raise unless (0 <= cIn) && (cIn < 256)
      b = bIn
      c = cIn
    end

    if dIn.nil?
      d = 0
    else
      raise unless dIn.is_a(Numeric)
      raise unless (0 <= dIn) && (dIn < 256)
      d = dIn
    end

    @val = a | (b << 8) | (c << 16) | (d << 24)     
  end

  def getA()
    return @val & 0xff
  end

  def getB()
    return (@val >> 8) & 0xff
  end

  def getC()
    return (@val >> 16) & 0xff
  end

  def getD()
    return (@val >> 24) & 0xff
  end

end
