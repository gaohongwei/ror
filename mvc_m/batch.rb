Batch
https://api.rubyonrails.org/classes/ActiveRecord/Batches.html#method-i-in_batches
  find_each, read batch
    Person.all will try to instantiate all the objects at once.
    Person.find_each do |person|
      person.do_awesome_stuff
    end

    Person.where("age > 21").find_each do |person|
      person.party_all_night!
    end

  in_batches
    create a batch of records.

    Person.where("age > 21").in_batches do |relation|
      relation.delete_all
      sleep(10) # Throttle the delete queries
    end

    Person.in_batches.delete_all
    Person.in_batches.update_all(awesome: true)
    Person.in_batches.each_record(&:party_all_night!)

    Person.in_batches.each do |relation|
      relation.update_all('age = age + 1')
      relation.where('age > 21').update_all(should_party: true)
      relation.where('age <= 21').delete_all
    end

    Person.in_batches.each_record(&:party_all_night!)


    Quote.update_all(duration_days: 0)
    Quote.where(duration_units: 'weeks').update_all('duration_days = duration * 7')
    Quote.where(duration_units: 'months').update_all('duration_days = duration * 30')    
    Quote.where(duration_units: 'days').update_all('duration_days = duration')
