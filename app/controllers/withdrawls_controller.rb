class WithdrawlsController < ApplicationController
  before_action :set_account
  before_action :set_account_withdrawl, only: [:show, :update, :destroy]

  # GET /accounts/:account_id/withdrawls
  def index
    json_response(@account.withdrawls)
  end

  # GET /accounts/:account_id/withdrawls/:id
  def show
    json_response(@withdrawl)
  end

  # POST /accounts/:account_id/withdrawls
  def create
    @account.withdrawls.create!(withdrawl_params)
    json_response(@account, :created)
  end

  # PUT /accounts/:account_id/withdrawls/:id
  def update
    @withdrawl.update(withdrawl_params)
    head :no_content
  end

  # DELETE /accounts/:account_id/withdrawls/:id
  def destroy
    @withdrawl.destroy
    head :no_content
  end

  private

  def withdrawl_params
    params.permit(:notes, :amount, :account_id)
  end

  def set_account
    @account = Account.find(params[:account_id])
  end

  def set_account_withdrawl
    @withdrawl = @account.withdrawls.find_by!(id: params[:id]) if @account
  end
end
