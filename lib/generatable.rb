module Generatable

  def generate_random_key
    random_key = rand.to_s.slice(2..6)
  end
end