

puts "🌱 Starting seed..."

Character.destroy_all
puts "🧹 Cleared existing characters"

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
  # puts char_data[:name]
end

puts "🎉 Seed completed! #{Character.count} characters created."
