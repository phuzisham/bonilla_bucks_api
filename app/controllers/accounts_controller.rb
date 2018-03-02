class AccountsController < ApplicationController
  before_action :set_user
  before_action :set_user_account, only: [:show, :update, :destroy]
  
  # GET /accounts
  def index
    json_response(@user.accounts)
  end

  # POST /accounts
  def create
    @account = Account.create!(account_params)
    json_response(@account, :created)
  end

  # GET /accounts/:id
  def show
    json_response(@account)
  end

  # PUT /accounts/:id
  def update
    @account.update(account_params)
    head :no_content
  end

  # DELETE /accounts/:id
  def destroy
    @account.destroy
    head :no_content
  end

  private

  def account_params
    params.permit(:balance, :user_id)
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_user_account
    @account = @user.accounts.find_by!(id: params[:id]) if @account
  end
end
