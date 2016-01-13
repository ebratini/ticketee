require 'rails_helper'

RSpec.feature 'Users can view tickets' do
  before do
    author = FactoryGirl.create(:user)
    
    @sublime = FactoryGirl.create(:project, name: 'Sublime Text 3')
    assign_role!(author, :viewer, @sublime)
    @sublime_ticket = FactoryGirl.create(:ticket, project: @sublime, author: author,
                                name: 'Make it shiny!',
                                description: 'Gradients! Starbursts! Oh my!')
                                
    @ie = FactoryGirl.create(:project, name: 'Internet Explorer')
    assign_role!(author, :viewer, @ie)
    @ie_ticket = FactoryGirl.create(:ticket, project: @ie, author: author,
                                name: 'Standards compliance',
                                description: 'Isn\'t a joke.')

    login_as(author)
    visit '/'
  end
  
  scenario 'for a given project' do
    click_link @sublime.name
    
    expect(page).to have_content @sublime_ticket.name
    expect(page).to_not have_content @ie_ticket.name
    
    click_link @sublime_ticket.name
    within('#ticket h2') do
      expect(page).to have_content @sublime_ticket.name
    end
    
    expect(page).to have_content @sublime_ticket.description
  end
end