module Spree
  class CheckoutController < StoreController
    before_action :redirect_to_privacygate, only: :update

    def redirect_to_privacygate
      order = current_order || raise(ActiveRecord::RecordNotFound)
      if params[:state] == "payment"
        return unless params[:order][:payments_attributes]
        payment_method = PaymentMethod.find(params[:order][:payments_attributes].first[:payment_method_id])

      elsif params[:state] == "confirm"
        payment_method = @order.payment_method
      end

      if !payment_method.nil? && payment_method.kind_of?(PaymentMethod::PrivacyGatePayment)
        client = payment_method.create_client
        payment = order.payments.create!(amount: order.total,
                                         payment_method: payment_method,
                                         order_id: order.id)
        payment.started_processing!
        name = payment_method.name.truncate(30)
        description = payment_method.description.truncate(80)
        charge_info = {
            "name": name.empty? ? "Order #{order.number}" : name,
            "description": description.empty? ? 'Pay with cryptocurrency' : description,
            "pricing_type": "fixed_price",
            "metadata": {
                "order_id": order.id,
                "payment_id": payment.id
            },
            "local_price": {
                "amount": order.total,
                "currency": order.currency
            },
            "redirect_url": "#{request.protocol}#{request.host_with_port}/orders/#{order.number}"
        }
        charge = client.charge.create(charge_info)
        redirect_to "#{charge.hosted_url}"
      end
    end
  end
end


