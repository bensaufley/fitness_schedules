class Relationship < ActiveRecord::Base
  attr_accessible :client_id, :trainer_id
  belongs_to :client
  belongs_to :trainer
end
