class OrderMailer < ApplicationMailer
  # default from: 'Sam Ruby <depot@example.com>'
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.recieved.subject
  #

  def received(order)
    @order = order

    @mail_language = USER_LANGUAGES[@order.user.language_preference.to_sym]
    @order.line_items.each do |line_item|

      if line_item.product.images.present?
        no_of_images = line_item.product.images.size

        line_item.product.images.reverse.each do |image|

          if no_of_images > 1
            attachments[image.name] = File.read('public/' + image.file_path)
            no_of_images -= 1

          else
            attachments.inline[image.name] = File.read('public/' + image.file_path)
          end
        end

      else
        attachments.inline['no_image_available.gif'] = File.read("#{Rails.root}/app/assets/images/no_image_available.gif")
      end

    end

    I18n.with_locale(@mail_language) do
      mail to: order.email
    end
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.shipped.subject
  #
  def shipped(order)
    @order = order

    mail to: order.email, subject: 'Pragmatic Store Order Shipped'
  end

end
