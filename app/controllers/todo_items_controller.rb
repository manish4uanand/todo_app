class TodoItemsController < ApplicationController
	before_filter :set_todo_list

	def create
		@todo_item = @todo_list.todo_items.create todo_item_params

		redirect_to @todo_list
	end

	def destroy
		@todo_item = @todo_list.todo_items.find params[:id]
		if @todo_item.destroy
			flash[:success] = "Todo List Item deleted successfuly."
		else
			flash[:error] = "Todo List Item coudn't be deleted."
		end
		redirect_to @todo_list
	end

	private
		def todo_item_params
			params[:todo_item].permit(:content)
		end

		def set_todo_list
			@todo_list = TodoList.find params[:todo_list_id] 
		end

end
