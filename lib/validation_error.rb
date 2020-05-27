class ValidationError < StandardError
    def initialize(error_message)
        @errors=error_message
    end
    def message
      @errors
    end
  end