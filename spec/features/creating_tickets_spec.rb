require 'rails_helper'

RSpec.feature 'Users can create new tickets' do
  before do
    @create_ticket = lambda { click_button 'Create Ticket' }
    project = FactoryGirl.create(:project, name: 'Internet Explorer')
    
    visit project_path(project)
    click_link 'New Ticket'
  end
  
  scenario 'with valid attributes' do
    fill_in 'Name', with: 'Non-standards compliance'
    fill_in 'Description', with: 'My pages are ugly!'
    @create_ticket.call
    
    expect(page).to have_content 'Ticket has been created.'
  end
  
  scenario 'when providing invalid attributes' do
    expect { @create_ticket.call }.not_to change { Ticket.count }
    
    expect(page).to have_content 'Ticket has not been created.'
    expect(page).to have_content 'Name can\'t be blank'
    expect(page).to have_content 'Description can\'t be blank'
  end
  
  scenario 'with and invalid description' do
    fill_in 'Name', with: 'Non-standards compliance'
    fill_in 'Description', with: 'It sucks'
    @create_ticket.call
    
    expect(page).to have_content 'Ticket has not been created.'
    expect(page).to have_content 'Description is too short'
  end
end