require_relative '../lib/linter_rules.rb'
require_relative '../lib/file_loader.rb'

describe LinterRules do
  include LinterRules
  let(:spacing_arr) do
    ["On line 1 missing space before '{' opening curly bracket",
     "On line 2 missing space after ':' colon",
     "On line 2 a(n) ';' semi-colon should not have space(s) before it",
     "On line 3 a(n) '(' opening parentheses should not have space(s) surrounding it",
     "On line 3 missing space after ',' ",
     "On line 3 a(n) ')' closing parentheses should not have space(s) surrounding it"]
  end
  let(:eof_arr) do
    ["On line 17 missing newline after '}' closing curly bracket",
     "EOF Error: 'The file is missing a newline at the end of the file.'"]
  end
  let(:err_string) { "On line 5 a(n) '}' closing curly bracket should not have space(s) before it" }
  let(:nl_arr) do
    [
      "On line 1 missing newline after '{' opening curly bracket",
      "On line 1 missing newline after ';' semi-colon",
      "On line 1 missing newline after ';' semi-colon",
      "On line 1 missing newline after ';' semi-colon",
      "On line 1 missing newline after ';' semi-colon",
      "On line 1 missing newline before '}' closing curly bracket",
      "On line 1 missing newline after '}' closing curly bracket",
      "On line 1 missing newline after '{' opening curly bracket",
      "On line 1 missing newline after ';' semi-colon",
      "On line 1 missing newline after ';' semi-colon",
      "On line 1 missing newline after ';' semi-colon",
      "On line 1 missing newline before '}' closing curly bracket",
      "On line 1 missing newline after '}' closing curly bracket",
      "On line 1 missing newline after '{' opening curly bracket",
      "On line 1 missing newline after ';' semi-colon",
      "On line 1 missing newline before '}' closing curly bracket",
      "On line 1 missing newline after '}' closing curly bracket",
      "On line 1 missing newline after '{' opening curly bracket",
      "On line 1 missing newline after ';' semi-colon",
      "On line 1 missing newline before '}' closing curly bracket"
    ]
  end
  describe '#EOF check' do
    it 'Returns an error text which specifies that the file is missing an empty newline at the end of the file' do
      file_to_open = 'spec/test_files/eof.css'
      file = FileLoader.new(file_to_open)
      expect(linter(file.content)).to eql(eof_arr)
    end
  end

  describe '#err_msg' do
    it 'Returns an error message created with the given values' do
      expect(err_msg(1, 5, '}', 'bf')).to eql(err_string)
    end
  end

  describe '#Spacing check' do
    it 'Returns an array with all the spacing errors found' do
      file_to_open = 'spec/test_files/spacing.css'
      file = FileLoader.new(file_to_open)
      expect(linter(file.content)).to eql(spacing_arr)
    end
  end

  describe '#Spacing check' do
    it 'Returns an array with all the newline errors found' do
      file_to_open = 'spec/test_files/newline.css'
      file = FileLoader.new(file_to_open)
      expect(linter(file.content)).to eql(nl_arr)
    end
  end

  describe '#Error Printer' do
    it 'Return no linting errors found' do
      expect(error_printer([])).to eql('The file does not present any linting errors')
    end
  end
end
