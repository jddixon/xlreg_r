
class XLRegException < StandardError
  attr :basicInfo

  def initialize(basicInfo, message)
    msg = basicInfo
    if ! message.nil?
      msg += ": " + message
    end
    # DEBUG
    $stderr.printf("XLReg init: msg is '%s'\n", msg)
    # END
    super(msg)
  end
end


class BadAttrsLine < XLRegException
  def initialize(message)
    super("bad attrs line", message)
  end
end
