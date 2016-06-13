require 'rails_sanitize'

module XssTerminate
  def self.included(base)
    base.extend(ClassMethods)
    base.send(:include, InstanceMethods)
  end

  module ClassMethods
    def xss_terminate(options = {})
      unless respond_to?(:xss_terminate_options)
        class_attribute :xss_terminate_options
        self.xss_terminate_options = {
          except: [],
          html5lib_sanitize: [],
          html5lib_options: {},
        }
      end

      xss_options = self.xss_terminate_options
      xss_options[:except].concat(options[:except] || []).uniq!
      xss_options[:html5lib_sanitize].concat(options[:html5lib_sanitize] || []).uniq!
      xss_options[:html5lib_options].merge!(options[:html5lib_options] || {})
      xss_options
    end
  end
  
  module InstanceMethods

    def sanitize_fields
      # fix a bug with Rails internal AR::Base models that get loaded before
      # the plugin, like CGI::Sessions::ActiveRecordStore::Session
      return if xss_terminate_options.nil?
      
      self.class.columns.each do |column|
        next unless (column.type == :string || column.type == :text)
        
        field = column.name.to_sym
        value = self[field]

        next if value.nil? || !value.is_a?(String)
        
        if xss_terminate_options[:except].include?(field)
          next
        elsif xss_terminate_options[:html5lib_sanitize].include?(field)
          if  xss_terminate_options[:html5lib_options].empty?
            self[field] = RailsSanitize.white_list_sanitizer.sanitize(value)
          elsif xss_terminate_options[:html5lib_options].include?(:whitelist_attrs)
            self[field] = RailsSanitize.white_list_sanitizer.sanitize(value,
                           {:attributes => RailsSanitize.white_list_sanitizer.allowed_attributes +
                             (Set.new(xss_terminate_options[:html5lib_options][:whitelist_attrs].map(&:to_s)))})
          end
        else
          self[field] = CoupaHelper.coupa_sanitize(value)
        end
      end
      
    end
  end
end

ActiveRecord::Base.send(:include, XssTerminate)
ActiveRecord::Base.before_validation :sanitize_fields
