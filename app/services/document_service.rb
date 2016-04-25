module DocumentService
  module_function

  def convert(file)
    dir_name = File.dirname(file.file.path)
    file_name = File.basename(file.file.path, File.extname(file.file.path))
    extension = file.extension.name
    new_file =
      case extension
      when 'html'
        convert_html(file, dir_name, file_name)
      when 'docx', 'doc'
        convert_word(file, dir_name, file_name)
      else
        system("soffice --invisible --headless --convert-to #{extension} #{file.file.path} --outdir #{dir_name}")
        open("#{dir_name}/#{file_name}.#{extension}")
      end
    file.file = new_file
    file.save
    file
  end

  def convert_html(file, dir_name, file_name)
    system("pdftohtml -i -noframes -q -p -c #{dir_name}/#{file.file.uploaded_filename}")
    open("#{dir_name}/#{file_name}.html")
  end

  def convert_word(file, dir_name, file_name)
    extension = file.extension.name
    system("pdftohtml -i -noframes -q -p -c #{dir_name}/#{file.file.uploaded_filename}")
    system("pandoc -s #{dir_name}/#{file_name}.html -o #{dir_name}/#{file_name}.#{extension}")
    open("#{dir_name}/#{file_name}.#{extension}")
  end
end
