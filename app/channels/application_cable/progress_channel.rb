module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_manager

    def connect
      self.current_manager = find_verified_manager
    end

    private
      def find_verified_manager
        Manager.find(session['warden.managaer.managaer.key'][0][0])
      rescue
        reject_unauthorized_connection
      end

      def session
        @session ||= cookies.encrypted[Rails.application.config.session_options[:key]]
      end
  end
end
