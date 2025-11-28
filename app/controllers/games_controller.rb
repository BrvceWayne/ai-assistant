class GamesController < ApplicationController
  def index
    @games = Game.all.order(created_at: :desc)
    # @scenario = Scenario.find(params[:scenario_id])
    # @character = Character.find(params[:character_id])
  end

  def scenarios
    @scenarios = Scenario.all
  end

  def characters
    @characters = Character.all
    @scenario = Scenario.find(params[:scenario_id])
  end

  def create
    @game = Game.new(
      user_id: current_user.id,
      scenario_id: params[:scenario_id],
      character_id: params[:character_id],
      state: 'in_progress'
    )

    if @game.save
      begin
        # Créer une session de chat
        chat = RubyLLM.chat

        # Construire un prompt texte (pas array)
        intro_prompt = <<~PROMPT
          #{@game.scenario.scenario_prompt}

          #{build_character_context}

          Commence l'aventure maintenant. Plonge-moi directement dans l'action.
        PROMPT

        # Appeler l'API
        response = chat.ask(intro_prompt)
        intro = response.content

      rescue => e
        Rails.logger.error("Erreur intro: #{e.message}")
        intro = "Bienvenue #{@game.character.name} dans #{@game.scenario.title}..."
      end

      @game.messages.create!(role: "assistant", content: intro)
      redirect_to game_path(@game)
    else
      redirect_to characters_games_path, alert: "Erreur"
    end
 end

def show
      @game = Game.find(params[:id])
      @character = @game.character
      @scenario = @game.scenario
      @messages = @game.messages.order(created_at: :asc)
    end

 def player_action
  @game = Game.find(params[:id])
  player_input = params[:action_text]

  # Sauvegarder message joueur
  @game.messages.create!(role: "user", content: player_input)

  begin
    chat = RubyLLM.chat

    full_prompt = <<~PROMPT
      #{@game.scenario.scenario_prompt}

      #{build_character_context}

      HISTORIQUE DE LA PARTIE :
      #{build_history}

      Action du joueur : #{player_input}

      Réponds en tant que maître du jeu :
    PROMPT

    response = chat.ask(full_prompt)
    ai_response = response.content

    if ai_response.blank?
      ai_response = "Le maître du jeu semble perdu... Réessayez."
    end

  rescue => e
    Rails.logger.error("❌ Erreur: #{e.message}")
    ai_response = "Le maître du jeu réfléchit... Réessayez."
  end

  # Sauvegarder avec un flag "nouveau"
  @new_message = @game.messages.create!(role: "assistant", content: ai_response)

  # Stocker l'ID du nouveau message en session
  session[:new_message_id] = @new_message.id

  redirect_to game_path(@game)
end

  def destroy
    @game = Game.find(params[:id])
    @game.destroy

    redirect_to games_path, notice: "Partie supprimée avec succès"
  end

private

  def build_character_context
    <<~CONTEXT
      PERSONNAGE DU JOUEUR :
      - Nom : #{@game.character.name}
      - Classe : #{@game.character.class_type}
      - Points de Vie : #{@game.character.health}
      - Mana : #{@game.character.mana}
      - Force : #{@game.character.strength}
      - Particularités : #{@game.character.quirks}

      Adapte ta narration en fonction de ces caractéristiques.
    CONTEXT
  end

  def build_history
  history = ""
  token_count = 0
  max_tokens = 2000  # Limite de sécurité

  @game.messages.order(created_at: :desc).each do |msg|
    message_text = "#{msg.role == 'user' ? 'Joueur' : 'MJ'}: #{msg.content}\n\n"
    message_tokens = message_text.length / 4  # Estimation : 1 token ≈ 4 caractères

    # Arrêter si on dépasse la limite
    break if token_count + message_tokens > max_tokens

    history = message_text + history  # Ajouter au début (ordre chronologique)
    token_count += message_tokens
  end

  history
end
end
