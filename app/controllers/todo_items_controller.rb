class TodoItemsController < ApplicationController
	before_filter :set_todo_list
	before_filter :set_todo_item, except: [:create]

	def create
		@todo_item = @todo_list.todo_items.create todo_item_params
		flash[:notice] = "Todo Item created successfuly."
		redirect_to @todo_list
	end

	def destroy
		if @todo_item.destroy
			flash[:notice] = "Todo List Item deleted successfuly."
		else
			flash[:notice] = "Todo List Item coudn't be deleted."
		end
		redirect_to @todo_list
	end

	def complete
		@todo_item.update_attribute("completed_at", Time.now)
		redirect_to @todo_list, notice: "Todo Item completed."
	end

	private
		def todo_item_params
			params[:todo_item].permit(:content)
		end

		def set_todo_list
			@todo_list = TodoList.find params[:todo_list_id] 
		end

		def set_todo_item
			@todo_item = @todo_list.todo_items.find params[:id]
		end
end
