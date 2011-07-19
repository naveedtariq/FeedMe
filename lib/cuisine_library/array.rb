class Array
  def sum
    inject(0) {|total,x| total += (x.respond_to? :to_f) ? x.to_f : 0}
  end
end