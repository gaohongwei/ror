Summary:
  Load all data
  Problem: eat too much memory
class UsersController < ApplicationController
  def index
    @users = User.all

    respond_to do |format|
      format.html
      format.csv { send_data @users.to_csv, filename: "users-#{Date.today}.csv" }
    end
  end
 end
 
 class User < ActiveRecord::Base
  def self.to_csv
    attributes = %w{id email name}

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |user|
        csv << attributes.map{ |attr| user.send(attr) }
      end
    end
  end

  def name
    "#{first_name} #{last_name}"
  end
end

#send_data Sends the given binary data to the browser. 
It is similar to render :text => data, 
but also allows you to specify whether the browser should 
display the response as a file attachment (i.e. in a download dialog) or as inline data. 
You may also set the content type, the apparent file name, and other things. 
