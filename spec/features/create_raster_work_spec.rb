require 'spec_helper'

RSpec.feature 'RasterWorkController', type: :feature do
  let(:user) { FactoryBot.create(:admin) }

  before do
    allow(GeoblacklightJob).to receive(:perform_later)
  end

  context "an authorized user" do
    before do
      allow(CharacterizeJob).to receive(:perform_later)
      sign_in user
    end

    scenario "creating a raster work and attaching a vector work" do
      visit new_hyrax_raster_work_path
      expect(page).not_to have_selector(:css, 'a[href="#files"]')
      expect(page).to have_text 'Add Location'
      fill_in 'raster_work_title', with: 'Raster Title'
      fill_in 'raster_work_creator', with: 'User'
      fill_in 'raster_work_keyword', with: 'Raster'
      fill_in 'raster_work_spatial', with: 'France'
      fill_in 'raster_work_temporal', with: '1998-2006'
      fill_in 'raster_work_issued', with: '2001-01-01T00:00:00Z'
      choose 'raster_work_visibility_open'
      select 'Attribution 3.0 United States', from: 'raster_work[rights][]'
      choose 'raster_work_visibility_open'
      check 'agreement'
      click_button 'Save'

      expect(page).to have_text 'Raster Title'
    end
  end
end
