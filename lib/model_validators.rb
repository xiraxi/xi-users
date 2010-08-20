
class ValidPasswordValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    pw = record.send(attribute)
    return if pw.nil?
    if not record.valid_password?(pw)
      record.errors.add attribute, options[:message] || :invalid_password
    end
  end
end
