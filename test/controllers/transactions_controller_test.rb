require 'test_helper'

class TransactionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @transaction = transactions(:one)
  end

  test "should get index" do
    get transactions_url
    assert_response :success
  end

  test "should create transaction" do
    assert_difference('Transaction.count') do
      post transactions_url, params: { transaction: { ammount: @transaction.ammount, balance: @transaction.balance, paymethod_id: @transaction.paymethod_id, user_id: @transaction.user_id } }
    end

    assert_response 201
  end

  test "should show transaction" do
    get transaction_url(@transaction)
    assert_response :success
  end

  test "should update transaction" do
    patch transaction_url(@transaction), params: { transaction: { ammount: @transaction.ammount, balance: @transaction.balance, paymethod_id: @transaction.paymethod_id, user_id: @transaction.user_id } }
    assert_response 200
  end

  test "should destroy transaction" do
    assert_difference('Transaction.count', -1) do
      delete transaction_url(@transaction)
    end

    assert_response 204
  end
end
