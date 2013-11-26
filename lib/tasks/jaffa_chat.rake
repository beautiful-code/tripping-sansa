namespace :jaffa_chat do

  # TODO: Not necessary for new clip uploads.
  desc "compute dimensions (for legacy clips)"
  task :compute_dimensions,  [:prefix] => :environment do |t, args|
    Clip.all.each do |clip|
      next if clip.dimensions.present?

      next unless clip.file
      tempfile = clip.file
      unless tempfile.nil?
        geometry = Paperclip::Geometry.from_file(tempfile)
        dimensions = [geometry.width.to_i, geometry.height.to_i]
        clip.update_attribute(:dimensions, dimensions)
      end

    end
  end
  
end
