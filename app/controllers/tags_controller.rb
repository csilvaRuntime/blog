class TagsController < ApplicationController

    def new
      @tag = Tag.new
    end
  
    def create
      @tag = Tag.new(tag_params)
      if @tag.save
        flash[:notice] = "Tag was successfully created"
        redirect_to @tag
      else
        render 'new'
      end
    end
  
    def edit
      @tag = Tag.find(params[:id])
    end
  
    def update
      @tag = Tag.find(params[:id])
      if @tag.update(tag_params)
        flash[:notice] = "Tag name updated successfully"
        redirect_to @tag
      else
        render 'edit'
      end
    end
    
private
  
    def tag_params
      params.require(:tag).permit(:name, :color)
    end
  
  end