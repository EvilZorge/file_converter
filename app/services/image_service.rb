require 'RMagick'
require 'zip'
module ImageService
  module_function

  def convert(file)
    images = Magick::Image.read(file.file.path)
    extension = file.extension.name
    dir_name = File.dirname(file.file.path)
    prepared_file =
      if images.count > 1
        create_zip(images, file, extension, dir_name)
      else
        create_file(images.first, file, extension, dir_name)
      end
    file.file = prepared_file
    file.save
    file
  end

  def create_zip(images, file, extension, dir_name)
    zipfile_name = "#{dir_name}/#{file.file.uploaded_filename}.zip"
    Zip::File.open(zipfile_name, Zip::File::CREATE) do |zipfile|
      images.each_with_index do |image, index|
        image.format = extension
        new_name = "#{file.file.uploaded_filename}_#{index}.#{extension}"
        image.write("public/tmp/converted_file/file/#{file.id}/#{new_name}")
        zipfile.add(new_name, dir_name + '/' + new_name)
      end
    end
    open(zipfile_name)
  end

  def create_file(image, file, extension, dir_name)
    new_name = file.file.uploaded_filename + ".#{extension}"
    image.format = extension
    image.write("public/tmp/converted_file/file/#{file.id}/#{new_name}")
    open("#{dir_name}/#{new_name}")
  end
end
