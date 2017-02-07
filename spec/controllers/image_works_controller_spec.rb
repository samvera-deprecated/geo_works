require 'spec_helper'

describe Hyrax::ImageWorksController, type: :controller do
  let(:user) { create(:admin) }
  before { sign_in user }

  describe "#show_presenter" do
    it "is a image work show presenter" do
      expect(described_class.new.show_presenter).to eq(::GeoConcerns::ImageWorkShowPresenter)
    end
  end

  describe "#show" do
    before do
      create(:sipity_entity, proxy_for_global_id: work.to_global_id.to_s)
    end
    context "with an existing image work" do
      let(:work) { create(:image_work, user: user, title: ['Image Work Title']) }
      it "is a success" do
        get :show, params: { id: work.id }
        expect(response).to be_success
      end
    end
  end

  describe '#create' do
    context 'when create is successful' do
      let(:work) { create(:image_work, user: user) }
      it 'creates an image work' do
        allow(controller).to receive(:curation_concern).and_return(work)
        post :create, params: { image_work: { title: ['a title'] } }
        expect(response).to redirect_to main_app.hyrax_image_work_path(work) + '?locale=en'
      end
    end
  end
end
