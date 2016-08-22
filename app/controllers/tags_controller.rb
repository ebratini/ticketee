class TagsController < ApplicationController
  def remove
    @tag = Tag.find(params[:id])
    @ticket = Ticket.find(params[:ticket_id])
    authorize @ticket, :tag?
    
    @ticket.tags.destroy(@tag)
    head :ok
  end
end
