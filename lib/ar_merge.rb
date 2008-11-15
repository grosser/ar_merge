module AR_Merge
  def merge!(other,options={})
    raise "cannot merge wit a new record" if other.new_record?
    raise "cannot merge with myself" if other == self

    #merge associations
    (options[:associations]||[]).each do |association_name|
      other.send(association_name).each do |object|
        send(association_name).concat object
      end
    end

    #merge attributes
    (options[:attributes]||[]).each do |attr|
      send("#{attr}=",other.send(attr)) if send(attr).blank?
    end

    #cleanup
    other.reload.destroy
    save!
  end
end