class UserStatistics

  def self.signups_per_day(from = Date.today - 6, to = Date.today)
    from, to = from.to_date, to.to_date
    users = User.select("DATE(users.created_at) AS users_date, count(*) AS count_all").group("users_date")
    users = users.having(["users_date > ? AND users_date < ?", from - 1, to + 1]).all
    users = users.inject({}) { |a, c| a[c.users_date] = c.count_all.to_i; a }
    results = ActiveSupport::OrderedHash.new
    while from <= to
      results[from] = users[from].to_i
      from += 1
    end
    results
  end

end