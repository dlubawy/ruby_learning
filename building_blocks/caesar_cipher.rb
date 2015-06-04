def caesar_cipher(*inputs, value)
  inputs.each do |input|
    i = 0
    while i < input.length
      input_byte = input[i].ord
      byte_change = input_byte + (value % 26)

      if (input_byte >= 'a'.ord && input_byte <= 'z'.ord) && byte_change > 122
        byte_change = (byte_change - 122) + 96
        input[i] = byte_change.chr
      elsif (input_byte >= 'A'.ord && input_byte <= 'Z'.ord) && byte_change > 90
        byte_change = (byte_change - 90) + 65
        input[i] = byte_change.chr
      elsif (input_byte >= 'a'.ord && input_byte <= 'z'.ord) || (input_byte >= 'A'.ord && input_byte <= 'Z'.ord)
        input[i] = byte_change.chr
      else
        input[i] = input[i]
      end
      i += 1
    end
  end
  inputs.join(' ').strip
end
