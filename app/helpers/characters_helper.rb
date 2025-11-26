module CharactersHelper
  def character_image(character)
    # Normalisation : minuscules, accents remplacés, espaces -> tirets
    filename = character.name.downcase
                           .tr("éèêëàâîïôûùç", "eeeeaaaiiouuc") # accents
                           .gsub(/[^a-z0-9]+/, "-")              # caractères non-alphanum -> tiret
                           .gsub(/^-|-$/, "")                     # supprime tirets de début/fin
                           + ".png"

    # En production, on fait confiance aux assets précompilés
    if Rails.env.production?
      filename
    else
      # En développement, on vérifie que le fichier existe
      if Rails.application.assets && Rails.application.assets.find_asset(filename)
        filename
      else
        "placeholder.png"
      end
    end
  end
end
