class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'

  before_action :add_process_id_in_email_header

  private

    def add_process_id_in_email_header
      headers['X-SYSTEM-PROCESS-ID'] = Process.pid
    end
end
