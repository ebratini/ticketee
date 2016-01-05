require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  it 'handle a missing project correctly' do
    get :show, id: 'not-here'
    
    message = 'The project you were looking for could not be found.'
    expect(response).to redirect_to(projects_path)
    expect(flash[:alert]).to eq message
  end
end
