require 'json'

rows = File.readlines('/tmp/ca25.geojson').map(&:chomp).reject(&:empty?).map do |r|
  begin
    JSON.parse(r)
  rescue
    puts "error in row #{r}"
    nil
  end
end.compact.map { |f| {type: "Feature", geometry: f, properties: {}} }

puts({type: "FeatureCollection", features: rows }.to_json)
