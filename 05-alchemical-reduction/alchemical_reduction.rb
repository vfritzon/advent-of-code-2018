def alchemical_reduction(polymers)
  current = polymers
  loop do
    length_before = current.size
    current = one_lap_reduce current
    break if current.size == length_before
  end

  current.size
end

def with_removal char, polymers
  removed = polymers.delete char.upcase + char.downcase
  alchemical_reduction removed
end

def best_removal(polymers)
    polymers.downcase.chars.uniq.
      map {|c| [c, with_removal(c, polymers)]}
      .min_by {|c, reduction| reduction}
end

def one_lap_reduce(polymers)
  i = 0
  acc = ""
  while (i < polymers.size)
    curr = polymers[i]
    nexxt = polymers[i + 1]

    if should_remove(curr, nexxt)
      i = i + 2
    else
      acc += curr
      i = i + 1
    end
  end

  acc
end

def should_remove(a, b)
  return false if a == nil || b == nil
  a.upcase == b.upcase &&
    casing(a) != casing(b)
end

def casing(c)
  c.upcase == c ? :upper : :lower
end
