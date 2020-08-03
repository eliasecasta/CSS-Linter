require 'strscan'
require 'awesome_print'

module LinterRules
  def linter(content)
    # File.foreach(content) do |line|
    #   puts line
    # end

    arr = content.string.split("")
    # p arr
    err_arr = []
    line_counter = 1
    bracket_arr = {}
    arr.each_with_index do |v, i|
      line_counter += 1 if v == "\n"
      # p v,i, line_counter
      if v == "{" || v == "}"
        # err_arr << "On line #{line_counter} missing space before #{v} opening curly bracket" if arr[i-1] != ' ' && v == "{"
        err_arr << err_msg(0, line_counter, v, "bf", "spc") if arr[i-1] != ' ' && v == "{"
        # err_arr << "On line #{line_counter} missing newline after '#{v}' opening curly bracket" if arr[i+1] != "\n" && v == "{"
        err_arr << err_msg(0, line_counter, v, "af", "nl") if arr[i+1] != "\n" && v == "{"
        # err_arr << "On line #{line_counter} missing newline before '#{v}' closing curly bracket" if arr[i-1] != "\n" && v == "}"
        err_arr << err_msg(0, line_counter, v, "bf", "nl") if arr[i-1] != "\n" && v == "}"
        # err_arr << "On line #{line_counter} missing newline after '#{v}' closing curly bracket" if arr[i+1] != "\n" and v == "}"
        err_arr << err_msg(0, line_counter, v, "af", "nl") if arr[i+1] != "\n" and v == "}"
        # bracket_arr[line_counter] = v  if v == "{" || v == "("
        # bracket_arr.delete(bracket_arr.to_a.last[0]) if bracket_arr.to_a.last[1] == "{" && v == "}"
        # bracket_arr.delete(bracket_arr.to_a.last[0]) if bracket_arr.to_a.last[1] == "(" && v == ")"
      elsif v == "(" || v == ")"
        # err_arr << "On line #{line_counter} an '#{v}' opening parentheses should not have spaces surrounding it" if (arr[i-1] == ' ' && v == "(") || (arr[i+1] == ' ' && v == "(")
        err_arr << err_msg(1, line_counter, v, "surr") if (arr[i-1] == ' ' && v == "(") || (arr[i+1] == ' ' && v == "(")
        # err_arr << "On line #{line_counter} a '#{v}' closing parentheses should not have spaces surrounding it" if (arr[i-1] == ' ' && v == ")") || (arr[i+1] == ' ' && v == ")")
        err_arr << err_msg(1, line_counter, v, "surr") if (arr[i-1] == ' ' && v == ")") || (arr[i+1] == ' ' && v == ")")
      elsif v == ":"
        # err_arr << "On line #{line_counter} a '#{v}' colon should not have space before it" if arr[i-1] == ' ' && v == ":"
        err_arr << err_msg(1, line_counter, v, "bf") if arr[i-1] == ' ' && v == ":"
        # err_arr << "On line #{line_counter} a '#{v}' colon should have one space after it" if arr[i+1] != ' ' && v == ":"
        err_arr << err_msg(0, line_counter, v, "af", "spc") if arr[i+1] != ' ' && v == ":"
      elsif v == ";"
        # err_arr << "On line #{line_counter} a '#{v}' semi-colon should not have space before it" if arr[i-1] == ' ' && v == ";"
        err_arr << err_msg(1, line_counter, v, "bf") if arr[i-1] == ' ' && v == ";"
        # err_arr << "On line #{line_counter} missing newline after '#{v}' semi-colon" if arr[i+1] != "\n" && v == ";"
        err_arr << err_msg(0, line_counter, v, "af", "nl") if arr[i+1] != "\n" && v == ";"
      end
    end
    # err_arr << "Missing closing bracket or parentheses for opening bracket on line #{bracket_arr.to_a.last[0]}" unless bracket_arr.empty?
    if err_arr.empty? == false
      ap err_arr
    elsif err_arr == []
      ap "The file does not present any linting errors"
    end

    if arr[-1] != "\n"
      ap "EOF Error: 'The file is missing a newline at the end of the file.'"
    end
  end

  def err_msg(option, line_numb, value, bf_af_surr, spc_nl=nil)

    sym_name = {"{" => "opening curly bracket", "}" => "closing curly bracket",
    "(" => "opening parentheses",")" => "closing parentheses",
    ":" => "colon", ";" => "semi-colon",
     "spc" => "space","nl"=>"newline",
    "bf" => "before", "af" =>"after",
    "surr" => "surrounding"
    }

    if option.zero?
      "On line #{line_numb} missing #{sym_name[spc_nl]} #{sym_name[bf_af_surr]} '#{value}' #{sym_name[value]}"
    else "On line #{line_numb} a(n) '#{value}' #{sym_name[value]} should not have space(s) #{sym_name[bf_af_surr]} it"
    end
  end
end