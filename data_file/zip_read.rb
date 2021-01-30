body = File.read('my.zip')
def read_from_string(body)
  Zip::InputStream.open(StringIO.new(body)) do |io|
    while (entry = io.get_next_entry)
      puts "Entry: #{entry.name}"
      puts io.read
    end
  end
end

def read_from_zip_file(zip_file)
  Zip::InputStream.open(zip_file) do |io|
    while (entry = io.get_next_entry)
      puts "Entry: #{entry.name}"
      puts io.read
    end
  end
end


Zip::File.open('fs.zip') do |zip_file|
  # Handle entries one by one
  zip_file.each do |entry|
    # Extract to file/directory/symlink
    puts "Extracting #{entry.name}"
    entry.extract(dest_file)

    # Read into memory
    content = entry.get_input_stream.read
  end

end
