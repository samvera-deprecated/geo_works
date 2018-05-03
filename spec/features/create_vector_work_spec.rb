require 'spec_helper'

RSpec.feature 'VectorWorkController', type: :feature do
  let(:user) { FactoryGirl.create(:admin) }

  before do
    allow(GeoblacklightJob).to receive(:perform_later)
  end

  context "an authorized user" do
    before do
      allow(CharacterizeJob).to receive(:perform_later)
      sign_in user
    end

    scenario "creating a vector work and extracting metadata from an FGDC file" do
      visit new_hyrax_vector_work_path
      expect(page).not_to have_selector(:css, 'a[href="#files"]')
      expect(page).to have_text 'Add Location'
      fill_in 'vector_work_title', with: 'Vector Title'
      fill_in 'vector_work_creator', with: 'User'
      fill_in 'vector_work_keyword', with: 'Vector'
      fill_in 'vector_work_spatial', with: 'France'
      fill_in 'vector_work_temporal', with: '1998-2006'
      fill_in 'vector_work_issued', with: '2001-01-01T00:00:00Z'
      choose 'vector_work_visibility_open'
      select 'Creative Commons BY Attribution 4.0 International', from: 'vector_work[license][]'
      check 'agreement'
      click_button 'Save'

      expect(page).to have_text 'Vector Title'
    end
  end
end
