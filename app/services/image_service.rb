require 'RMagick'
require 'zip'
module ImageService
  module_function

  def convert(file)
    im = Magick::Image.read(file.file.path)
    prepared_file =
      if im.count > 1
        create_zip(im, file)
      else
        create_file(im.first, file)
      end
    file.file = prepared_file
    file.save
    file
  end

  def create_zip(im, file)
    dir_name = File.dirname(file.file.path)
    zipfile_name = "#{dir_name}/#{file.file.uploaded_filename}.zip"
    Zip::File.open(zipfile_name, Zip::File::CREATE) do |zipfile|
      im.each_with_index do |image, index|
        image.format = file.extension.name
        new_name = "#{file.file.uploaded_filename}_#{index}.#{file.extension.name}"
        new_file = image.write("public/tmp/converted_file/file/#{file.id}/#{new_name}")
        zipfile.add(new_name, dir_name + '/' + new_name)
      end
    end
    open(zipfile_name)
  end

  def create_file(image, file)
    dir_name = File.dirname(file.file.path)
    new_name = file.file.uploaded_filename + ".#{file.extension.name}"
    image.format = file.extension.name
    image.write("public/tmp/converted_file/file/#{file.id}/#{new_name}")
    open("#{dir_name}/#{new_name}")
  end
end
