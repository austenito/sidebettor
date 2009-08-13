namespace :bootstrap do
   desc "Adds the data used to test the app"
   task :test_data => :environment do
     default = User.create(
       :last_login_at => '2009-04-26 07:25:32',
       :last_request_at => '2009-04-26 07:25:32',
       :updated_at => '2009-04-26 07:25:32',
       :current_login_ip => '127.0.0.1',
       :current_login_at => '2009-04-26 07:25:32',
       :failed_login_count => 0, 
       :login_count => 1,
       :last_login_ip => '127.0.0.1',
       :created_at => '2009-04-26 07:25:32',
       :crypted_password =>  '7218a218f6c8b3f07ec29d17ebc63fd36460b600fd59c649433c899b255922119104fa8739893f713f6aa25ccdd5a23dd83dc45fca23d7d0f2a5a02ad3714d75',
       :single_access_token => 'v3cTY4lGGh9LRf7TLzNS', 
       :perishable_token => 'v3cTY4lGGh9LRf7TLzNS',
       :password_salt => 'wMq1RXp7KM2uUwu44jG6', 
       :persistence_token => '884ee3f12652288d56d48c9ddb6bf1d80184c8d813deaa41f08192248c281340bf03bbae3643119071963632dfd9e0542f667ecf2562d926d9c40b20255074c3', 
       :login => 'default', 
       :email => 'default@default.com',
       :password_confirmation => 'default',
       :password => 'default')
       
      admin = User.create(
        :last_login_at => '2009-04-26 07:25:32',
        :last_request_at => '2009-04-26 07:25:32',
        :updated_at => '2009-04-26 07:25:32',
        :current_login_ip => '127.0.0.1',
        :current_login_at => '2009-04-26 07:25:32',
        :failed_login_count => 0, 
        :login_count => 1,
        :last_login_ip => '127.0.0.1',
        :created_at => '2009-04-26 07:25:32',
        :crypted_password =>  '7c712083a489569af98d1561333d2fac7bc95e50015e72b4671c4a4c8d93a4e33d189c527200cf9d0afc48de0f4a79c30bfd9d1f8375415deb99f1d898b8de25',
        :single_access_token => 'RluReIxEIoLV8a6cK0VZ',
        :perishable_token => 't5xIZHnqyn77KTlMzmNV',
        :password_salt => '6ez_NtygM-IUF86jl0xh',
        :persistence_token => '9e67b556dbfecb6e8653e998a5f789b86c38911319a9d09a137048234ee16c7532400f9f05bcf9557bcb3c7f3bf805c302b98825421ff425006225cfd2b7c48f', 
        :login => 'admin', 
        :email => 'admin@admin.com',
        :password_confirmation => 'admin',
        :password => 'admin')      
        
       bet = Bet.create(:title => "Admin times out in 5 seconds", :end_date => Date.today, :user_id => default.id, :created_at => Date.today, :updated_at => Date.today)
       BetRequest.create(:has_accepted => true, :bet_id => bet.id, :user_id => default.id, :created_at => Date.today, :updated_at => Date.today)
       BetRequest.create(:has_accepted => false, :bet_id => bet.id, :user_id => admin.id, :created_at => Date.today, :updated_at => Date.today)
       Prize.create(:bet_id => bet.id, :name => "Default Prize")
       BetStatus.create(:bet_id => bet.id, :is_pending => true, :is_completed => false)
       
       bet = Bet.create(:title => "Default does nothing", :end_date => Date.today, :user_id => admin.id, :created_at => Date.today, :updated_at => Date.today)
       BetRequest.create(:has_accepted => true, :bet_id => bet.id, :user_id => admin.id, :created_at => Date.today, :updated_at => Date.today)
       BetRequest.create(:has_accepted => false, :bet_id => bet.id, :user_id => default.id, :created_at => Date.today, :updated_at => Date.today)                
       Prize.create(:bet_id => bet.id, :name => "Admin Prize")
       BetStatus.create(:bet_id => bet.id, :is_pending => true, :is_completed => false)       
   end
   
   desc "Adds the betting types"
   
   desc "Loads seed data into the database"
   task :all => [:test_data]
 end
 