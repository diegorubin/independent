Dir.entries(File.join(Rails.root.to_s, "widgets")).each do |entry|
  next if entry =~ /^\.{1,2}$/

  widget = Widget.find_or_initialize_by(label: entry)
  widget.load_manifest(
    File.open(File.join(Rails.root.to_s, 'widgets', entry, 'manifest.yml'))
  )
  puts "Load Widget: #{entry}" if widget.save

end

Widget.all.each do |widget|
  widget.manifest['widget']['models'].each do |m|

    next if m =~ /^\.{1,2}$/

    puts "loading model: #{m}"
    require File.join(Rails.root.to_s, "widgets", widget.label + "_widget", "models", m.underscore + ".rb")

  end
end

