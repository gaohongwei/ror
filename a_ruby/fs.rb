 def get_filename(filename='app/models/task_time.rb')
   path=File.dirname(filename)
   filename=File.basename(filename)     
   ext  = File.extname(filename)
   fname = File.basename(filename, ext)
   file_list=Dir["#{path}/#{fname}*#{ext}"]
   related_file_indexes = []
   file_list.each  do |file|
     if File.basename(file).include?(fname) && 
        File.extname(file) == ext
       related_file_indexes << file.split("-").last.to_i
     end
   end
   fname +='-' + (related_file_indexes.max + 1).to_s + ext
   File.join(path,fname)
 end

p='app/models/task_time.rb'
get_filename(p)
