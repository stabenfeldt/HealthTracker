defmodule HealthTracker.DateUtils do
  def last_four_weeks_dates do
    end_date = Date.utc_today()
    # 4 weeks = 28 days, including today
    start_date = Date.add(end_date, -27)

    for x <- 0..27,
        do: Date.add(start_date, x)
  end
end
