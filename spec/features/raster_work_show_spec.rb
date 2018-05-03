require 'spec_helper'

describe "display a raster work as its owner", type: :feature do
  let(:work_path) { "/concern/raster_works/#{work.id}" }
  let(:title) { ['Completed Raster'] }
  let(:coverage) { GeoWorks::Coverage.new(43.039, -69.856, 42.943, -71.032).to_s }
  let(:spatial) { ['France'] }
  let(:temporal) { ['1998-2006'] }
  let(:attributes) { { title: title, coverage: coverage, spatial: spatial, temporal: temporal, user: user } }
  let(:mods_file) { test_data_fixture_path('bb099zb1450_mods.xml') }
  let(:geo_tiff_file) { test_data_fixture_path('files/S_566_1914_clip.tif') }

  before do
    allow(CharacterizeJob).to receive(:perform_later)
    create(:sipity_entity, proxy_for_global_id: work.to_global_id.to_s)
  end

  context "as the work owner" do
    let(:work) { create(:public_raster_work, attributes) }
    let(:user) { create(:user) }
    before do
      sign_in user
      visit work_path
    end

    it "shows a work" do
      expect(page).to have_selector 'h1', text: 'Completed Raster'
      expect(page).to have_text 'France'
      expect(page).to have_text '1998-2006'
      expect(page).to have_text 'Coverage'
      expect(page).to have_css("input#work_child_members_ids")
      expect(page).to have_css("input#work_parent_members_ids")
    end

    it "allows the user to attach files" do
      click_button 'Attach File'
      click_link 'Attach Raster'
      fill_in 'file_set[title][]', with: 'GeoTIFF File'
      select 'GeoTIFF', from: 'file_set_geo_mime_type'
      attach_file 'file_set[files][]', geo_tiff_file
      click_button 'Attach to Raster Work'
      expect(page).to have_text 'GeoTIFF File'
      expect(page).to have_selector(:link_or_button, 'Download')

      click_button 'Attach File'
      click_link 'Attach Metadata'
      fill_in 'file_set[title][]', with: 'Metadata File'
      select 'MODS', from: 'file_set_geo_mime_type'
      attach_file 'file_set[files][]', mods_file
      click_button 'Attach to Raster Work'
      expect(page).to have_text 'Metadata File'
    end

    it "allows the user to attach a child vector work" do
      click_link 'Attach New Vector Work'
      expect(page).not_to have_selector(:css, 'a[href="#files"]')
      fill_in 'vector_work_title', with: 'Vector Title'
      choose 'vector_work_visibility_authenticated'
      select 'Creative Commons BY Attribution 4.0 International', from: 'vector_work[license][]'
    end
  end
end
