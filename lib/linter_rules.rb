require 'strscan'

require 'awesome_print'

module LinterRules
  def linter(content)
    arr = content.string.split('')
    err_arr = []
    line_counter = 1
    arr.each_with_index do |v, i|
      line_counter += 1 if v == "\n"
      if v == '{' || v == '}'
        err_arr << err_msg(0, line_counter, v, 'bf', 'spc') if arr[i - 1] != ' ' && v == '{'
        err_arr << err_msg(0, line_counter, v, 'af', 'nl') if arr[i + 1] != "\n" && v == '{'
        err_arr << err_msg(0, line_counter, v, 'bf', 'nl') if arr[i - 1] != "\n" && v == '}'
        err_arr << err_msg(0, line_counter, v, 'af', 'nl') if arr[i + 1] != "\n" and v == '}'
      elsif v == '(' || v == ')'
        if (arr[i - 1] == ' ' && v == '(') || (arr[i + 1] == ' ' && v == '(')
          err_arr << err_msg(1, line_counter, v, 'surr')
        end
        if (arr[i - 1] == ' ' && v == ')') || (arr[i + 1] == ' ' && v == ')')
          err_arr << err_msg(1, line_counter, v, 'surr')
        end
      elsif v == ':'
        err_arr << err_msg(1, line_counter, v, 'bf') if arr[i - 1] == ' ' && v == ':'
        err_arr << err_msg(0, line_counter, v, 'af', 'spc') if arr[i + 1] != ' ' && v == ':'
      elsif v == ';'
        err_arr << err_msg(1, line_counter, v, 'bf') if arr[i - 1] == ' ' && v == ';'
        err_arr << err_msg(0, line_counter, v, 'af', 'nl') if arr[i + 1] != "\n" && v == ';'
      end
    end

    if err_arr.empty? == false
      ap err_arr
    elsif err_arr == []
      ap 'The file does not present any linting errors'
    end
    ap "EOF Error: 'The file is missing a newline at the end of the file.'" if arr[-1] != "\n"
  end

  def err_msg(option, line_numb, value, bf_af_surr, spc_nl = nil)
    sym_name = { '{' => 'opening curly bracket', '}' => 'closing curly bracket',
                 '(' => 'opening parentheses', ')' => 'closing parentheses',
                 ':' => 'colon', ';' => 'semi-colon',
                 'spc' => 'space', 'nl' => 'newline',
                 'bf' => 'before', 'af' => 'after',
                 'surr' => 'surrounding' }
    if option.zero?
      "On line #{line_numb} missing #{sym_name[spc_nl]} #{sym_name[bf_af_surr]} '#{value}' #{sym_name[value]}"
    else "On line #{line_numb} a(n) '#{value}' #{sym_name[value]} should not have space(s) #{sym_name[bf_af_surr]} it"
    end
  end
end
