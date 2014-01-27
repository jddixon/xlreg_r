# xlreg_r/decimal_version.rb

class DecimalVersion

  @value = 0

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

    @value = a | (b << 8) | (c << 16) | (d << 24)     
  end

  def getA()
    return @value & 0xff
  end

  def getB()
    return (@value >> 8) & 0xff
  end

  def getC()
    return (@value >> 16) & 0xff
  end

  def getD()
    return (@value >> 24) & 0xff
  end

end
