module SimpleSortable
  
  def is_sortable(field = :position, options = {})
    cattr_accessor :sortable_field, :sortable_condition_field
    self.sortable_field           = field.to_sym
    if options[:if_field]
      self.sortable_condition_field = options[:if_field]
      scope :sortable_items, where(sortable_condition_field => true)
    else
      scope :sortable_items, unscoped
    end
    scope :sorted_desc, order("#{self.sortable_field} DESC")
    scope :sorted_asc,  order("#{self.sortable_field} ASC")
    extend ClassMethods
    include InstanceMethods
    before_save :auto_set_order
    after_save  :normalize_ordering
  end
  
  module InstanceMethods
    
    def auto_set_order
      if should_be_sortable? && send(sortable_field).blank?
        write_attribute sortable_field, self.class.current_max_position + 1
      end
    end
    
    def normalize_ordering
      self.class.reorder_all! if should_be_sortable?
    end
    
    def should_be_sortable?
      sortable_condition_field.blank? || send(:"#{sortable_condition_field}?")
    end
    
  end
  
  module ClassMethods
    
    def reorder_all!(items = nil)
      ids = sortable_items.sorted_asc.select(:id).all.map { |f| f.id }
      reorder! ids
    end
    
    def reorder!(items = nil)
      ids = Array(items).map { |i| i.to_i }.uniq
      # MySQL-fu. Avoid on other databases, mmmkay?
      update_all ["#{sortable_field} = FIND_IN_SET(id, '?')", ids], ['id IN (?)', ids]
    end
    
    def current_max_position
      sortable_items.maximum(sortable_field) || 0
    end
    
  end
  
end