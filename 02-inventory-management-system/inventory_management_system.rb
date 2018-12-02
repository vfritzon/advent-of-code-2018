class InventoryManageMentSystem
  def self.checksum(lines)
    counts = lines.inject(Hash.new(0)) do |acc, line|
      get_counts(line).each {|n| acc[n] += 1}

      acc
    end

    counts[2] * counts[3]
  end

  def self.get_counts(line)
    line.chars.uniq.map {|c| line.count(c)}.uniq
  end

  def self.common_letters_of_closest_match (lines)
    return "" unless lines.any?

    n = lines.shift
    match = lines.select {|l| differ_by_at_most_one(n, l)}.first
    return  common_letters_of_closest_match lines unless match

    remove_differences(n, match)
  end

  def self.remove_differences(a, b)
    a.chars.each_with_index.select { |e, i| e == b[i] }.map(&:first).join
  end

  def self.differ_by_at_most_one(a, b)
    a.chars.each_with_index.select { |e, i| e != b[i] }.count <= 1
  end
end
