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
  
    class Created < User
    end

    class Updated < User
    end
  end
end

require 'clag'

class SpecAppClag < Clag
  self.namespace = []
  
  def spec_app_user
    {
      :email => unique_for(:spec_app_user) { "#{random}@email.com" }
    }
  end
  
  # these namespaces are a bit crayzeee, but its just for testing
  class SpecAppEvent < SpecAppClag
    def user
      {
        :user => SpecAppClag.create_spec_app_user!
      }
    end
    
    class User < SpecAppEvent
      # testing arity detection
      def created(attrs = {})
        user.merge(attrs)
      end
    
      def updated
        user
      end
    end
  end
end