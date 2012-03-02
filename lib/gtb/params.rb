module Gtb
  module Params

    def param_normalize(*str)
      str.join(' ').scan(/([a-zA-Z0-9]+)+/).join('-')
    end

  end
end
