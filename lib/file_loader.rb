class FileLoader
  attr_reader :content, :file_path

  def initialize(file_path)
    @file_path = file_path
    @content = reader(@file_path)
  end

  def reader(file_path)
    read_file = File.read(file_path)
    content = StringScanner.new(read_file)
  end
end
