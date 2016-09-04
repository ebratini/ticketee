require "rails_helper"

RSpec.describe CommentNotifier, type: :mailer do
  describe 'created' do
    let(:project) { FactoryGirl.create(:project) }
    let(:ticket_owner) { FactoryGirl.create(:user) }
    let(:ticket) do
      FactoryGirl.create(:ticket, project: project, author: ticket_owner)
    end
    
    let(:commenter) { FactoryGirl.create(:user) }
    let(:comment) do
      Comment.new(ticket: ticket, author: commenter, text: 'Test comment')
    end
    
    let(:email) { CommentNotifier.created(comment, ticket_owner) }
    
    it 'sends out an email notification about a new comment' do
      title = "#{ticket.name} for #{project.name} has been updated."
      email_body = email.body.to_s
      
      expect(email.to).to include ticket_owner.email
      expect(email_body).to include title
      expect(email_body).to include "#{commenter.email} wrote:"
      expect(email_body).to include comment.text
    end
    
  end
end
