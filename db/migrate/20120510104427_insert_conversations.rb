class InsertConversations < ActiveRecord::Migration
  def up


   execute "insert into conversations(conversation, validity,priority, created_at)
   values('CrawlFish currently handles 15 local vendors and 5 online vendors', 1,1 , current_timestamp)"

   execute "insert into conversations(conversation, validity,priority, created_at)
   values('Dont have a keyword on your mind?, visit our VIRTUAL MALL', 1,1 , current_timestamp)"

   execute "insert into conversations(conversation, validity,priority, created_at)
   values('Sony launched the most awaited phone, find. compare. decide.', 1,1 , current_timestamp)"

   execute "insert into conversations(conversation, validity,priority, created_at)
   values('Not comfortable purchasing online?, locate a local shop that is few meters away', 1,0 , current_timestamp)"

   execute "insert into conversations(conversation, validity,priority, created_at)
   values('Good at bargaining?, Click NEGOTIATE', 1,1 , current_timestamp)"

   execute "insert into conversations(conversation, validity,priority, created_at)
   values('CrawlFish added a 1 more category COMPUTERS and 500 more products', 1,1 , current_timestamp)"

   execute "insert into conversations(conversation, validity,priority, created_at)
   values('If you are looking for the best vendors, Click TOP5', 1,1 , current_timestamp)"

   execute "insert into conversations(conversation, validity,priority, created_at)
   values('Venkateshwara Stores, velachery. Expanded from only mobile phones to Phones and Computers', 1,1 , current_timestamp)"

   execute "insert into conversations(conversation, validity,priority, created_at)
   values('Shopping in CrawlFish is an experience you can share, SPEAK TO US!, now', 1,1 , current_timestamp)"

   execute "insert into conversations(conversation, validity,priority, created_at)
   values('Are you a Merchant looking to grow your business?, CONTACT US', 1,0 , current_timestamp)"

   execute "insert into conversations(conversation, validity,priority, created_at)
   values('Its in our best interest that our users find exactly what they want for how much they can afford', 1,0 , current_timestamp)"

   execute "insert into conversations(conversation, validity,priority, created_at)
   values('Our Mission is, blah blah blah!, We just want to make money out of what we love!', 1,0 , current_timestamp)"

   execute "insert into conversations(conversation, validity,priority, created_at)
   values('Now you can send us cartoons which if found convincing, will be displayed in our homepage', 1,1 , current_timestamp)"

   execute "insert into conversations(conversation, validity,priority, created_at)
   values('Did you know?, There are 1453585 local shops in Chennai and unmeasurable dissatisfied customers', 1,1 , current_timestamp)"

   execute "insert into conversations(conversation, validity,priority, created_at)
   values('Arun Bookstore opened a new branch at Nungambakkam!', 1,1 , current_timestamp)"


  end

  def down
  execute "DELETE FROM conversations"
  end
end

