require 'test_helper'

class PaymethodsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @paymethod = paymethods(:one)
  end

  test "should get index" do
    get paymethods_url
    assert_response :success
  end

  test "should create paymethod" do
    assert_difference('Paymethod.count') do
      post paymethods_url, params: { paymethod: { amount: @paymethod.amount, title: @paymethod.title } }
    end

    assert_response 201
  end

  test "should show paymethod" do
    get paymethod_url(@paymethod)
    assert_response :success
  end

  test "should update paymethod" do
    patch paymethod_url(@paymethod), params: { paymethod: { amount: @paymethod.amount, title: @paymethod.title } }
    assert_response 200
  end

  test "should destroy paymethod" do
    assert_difference('Paymethod.count', -1) do
      delete paymethod_url(@paymethod)
    end

    assert_response 204
  end
end
