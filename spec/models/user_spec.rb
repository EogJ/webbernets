require 'rails_helper'

RSpec.describe User, :type => :model do
  describe ".active" do
    let!(:active_user) { create(:user, :with_team) }
    let!(:deleted_user) { create(:user, :with_team, deleted: true) }

    it "returns only users not deleted" do
      result = User.active

      expect(result).to include(active_user)
      expect(result).to_not include(deleted_user)
    end
  end
end
