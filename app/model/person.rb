require 'active_record'

ActiveRecord::Base.establish_connection(
  adapter: 'postgresql',
  database: 'tess',
  host: 'postgres',
  port: '5432',
  username: 'postgres',
  password: 'Pass2020!'
)

#ActiveRecord::Base.logger = Logger.new(STDOUT)

class User < ActiveRecord::Base
    self.table_name = 'users' 
    has_one :summary
end

class Post < ActiveRecord::Base
end


class Summary < ActiveRecord::Base
    self.table_name = 'summaries' 

    belongs_to :users, foreign_key: true

end

class Post < ActiveRecord::Base
end

class Rate < ActiveRecord::Base
end

class Comment < ActiveRecord::Base
end


class CreateAll < ActiveRecord::Migration[7.0]
    def change 
        create_table :users, if_not_exists: true do |t|
            
            t.string :name
           # t.integer   :id
            
            t.timestamps 
        end

        create_table :summaries, if_not_exists: true do |t|
            t.string :bio
            t.integer :birth

            t.belongs_to :user
            t.timestamps 


        end 


        create_table :posts, if_not_exists: true do |t|
            t.string :title
            t.string :body 
        
            t.timestamps 


        end 
    end
end




CreateAll.new.change