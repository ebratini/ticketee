require 'sinatra'

module API
  module V2
    class Tickets < Sinatra::Base
      before do
        headers 'Content-Type' => 'text/json'
        set_user
        set_project
      end
      
      #url: /projects/:project_id/tickets/:id
      get '/:id' do
        ticket = @project.tickets.find(params[:id])
        policy = TicketPolicy.new(@user, ticket)
        if policy.show?
          return TicketSerializer.new(ticket).to_json
        end
        
        not_found! #halt 404, 'The ticket you were looking for could not be found.'
      end
      
      private
      def params
        hash = env['action_dispatch.request.path_parameters'].merge!(super)
        HashWithIndifferentAccess.new(hash)
      end
      
      def set_project
        @project = Project.find(params[:project_id])
      end
      
      def set_user
        auth_header = 'HTTP_AUTHORIZATION'
        if env[auth_header].present?
          if auth_token = /Token token=(.*)/.match(env[auth_header])
            @user = User.find_by(api_key: auth_token[1])
            return @user if @user.present?
          end
        end
        
        unauthenticated!
      end
      
      def unauthenticated!
        halt 401, {error: 'Unauthenticated'}.to_json
      end
      
      def not_found!
        halt 404, 'The resource you were looking for could not be found.'
      end
    end
  end
end
