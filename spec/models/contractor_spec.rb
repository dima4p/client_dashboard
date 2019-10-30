# == Schema Information
#
# Table name: contractors
#
#  id                 :integer          not null, primary key
#  first_name         :string
#  last_name          :string
#  partner_company_id :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require 'rails_helper'

RSpec.describe Contractor, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
