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
    has_many :posts

end

class Post < ActiveRecord::Base
end


class Summary < ActiveRecord::Base
    self.table_name = 'summaries' 

 #   belongs_to :users, foreign_key: { to_table: :user }

end

class Post < ActiveRecord::Base
    self.table_name = 'posts' 

 #   belongs_to :users, foreign_key: { to_table: :user }

end

class Rate < ActiveRecord::Base

    has_one :post
    has_one :user

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

           # t.belongs_to :user
            t.references :user, null: true, foreign_key: { to_table: :users }

            t.timestamps 


        end 


        create_table :posts, if_not_exists: true do |t|
            t.string :title
            t.string :body 
        
            t.timestamps 

        #    t.belongs_to :user
            t.references :user, null: true, foreign_key: { to_table: :users }

        end 

        create_table :rates, if_not_exists: true do |t|
            t.timestamps 

            #    t.belongs_to :user
            t.references :user, null: true, foreign_key: { to_table: :users }
            t.references :post, null: true, foreign_key: { to_table: :posts }

        end
    end
end




CreateAll.new.change