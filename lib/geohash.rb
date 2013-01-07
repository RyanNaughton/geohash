require "geohash/version"

module Geohash
  
  #########
  # Decode from geohash
  # 
  # geohash:: geohash code
  # return:: decoded bounding box [[north latitude, west longitude],[south latitude, east longitude]]
  def decode(geohash)
    latlng = [[-90.0, 90.0], [-180.0, 180.0]]
    is_lng = 1
    geohash.downcase.scan(/./) do |c|
      BITS.each do |mask|
        latlng[is_lng][(BASE32.index(c) & mask)==0 ? 1 : 0] = (latlng[is_lng][0] + latlng[is_lng][1]) / 2
        is_lng ^= 1
      end
    end
    latlng.transpose
  end
  module_function :decode
  
  #########
  # Encode latitude and longitude into geohash
  def encode(latitude, longitude, precision=12)
    latlng = [latitude, longitude]
    points = [[-90.0, 90.0], [-180.0, 180.0]]
    is_lng = 1
    (0...precision).map {
      ch = 0
      5.times do |bit|
        mid = (points[is_lng][0] + points[is_lng][1]) / 2
        points[is_lng][latlng[is_lng] > mid ? 0 : 1] = mid
        ch |=  BITS[bit] if latlng[is_lng] > mid
        is_lng ^= 1
      end
      BASE32[ch,1]
    }.join
  end
  module_function :encode
  
  #########
  # Calculate neighbors (8 adjacents) geohash
  def neighbors(geohash)
    [[:top, :right], [:right, :bottom], [:bottom, :left], [:left, :top]].map{ |dirs|
      point = adjacent(geohash, dirs[0])
      [point, adjacent(point, dirs[1])]
    }.flatten
  end
  module_function :neighbors
  
  #########
  # Calculate adjacents geohash
  def adjacent(geohash, dir)
    base, lastChr = geohash[0..-2], geohash[-1,1]
    type = (geohash.length % 2)==1 ? :odd : :even
    if BORDERS[dir][type].include?(lastChr)
      base = adjacent(base, dir)
    end
    base + BASE32[NEIGHBORS[dir][type].index(lastChr),1]
  end
  module_function :adjacent
  
  def outer_neighbors(top_left_geohash,current_size)
    new_size = current_size + 2
    total_count = new_size*2 + (new_size-2)*2
    new_geohashes = [adjacent(top_left_geohash,:top)]
    directions = [Array.new(new_size-2,:right),Array.new(new_size-1,:bottom),Array.new(new_size-1,:left),Array.new(new_size-1,:top)].flatten
    directions.each do |dir|
      new_geohashes.push(adjacent(new_geohashes.last,dir))
    end
    new_geohashes
  end
  module_function :outer_neighbors
  
  BITS = [0x10, 0x08, 0x04, 0x02, 0x01]
  BASE32 = "0123456789bcdefghjkmnpqrstuvwxyz"
  
  NEIGHBORS = {
    :right  => { :even => "bc01fg45238967deuvhjyznpkmstqrwx", :odd => "p0r21436x8zb9dcf5h7kjnmqesgutwvy" },
    :left   => { :even => "238967debc01fg45kmstqrwxuvhjyznp", :odd => "14365h7k9dcfesgujnmqp0r2twvyx8zb" },
    :top    => { :even => "p0r21436x8zb9dcf5h7kjnmqesgutwvy", :odd => "bc01fg45238967deuvhjyznpkmstqrwx" },
    :bottom => { :even => "14365h7k9dcfesgujnmqp0r2twvyx8zb", :odd => "238967debc01fg45kmstqrwxuvhjyznp" }
  }
  
  BORDERS = {
    :right  => { :even => "bcfguvyz", :odd => "prxz" },
    :left   => { :even => "0145hjnp", :odd => "028b" },
    :top    => { :even => "prxz"    , :odd => "bcfguvyz" },
    :bottom => { :even => "028b"    , :odd => "0145hjnp" }
  }

end
