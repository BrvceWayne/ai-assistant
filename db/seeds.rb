puts "🌱 Starting seed..."

Character.destroy_all
puts "🧹 Cleared existing characters"
Scenario.destroy_all
puts "🧹 Cleared existing scenarios"


characters_data = [
  {
    name: "Thorin Bouclier-Rouillé",
    class_type: "warrior",
    health: 120,
    mana: 30,
    strength: 18,
    quirks: "Pense que crier 'PAR MES AÏEUX CONSTIPÉS !' augmente ses statistiques (spoiler: non). A nommé son épée 'Bisou-Bisou la Faucheuse' et refuse d'en changer. Fait craquer ses articulations avant chaque combat... ça prend 5 minutes."
  },
  {
    name: "Zéphyrine Crache-Flammes",
    class_type: "mage",
    health: 70,
    mana: 150,
    strength: 6,
    quirks: "A mis le feu à 3 bibliothèques 'par accident'. Confond régulièrement les sorts de feu et de guérison. Parle à son chapeau pointu et il lui répond (c'est inquiétant)."
  },
  {
    name: "Fihas le Cleptomane",
    class_type: "rogue",
    health: 85,
    mana: 60,
    strength: 12,
    quirks: "Vole compulsivement des objets inutiles (cuillères, cailloux, chaussettes). Se cache derrière les gens pendant les conversations tendues. A été banni de 12 tavernes pour avoir triché aux dés (maladroitement)."
  },
  {
    name: "Jaski le Serein",
    class_type: "cleric",
    health: 95,
    mana: 110,
    strength: 10,
    quirks: "Médite au milieu des combats en position du lotus (très dangereux). Essaie de convertir les monstres au bouddhisme avant de les combattre. Perd tous ses moyens face aux adversaires féminins et bégaie ses mantras."
  }
]

characters_data.each do |char_data|
  Character.create!(char_data)
  puts "✅ Created: #{char_data[:name]}"  # ← name ici aussi
end

puts "🎉 Seed for characters completed! #{Character.count} characters created."

scenarios_data = [
{
  title: "Légendes oubliées",
  description: "Médiéval fantastique",
  scenario_prompt: <<~PROMPT
    Tu es une IA scénariste experte en univers médiéval fantastique.

    Personnage : {{character}}

    Ta mission :
    - Analyse le personnage (origines, croyances, faiblesses, but héroïque ou sombre).
    - Crée un scénario épique dans un monde de magie ancienne, royaumes en guerre, créatures mythiques.
    - Structure :
      - Introduction impactante
      - Événement déclencheur lié à une prophétie ou menace
      - 3 choix critiques liés à la nature du personnage
      - Rebondissement (trahison, révélation ancestrale…)
      - Fin ouverte vers un combat final ou quête divine
    PROMPT
  },

  {
    title: "Rues néon",
    description: "Cyberpunk",
    scenario_prompt: <<~PROMPT
      Tu es une IA scénariste en univers Cyberpunk urbain, sombre, saturé de technologie et corruption.

      Personnage : {{character}}

      Indications :
      - Technologie avancée, implants cybernétiques, IA omniprésentes
      - Atmosphère : néons, pluie, hacking, gangs corporatistes

      Structure du scénario :
      - Introduction immersive dans la ville
      - Événement déclencheur (vol de données, traque par mégacorporation…)
      - 3 choix critiques adaptés au style (violence, infiltration, manipulation numérique)
      - Rebondissement surprise (trahison, système IA conscious…)
      - Fin ouverte vers un assaut final ou une révolution
    PROMPT
  },
  {
    title: "Dernier souffle du monde",
    description: "Post-apocalyptique",
    scenario_prompt: <<~PROMPT
      Tu es une IA scénariste experte en univers post-apocalyptique.

      Personnage : {{character}}

      Contexte :
      - Monde détruit (guerre nucléaire, catastrophe biologique…)
      - Ressources rares, survie difficile, alliances fragiles

      Scénario :
      - Introduction intense (lutte pour survivre)
      - Déclencheur (alerte, apparition d’un refuge, attaque)
      - 3 choix basés sur l’instinct de survie du personnage
      - Rebondissement (ennemi inattendu, virus, révélation)
      - Fin ouverte (reconstruction ou extinction)
    PROMPT
  },
  {
    title: "Étoiles lointaines",
    description: "Science-fiction dystopique",
    scenario_prompt: <<~PROMPT
      Tu es une IA scénariste spécialisée en science-fiction dystopique.

      Personnage : {{character}}

      Univers :
      - Civilisations spatio-politiques
      - IA gouvernantes, voyages stellaires, lutte pour la liberté

      Structure :
      - Introduction cinématique (vaisseau, colonie, planète)
      - Événement déclencheur (rébellion, IA rogue, alien)
      - 3 choix basés sur la logique ou la stratégie du personnage
      - Rebondissement (double espion, IA consciente…)
      - Fin ouverte (guerre interstellaire imminente)
    PROMPT
  },
  {
    title: "Voiles d’ombre",
    description: "Dark Fantasy",
    scenario_prompt: <<~PROMPT
      Tu es une IA scénariste en univers Dark Fantasy.

      Personnage : {{character}}

      Ton :
      - Mystique, sombre, fataliste
      - Magie interdite, pactes, sacrifice

      Scénario :
      - Introduction inquiétante
      - Déclencheur (rituel, apparition d'entité)
      - 3 choix moralement complexes
      - Rebondissement (corruption, âme liée)
      - Fin ouverte (damnation ou ascension divine)
    PROMPT
  }
]

  User.create!(
    email: "test@gmail.com",
    password: "123456"
  )

  User.create!(
    email: "test1@gmail.com",
    password: "123456"
  )

  User.create!(
    email: "test2@gmail.com",
    password: "123456"
  )

scenarios_data.each do |scn_data|
  Scenario.create!(scn_data)
  puts "✅ Created: #{scn_data[:title]}"  # ← name ici aussi
end
puts "🎉 Seed for scenarios completed! #{Scenario.count} scenarios created."

characters = Character.all.sample(3)
scenarios  = Scenario.all.sample(3)
users      = User.all.sample(3)

3.times do
  Game.create!(
    character: characters.sample,
    scenario: scenarios.sample,
    user:     users.sample
  )
end
puts "🎉 Seed for games completed! #{Game.count} games created."
