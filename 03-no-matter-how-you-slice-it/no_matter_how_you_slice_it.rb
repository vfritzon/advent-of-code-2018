class NoMatterHowYouSliceIt
  attr_reader :cloth, :claims
  def initialize(claim_strings)
    @cloth = Array.new(1000) { Array.new(1000, 0) }
    @claims = claim_strings.map do |c|
      match = c.match(/\#(?<id>\d+) @ (?<left>\d+),(?<top>\d+): (?<width>\d+)x(?<height>\d+)/)
      Claim.new(
        match[:id],
        match[:left],
        match[:top],
        match[:width],
        match[:height])
    end

    @claims.each do |c|
      c.columns.each { |col| c.rows.each { |row| cloth[col][row] = cloth[col][row] + 1} }
    end
  end

  def overlap_count
    @cloth.sum {|c| c.count { |r| r >= 2 }}
  end

  def no_overlap_ids
    claims
      .select {|claim| @cloth[claim.columns].flat_map {|col| col[claim.rows]}.sum == claim.size}
      .map {|claim| claim.id}
  end
end

class Claim
  attr_reader :id, :columns, :rows, :size

  def initialize(id, left, top, width, height)
    @id = id
    @columns = left.to_i...left.to_i + width.to_i
    @rows = top.to_i...top.to_i + height.to_i
    @size = @columns.size * @rows.size
  end
end
