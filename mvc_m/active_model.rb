class SActiveModel 
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end
  
  def persisted?
    false
  end
end

#require 'sactive-model'
class Backup < SActiveModel
  attr_accessor :media, :size, :source, :title,:id,:share,:user,:password
                validates_presence_of :user,:password
                @@SAVE_BACKUP='explorer'
                @@SAVE_RESTORE='explorer'  
                def self.shares
                                ar=['share1',       'share2','share3','share4','share5']
                                arr=[]
                                ar.each_with_index do|e,i|
                                                arr << [e,i]
                                end
                                arr
                end
                def self.backups
                                ar=[]
                end
                def self.save_restore
                                system(@@SAVE_BACKUP)
                end        
                def self.save_backup
                                system(@@SAVE_RESTORE)
                end
                def self.images
                                ar=[]
                                dir=Rails.root.join('app', 'assets','ads').to_s
                                path='/assets/ads'
                                Dir.foreach(dir) do |f|
                                                next if f == '.' or f == '..'
                                                ar<< File.join(path,f)
                                end
                                ar=['Cannon', 'Xerrox','HP Printer', 'Nikon']
                end
end
