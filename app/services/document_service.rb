module DocumentService
  module_function

  def convert(file)
    extension = file.extension.name
    return convert_html(file) if extension == 'html'
    dir_name = File.dirname(file.file.path)
    file_name = File.basename(file.file.path, File.extname(file.file.path))
    conv = system("soffice --invisible --headless --convert-to #{extension} #{file.file.path} --outdir #{dir_name}")
    return unless conv
    file.file = open("#{dir_name}/#{file_name}.#{extension}")
    file.save
    file
  end

  def convert_html(file)
    dir_name = File.dirname(file.file.path)
    Kristin.convert(file.file.path, "public/tmp/converted_file/file/#{file.id}/#{file.file.uploaded_filename}.html")
    file.file = open("#{dir_name}/#{file.file.uploaded_filename}.html")
    file.save
    file
  end
end
