require 'spec_helper'

describe "display a image work as its owner", type: :feature do
  let(:work_path) { "/concern/image_works/#{work.id}" }
  let(:title) { ['Completed Image'] }
  let(:coverage) { GeoConcerns::Coverage.new(43.039, -69.856, 42.943, -71.032).to_s }
  let(:spatial) { ['France'] }
  let(:temporal) { ['1998-2006'] }
  let(:attributes) { { title: title, coverage: coverage, spatial: spatial, temporal: temporal, user: user } }
  let(:mods_file) { test_data_fixture_path('bb099zb1450_mods.xml') }
  let(:image_file) { test_data_fixture_path('files/americas.jpg') }

  before do
    allow(CharacterizeJob).to receive(:perform_later)
    create(:sipity_entity, proxy_for_global_id: work.to_global_id.to_s)
  end

  context "as the work owner" do
    let(:work) { create(:public_image_work, attributes) }
    let(:user) { create(:user) }
    before do
      sign_in user
      visit work_path
    end

    it "shows a work" do
      expect(page).to have_selector 'h1', text: 'Completed Image'
      expect(page).to have_text 'France'
      expect(page).to have_text '1998-2006'
      expect(page).to have_text 'Coverage'
      expect(page).to have_css("input#work_child_members_ids")
      expect(page).to have_css("input#work_parent_members_ids")
    end

    it "allows the user to attach files" do
      click_button 'Attach File'
      click_link 'Attach Image'
      fill_in 'file_set[title][]', with: 'JPEG File'
      select 'JPEG', from: 'file_set_geo_mime_type'
      attach_file 'file_set[files][]', image_file
      click_button 'Attach to Image Work'
      expect(page).to have_text 'JPEG File'
      expect(page).to have_selector(:link_or_button, 'Download')

      click_button 'Attach File'
      click_link 'Attach Metadata'
      fill_in 'file_set[title][]', with: 'Metadata File'
      select 'MODS', from: 'file_set_geo_mime_type'
      attach_file 'file_set[files][]', mods_file
      click_button 'Attach to Image Work'
      expect(page).to have_text 'Metadata File'
    end

    it "allows the user to attach a child raster work" do
      click_link 'Attach New Raster Work'
      expect(page).not_to have_selector(:css, 'a[href="#files"]')
      fill_in 'raster_work_title', with: 'Raster Title'
      choose 'raster_work_visibility_authenticated'
      select 'Attribution 3.0 United States', from: 'raster_work[rights][]'
    end
  end
end
