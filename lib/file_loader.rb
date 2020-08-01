class FileLoader
  attr_reader :file_path

  def initialize(file_path)
    @file_path = file_path
    @file = opener(@file_path)
  end

  def opener(file_path)
    file = File.read(file_path)
  end
end
