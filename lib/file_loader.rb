class FileLoader
  attr_reader :file_path

  def initialize(file_path)
    @file_path = file_path
    @file = reader(@file_path)
  end

  def reader(file_path)
    file = File.read(file_path).split
  end
end
