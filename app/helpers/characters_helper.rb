module CharactersHelper
  def character_image(character)
    # Normalisation du nom
    filename = character.name.downcase
                           .tr("éèêëàâîïôûùç", "eeeeaaaiiouuc")
                           .gsub(/[^a-z0-9]+/, "-")
                           .gsub(/^-|-$/, "")

    # URL Cloudinary
    Cloudinary::Utils.cloudinary_url("characters/#{filename}.png",
      secure: true,
      transformation: [
        { width: 400, crop: :fill }  # Optionnel : resize automatique
      ]
    )
  rescue => e
  
    Cloudinary::Utils.cloudinary_url("placeholder.png", secure: true)
  end
end
