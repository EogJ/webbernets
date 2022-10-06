require 'rails_helper'

RSpec.describe NewProjectForm, :type => :model do
  describe 'validations' do
    it 'strips title on validation' do
      form = NewProjectForm.new(title: '  Some title  ')
      form.valid?
      expect(form.title).to eq('Some title')
    end
  end

  describe 'current user is a super user' do
    let(:user) { create(:user, :with_team, super_user: true) }

    describe 'join project is true' do
      it 'adds the current user to the project' do
        project = NewProjectForm.new(
          title: 'A',
          current_user: user,
          join_project: 'true'
        ).save
        expect(project.users).to include(user)
      end
    end

    describe 'join project is false' do
      it 'does not add the current user to the project' do
        project = NewProjectForm.new(
          title: 'A',
          current_user: user,
          join_project: 'false'
        ).save
        expect(project.users).not_to include(user)
      end
    end
  end

  describe 'current user is not a super user' do
    let(:user) { create(:user, :with_team, super_user: false) }
    it 'adds the user to the project' do
      project = NewProjectForm.new(
        title: 'A',
        current_user: user
      ).save
      expect(project.users).to include(user)
    end
  end
end
