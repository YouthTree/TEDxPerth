class UserStatistics

  def self.signups_per_day(from = Date.today - 6, to = Date.today)
      from, to = from.to_date, to.to_date
      scope = User.where(["users.created_at > ? AND users.created_at < ?", from.beginning_of_day, to.beginning_of_day])
      counts = normalize_dates scope.count(:all, :group => "DATE(users.created_at)")
      results = ActiveSupport::OrderedHash.new
      while from <= to
        results[from] = counts[from].to_i
        from += 1
      end
      results
    end

    protected

    def self.normalize_dates(collection)
      collection.inject({}) do |acc, (k, v)|
        acc[k.to_date] = v
        acc
      end
    end

end