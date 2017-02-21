require 'spec_helper'

describe "display a vector work as its owner", type: :feature do
  let(:work_path) { "/concern/vector_works/#{work.id}" }
  let(:title) { ['Completed Vector'] }
  let(:coverage) { GeoWorks::Coverage.new(43.039, -69.856, 42.943, -71.032).to_s }
  let(:spatial) { ['France'] }
  let(:temporal) { ['1998-2006'] }
  let(:attributes) { { title: title, coverage: coverage, spatial: spatial, temporal: temporal, user: user } }
  let(:fgdc_file) { test_data_fixture_path('zipcodes_fgdc.xml') }
  let(:vector_file) { test_data_fixture_path('files/tufts-cambridgegrid100-04.zip') }

  before do
    allow(CharacterizeJob).to receive(:perform_later)
    create(:sipity_entity, proxy_for_global_id: work.to_global_id.to_s)
  end

  context "as the work owner" do
    let(:work) { create(:public_vector_work, attributes) }
    let(:user) { create(:user) }
    before do
      sign_in user
      visit work_path
    end

    it "shows a work" do
      expect(page).to have_selector 'h1', text: 'Completed Vector'
      expect(page).to have_text 'France'
      expect(page).to have_text '1998-2006'
      expect(page).to have_text 'Coverage'
      expect(page).not_to have_css("input#work_child_members_ids")
      expect(page).to have_css("input#work_parent_members_ids")
    end

    it "allows the user to attach files and extract attributes from metadata file" do
      click_button 'Attach File'
      click_link 'Attach Vector'
      fill_in 'file_set[title][]', with: 'Vector File'
      select 'ESRI Shapefile', from: 'file_set_geo_mime_type'
      attach_file 'file_set[files][]', vector_file
      click_button 'Attach to Vector Work'
      expect(page).to have_text 'Vector File'
      expect(page).to have_selector(:link_or_button, 'Download')

      click_button 'Attach File'
      click_link 'Attach Metadata'
      fill_in 'file_set[title][]', with: 'Metadata File'
      select 'FGDC', from: 'file_set_geo_mime_type'
      attach_file 'file_set[files][]', fgdc_file
      click_button 'Attach to Vector Work'
      expect(page).to have_text 'Metadata File'

      click_link 'Edit Work'
      select 'zipcodes_fgdc.xml', from: 'vector_work[should_populate_metadata]'
      click_button 'Save'
      click_link "No. I'll update it manually."
      expect(page).to have_text 'Louisiana ZIP Code Areas 2002'
    end
  end
end
