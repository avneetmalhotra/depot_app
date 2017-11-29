class CategoryIdsValidator < ActiveModel::Validator
  def validate(record)
    record.errors[:category_ids] << 'need to be selected(atleast one)' if record.category_ids.empty?
  end
end
