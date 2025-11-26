namespace :cloudinary do
  desc "Upload character images to Cloudinary"
  task upload: :environment do
    Dir.glob(Rails.root.join('app/assets/images/*.png')).each do |file|
      filename = File.basename(file, '.png')

      result = Cloudinary::Uploader.upload(file,
        public_id: filename,
        folder: 'characters'
      )

      puts "Uploaded: #{filename} -> #{result['secure_url']}"
    end
  end
end
