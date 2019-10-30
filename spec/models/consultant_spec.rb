# == Schema Information
#
# Table name: consultants
#
#  id            :integer          not null, primary key
#  client_id     :integer
#  contractor_id :integer
#  employee_id   :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'rails_helper'

RSpec.describe Consultant, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
