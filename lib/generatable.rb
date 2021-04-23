module Generatable

  def generate_random_key
    random_key = rand.to_s.slice(2..6)
  end

  def generate_key_hash(key = generate_random_key)
    hash = {
      A: key.slice(0..1).to_i,
      B: key.slice(1..2).to_i,
      C: key.slice(2..3).to_i,
      D: key.slice(3..4).to_i
    }
  end

  def generate_offset_hash(date = Date.today.strftime('%d%m%y').to_i)
    offset_base = (date ** 2).to_s.slice(2..5)
    hash = {
      A: offset_base.slice(3).to_i,
      B: offset_base.slice(2).to_i,
      C: offset_base.slice(1).to_i,
      D: offset_base.slice(0).to_i
    }
  end

  def generate_shift_hash
    key_hash = generate_key_hash
    offset_hash = generate_offset_hash
    hash = {
      A: key_hash[:A] + offset_hash[:A],
      B: key_hash[:B] + offset_hash[:B],
      C: key_hash[:C] + offset_hash[:C],
      D: key_hash[:D] + offset_hash[:D]
    }
  end
end