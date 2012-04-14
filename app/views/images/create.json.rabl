object @image.image => :image
attributes :url
node :versions do |image|
  versions = image.versions
  versions.each do |k,v|
    versions[k] = v.to_s
  end
end
