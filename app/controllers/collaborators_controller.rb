class CollaboratorsController < ApplicationController
  def new
    @wiki = authorize Wiki.find(params[:wiki_id])
    @collaborator = Collaborator.new
  end

  def create
    @wiki = authorize Wiki.find(params[:wiki_id])
    @collaborator = Collaborator.new
    @collaborator.user_id = params[:collaborator][:user_id]
    @collaborator.wiki_id = @wiki.id

    if @collaborator.save
      flash[:notice] = "Collaborator was added."
      redirect_to new_wiki_collaborator_path
    else
      flash.now[:alert] = "There was an error adding the collaborator. Please try again."
      render :new
    end
  end

  def destroy
    @wiki = authorize Wiki.find(params[:wiki_id])
    @collaborator = Collaborator.find(params[:id])
    user = @collaborator.user_id
    @collaborator = Collaborator.where(user_id: user, wiki_id: @wiki.id)

    if Collaborator.destroy(@collaborator.ids)
      flash[:notice] = "Collaborator was successfully deleted."
      redirect_to new_wiki_collaborator_path
    else
      flash.now[:alert] = "There was an error deleting the collaborator."
      render :show
    end
  end
end
