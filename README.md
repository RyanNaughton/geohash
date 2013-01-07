= geohash

Modified from:
* http://github.com/masuidrive/pr_geohash


== DESCRIPTION:

GeoHash encode/decode library for pure Ruby.

It's implementation of http://en.wikipedia.org/wiki/Geohash


== FEATURES

* Encode/decode geohash
* Calculate adjacent geohash


== SYNOPSIS:

  #########
  # Encode latitude and longitude into geohash
  
  GeoHash.encode(47.6062095, -122.3320708)
  # => "c23nb62w20st"
  
  GeoHash.encode(47.6062095, -122.3320708, 6)
  # => "c23nb6"
  
  
  #########
  # Decode from geohash
  
  GeoHash.decode("c23nb6")
  # => [[47.603759765625, -122.332763671875], [47.6092529296875, -122.32177734375]]
  
  
  #########
  # Calculate adjacent geohash
  
  GeoHash.neighbors("xn774c")
  # => ["xn774f", "xn7754", "xn7751", "xn7750", "xn774b", "xn7748", "xn7749", "xn774d"]
  
  =begin
  +--------+--------+--------+
  | xn774d | xn774f | xn7754 |
  +--------+--------+--------+
  | xn7749 | xn774c | xn7751 |
  +--------+--------+--------+
  | xn7748 | xn774b | xn7750 |
  +--------+--------+--------+
  =end



