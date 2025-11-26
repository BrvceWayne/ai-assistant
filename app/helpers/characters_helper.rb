module CharactersHelper
  def character_image(character)
    # Normalisation du nom
    filename = character.name.downcase
                           .tr("éèêëàâîïôûùç", "eeeeaaaiiouuc")
                           .gsub(/[^a-z0-9]+/, "-")
                           .gsub(/^-|-$/, "")

    # Utilise la méthode Cloudinary
    Cloudinary::Utils.cloudinary_url("characters/#{filename}.png", secure: true)
  rescue
    "https://via.placeholder.com/400x300?text=No+Image"
  end
end
