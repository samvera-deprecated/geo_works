require 'spec_helper'

RSpec.feature 'ImageWorkController', type: :feature do
  let(:user) { FactoryGirl.create(:admin) }

  before do
    allow(GeoblacklightJob).to receive(:perform_later)
  end

  context "an authorized user" do
    before do
      allow(CharacterizeJob).to receive(:perform_later)
      sign_in user
    end

    scenario "creating an image work and attaching a raster work" do
      visit new_hyrax_image_work_path
      expect(page).not_to have_selector(:css, 'a[href="#files"]')
      expect(page).to have_text 'Add Location'
      fill_in 'image_work_title', with: 'Image Title'
      fill_in 'image_work_creator', with: 'User'
      fill_in 'image_work_keyword', with: 'Image'
      fill_in 'image_work_spatial', with: 'France'
      fill_in 'image_work_temporal', with: '1998-2006'
      fill_in 'image_work_issued', with: '2001-01-01T00:00:00Z'
      choose 'image_work_visibility_open'
      select 'Attribution 3.0 United States', from: 'image_work[rights][]'
      check 'agreement'
      click_button 'Save'

      expect(page).to have_text 'Image Title'
    end
  end
end
