module MediaService
  module_function

  def convert(file)
    dir_name = File.dirname(file.file.path)
    extension = file.extension.name
    file_name = File.basename(file.file.path, File.extname(file.file.path))
    conv = system("ffmpeg -y -i #{file.file.path} -f #{extension} #{dir_name}/#{file_name}.#{extension}")
    return unless conv
    file.file = open("#{dir_name}/#{file_name}.#{extension}")
    file.save
    file
  end
end
