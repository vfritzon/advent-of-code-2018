class ChronicalCalibration
  def self.compute_file(path)
    (File.readlines path).each.map(&:to_i).sum
  end

  def self.get_first_repeat_from_file(path)
    frequencies = {0 => true}
    current = 0

    while true do
      (File.readlines path).each do |change|
        current = current + change.to_i
        return current if frequencies[current]
        frequencies[current] = true
      end
    end
  end
end

