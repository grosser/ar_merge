require 'ar_merge/version'
require 'active_record'

module ARMerge
  module InstanceMethods
    def merge!(other, options={})
      raise "cannot merge wit a new record" if other.new_record?
      raise "cannot merge with myself" if other == self

      #merge associations
      (options[:associations]||[]).each do |association_name|
        send(association_name).concat other.send(association_name)

        if ActiveRecord::VERSION::MAJOR < 4
          #update counters, this is very basic/hacky/not secure for customized counters...
          counter = "#{association_name}_count"
          next unless other.respond_to?(counter) and respond_to?("#{counter}=")
          self.class.update_counters(id, counter => other.send(counter))
        end
      end

      #merge attributes
      (options[:attributes]||[]).each do |attr|
        send("#{attr}=", other.send(attr)) if send(attr).blank?
      end

      #cleanup
      other.reload.destroy
      save!
    end
  end

  module ClassMethods
    def merge_duplicates!(records,options)
      records.each do |record|
        next if record.nil?
        records.each do |other|
          next if other.nil?
          next if other == record
          is_comparable = other.send(options[:compare]) == record.send(options[:compare])
          next unless is_comparable

          #merge and remove the other
          records[records.index(other)]=nil
          record.merge!(other)
        end
      end.compact
    end
  end
end

ActiveRecord::Base.send(:include, ARMerge::InstanceMethods)
ActiveRecord::Base.send(:extend, ARMerge::ClassMethods)
