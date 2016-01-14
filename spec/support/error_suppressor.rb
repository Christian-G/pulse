class ErrorSuppressor

  SUPPRESS_THESE_ERRORS = [
      'QFont::setPixelSize: Pixel size <= 0 (0)',
  ]

  class << self
    def write(message)
      if SUPPRESS_THESE_ERRORS.include? message
        0
      else
        @errors ||= []
        @errors << message
        message.length
      end
    end

    def dump_errors
      if @errors
        puts
        puts "Suppressed errors from QT while running specs:"

        @errors.each do |error|
          puts error
        end
      end
    end
  end
end
