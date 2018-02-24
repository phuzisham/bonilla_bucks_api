class DepositsController < ApplicationController
  before_action :set_account
  before_action :set_account_deposit, only: [:show, :update, :destroy]

  # GET /accounts/:account_id/deposits
  def index
    json_response(@account.deposits)
  end

  # GET /accounts/:account_id/deposits/:id
  def show
    json_response(@deposit)
  end

  # POST /accounts/:account_id/deposits
  def create
    @account.deposits.create!(deposit_params)
    json_response(@account, :created)
  end

  # PUT /accounts/:account_id/deposits/:id
  def update
    @deposit.update(deposit_params)
    head :no_content
  end

  # DELETE /accounts/:account_id/deposits/:id
  def destroy
    @deposit.destroy
    head :no_content
  end

  private

  def deposit_params
    params.permit(:notes, :amount, :account_id)
  end

  def set_account
    @account = Account.find(params[:account_id])
  end

  def set_account_deposit
    @deposit = @account.deposits.find_by!(id: params[:id]) if @account
  end
end
