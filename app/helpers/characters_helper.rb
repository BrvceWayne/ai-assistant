module CharactersHelper
  def character_image(character)
    # Normalisation du nom
    filename = character.name.downcase
                           .tr("éèêëàâîïôûùç", "eeeeaaaiiouuc")
                           .gsub(/[^a-z0-9]+/, "-")
                           .gsub(/^-|-$/, "")

    # Retourne l'URL Cloudinary
    "https://res.cloudinary.com/#{ENV['CLOUDINARY_CLOUD_NAME']}/image/upload/characters/#{filename}.png"
  rescue
    "https://via.placeholder.com/400x300?text=No+Image"
  end
end
