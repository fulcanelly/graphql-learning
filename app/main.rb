

require_relative './model/person'

require 'faker'
require 'agoo'
require 'graphql'
require 'ostruct'

def show_bt()
  puts ">>"
  pp Thread.current.backtrace.first(5)
  puts "<<"
end

module Types 
  PAGE_SIZE = 5

  class PostType < GraphQL::Schema::Object
    field :id, ID
    field :title, String 
    field :body, String 

  end

  
  class CreateComment < GraphQL::Schema::Mutation
    argument :body, String, required: true
    argument :post_id, ID, required: true
  
    field :id, ID

  
    def resolve(body:, post_id:)
      puts "<.>"

      OpenStruct.new({id: rand(123...5555), g:4 })
    end
  end
  
  class Mutation < GraphQL::Schema::Object
    field :create_comment, mutation: CreateComment
  end
  
  class QueryType < GraphQL::Schema::Object
  
    def current_user
      context[:current_user]
    end

    field :post, PostType, "Find a post by ID" do
      argument :id, ID
    end

    def post(id)
      return Post.find_by(id: id[:id])
    end

  end

  class Schema < GraphQL::Schema
    query QueryType
    mutation Mutation
  end

end


5.times do 
  Post.new(title: Faker::Lorem.words(number: rand(2..10)).join(" ")).save
end

result_hash = Types::Schema.execute <<-GRAPHQL
{
  post(id: 2) {
    title
  }
}
GRAPHQL


mut = <<-GRAPHQL
  mutation($id: ID!) {
    createComment(postId: $id, body: "Nice Post!") {
      id
    }
  }
GRAPHQL

result = Types::Schema.execute(mut, variables: {id: 22})

pp result.to_h
pp result_hash.to_h


User.new(name: Faker::Name.name).tap do |user|

  user.summary = Summary.new(
    bio: Faker::Lorem.words(number: rand(2..10)).join(" ")
  )

  user.save  
end

sleep 