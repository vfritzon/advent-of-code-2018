def repose_record(log_lines)
  guard_sleeps = Hash.new

  while (log_lines.any?) do
    guard = get_guard_id(log_lines.shift)

    sleep_wake_lines = log_lines
      .take_while {|l| !l.include? "#"}
    log_lines.shift(sleep_wake_lines.size)

    sleeping_minutes = 
      get_sleeping_minutes(sleep_wake_lines, [])

    guard_sleeps[guard] =
      (guard_sleeps[guard] || [])
      .concat(sleeping_minutes)
  end

  sleepiest_guard, minutes =
    get_sleepiest_guard(guard_sleeps)

  quiz_1 = sleepiest_guard *
    most_slept_minutes(minutes).first

  predictable_sleeper, minutes =
    guard_sleeps.max_by do |k,v|
      most_slept_minutes(v) == nil ?
        -1 :
        most_slept_minutes(v)[1].size
    end

  quiz_2 = predictable_sleeper *
    most_slept_minutes(minutes).first

  [quiz_1, quiz_2]
end

def get_sleepiest_guard(guard_sleeps)
  guard_sleeps.max_by {|k,v| v.size}
end

def most_slept_minutes(minutes)
  minutes.group_by(&:itself).max_by {|k,v| v.size}
end

def get_guard_id line
  line.scan(/#(\d+)/).first.first.to_i
end

def get_sleeping_minutes lines, acc
  return acc if lines.empty?

  sleep_line, wake_line = lines.shift(2)

  sleep_minutes = 
    get_minute_stamp(sleep_line)...
    get_minute_stamp(wake_line)

  get_sleeping_minutes(
    lines,
    acc.concat(sleep_minutes.to_a))
end

def get_minute_stamp line
  line.scan(/:(\d+)/).first.first.to_i
end
