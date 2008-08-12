ActiveRecord::Migration.suppress_messages do
  ActiveRecord::Schema.define(:version => 0) do
    create_table :spec_app_users, :force => true do |t|
      t.string :email
    end
    
    create_table :spec_app_events, :force => true do |t|
      t.integer :user_id
      t.string :type
    end
  end
end

class SpecAppUser < ActiveRecord::Base
  validates_uniqueness_of :email
end

class SpecAppEvent < ActiveRecord::Base
  class User < SpecAppEvent
    belongs_to :user, :class_name => 'SpecAppUser'
  end
  
  class UserCreated < User
  end
  
  class UserUpdated < User
  end
end

require 'clag'

class SpecAppClag < Clag
  self.namespace = []
  
  def spec_app_user
    {
      :email => "#{random}@email.com"
    }
  end
  
  class SpecAppEvent < SpecAppClag
    def user
      {
        :user => SpecAppClag.create_spec_app_user!
      }
    end
    
    def user_created
      user
    end
    
    def user_updated
      user
    end
  end
end