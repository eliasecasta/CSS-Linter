class FileLoader
  attr_reader :content, :file_path

  def initialize(file_path)
    @file_path = file_path
    @content = reader(@file_path)
  end

  def reader(file_path)
    read_file = File.read(file_path)
    content = StringScanner.new(read_file)
    # p content.eos
    # p content.scan(r'\w+')
    # File.open(file_path, 'r') do |file|
    #   scanner= StringScanner.new(file.readline)
    #   until file.eof?
    #     scanner.scan(/}/)
    #     scanner << file.readline
    #   end
    #   scanner
    # end
  end
end
