class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :interface_document
end
