class TransactionEntriesController < ApplicationController
  def index
    @category = Category.find(params[:category_id])
    @transaction_entries = @category.transaction_entries.order(created_at: :desc)
    @total_sum = @transaction_entries.sum(:amount)
  end

  def new
    @category = Category.find(params[:category_id])
    @transaction_entry = @category.transaction_entries.build
  end

  def create
    @category = Category.find(params[:category_id])
    @transaction_entry = @category.transaction_entries.build(transaction_entry_params)
    @transaction_entry.user = current_user

    category_id = params[:transaction_entry][:category_id]

    if category_id.present?
      category = Category.find(category_id)
      @transaction_entry.categories << category
    end

    if @transaction_entry.save
      redirect_to category_transaction_entries_path(category_id), notice: 'Transaction created successfully!'
    else
      render :new, flash: { error: 'Transaction not created!' }
    end
  end

  private

  def transaction_entry_params
    params.require(:transaction_entry).permit(:name, :amount)
  end
end
