require 'rails_helper'

RSpec.describe ApiController, type: :controller do
    describe "GET #index" do
        it "renders the correct template" do
            get :index
            expect(response).to render_template :index
        end
    end    

end
