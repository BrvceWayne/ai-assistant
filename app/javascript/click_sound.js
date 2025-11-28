// ============================================
// CLICK SOUND HANDLER
// Gère les sons de clic pour le jeu
// ============================================

document.addEventListener('DOMContentLoaded', function() {
  console.log('🎵 Click sound system initializing...');
  
  // Preload all sounds
  const clickSound = new Audio('/sounds/video-game-select-337214.mp3');
  clickSound.volume = 0.5;
  clickSound.preload = 'auto';
  
  const cyberpunkSound = new Audio('/sounds/cyber-punk-95771.mp3');
  cyberpunkSound.volume = 0.5;
  cyberpunkSound.preload = 'auto';
  
  const magicalSound = new Audio('/sounds/magical-reveal-start-388923.mp3');
  magicalSound.volume = 0.6;
  magicalSound.preload = 'auto';
  
  // Character hover sounds
  const warriorSound = new Audio('/sounds/middle-ages-war-crywav-14780.mp3');
  warriorSound.volume = 0.5;
  warriorSound.preload = 'auto';
  
  const mageSound = new Audio('/sounds/magical-spell-cast-190272.mp3');
  mageSound.volume = 0.5;
  mageSound.preload = 'auto';
  
  const rogueSound = new Audio('/sounds/chuckles_man_grinning_sqeeekwav-14835.mp3');
  rogueSound.volume = 0.5;
  rogueSound.preload = 'auto';
  
  const clericSound = new Audio('/sounds/knowledge-of-the-ages-44537.mp3');
  clericSound.volume = 0.5;
  clericSound.preload = 'auto';
  
  console.log('✅ All sounds preloaded');
  
  // Hover sound for Rues Neon scenario
  function playHoverSound(event) {
    const card = event.currentTarget;
    const scenarioName = card.dataset.scenario;
    
    console.log('🖱️ Hover detected on:', scenarioName);
    
    if (scenarioName === 'rues-neon') {
      console.log('🎵 Playing cyberpunk hover sound');
      cyberpunkSound.currentTime = 0;
      cyberpunkSound.play()
        .then(() => console.log('✅ Cyberpunk sound played'))
        .catch(error => console.error('❌ Cyberpunk sound failed:', error));
    }
  }
  
  // Hover sound for characters
  function playCharacterHoverSound(event) {
    const card = event.currentTarget;
    const characterClass = card.classList.toString();
    
    console.log('🖱️ Character hover detected:', characterClass);
    
    let sound = null;
    
    if (characterClass.includes('character-warrior')) {
      sound = warriorSound;
      console.log('⚔️ Playing warrior sound');
    } else if (characterClass.includes('character-mage')) {
      sound = mageSound;
      console.log('🔮 Playing mage sound');
    } else if (characterClass.includes('character-rogue')) {
      sound = rogueSound;
      console.log('🗡️ Playing rogue sound');
    } else if (characterClass.includes('character-cleric')) {
      sound = clericSound;
      console.log('✨ Playing cleric sound');
    }
    
    if (sound) {
      sound.currentTime = 0;
      sound.play()
        .then(() => console.log('✅ Character sound played'))
        .catch(error => console.error('❌ Character sound failed:', error));
    }
  }
  
  // Click sound for scenarios
  function playScenarioClickSound(event) {
    console.log('🔊 Scenario click');
    clickSound.currentTime = 0;
    clickSound.play().catch(error => {
      console.log('Audio play prevented:', error);
    });
  }
  
  // Magical sound for new game button
  function playMagicalSound(event) {
    console.log('✨ Playing magical new game sound');
    magicalSound.currentTime = 0;
    magicalSound.play()
      .then(() => console.log('✅ Magical sound played'))
      .catch(error => console.error('❌ Magical sound failed:', error));
  }
  
  // Default click sound
  function playClickSound(event) {
    console.log('🔊 Default click');
    clickSound.currentTime = 0;
    clickSound.play().catch(error => {
      console.log('Audio play prevented:', error);
    });
  }
  
  // Add sounds to scenario cards
  const scenarioCards = document.querySelectorAll('.scenario-card');
  console.log('📋 Found scenario cards:', scenarioCards.length);
  
  scenarioCards.forEach((card, index) => {
    console.log(`  Card ${index}: ${card.dataset.scenario}`);
    
    // Add hover listener
    card.addEventListener('mouseenter', playHoverSound);
    console.log(`  ✅ Added hover listener to card ${index}`);
    
    // Add click listener
    card.addEventListener('click', playScenarioClickSound);
    console.log(`  ✅ Added click listener to card ${index}`);
  });
  
  // Stop character sounds
  function stopCharacterSounds() {
    warriorSound.pause();
    warriorSound.currentTime = 0;
    mageSound.pause();
    mageSound.currentTime = 0;
    rogueSound.pause();
    rogueSound.currentTime = 0;
    clericSound.pause();
    clericSound.currentTime = 0;
  }
  
  // Add hover and click sounds to character cards
  const characterCards = document.querySelectorAll('.character-card');
  console.log('📋 Found character cards:', characterCards.length);
  characterCards.forEach((card, index) => {
    // Add hover listener
    card.addEventListener('mouseenter', playCharacterHoverSound);
    console.log(`  ✅ Added hover listener to character card ${index}`);
    
    // Add mouse leave listener to stop sound
    card.addEventListener('mouseleave', stopCharacterSounds);
    console.log(`  ✅ Added mouseleave listener to character card ${index}`);
    
    // Add click listener
    card.addEventListener('click', playClickSound);
    console.log(`  ✅ Added click listener to character card ${index}`);
  });
  
  // Add magical sound to "Nouvelle partie" buttons
  const newGameForms = document.querySelectorAll('form[action="/games"]');
  console.log('📋 Found new game forms:', newGameForms.length);
  
  newGameForms.forEach((form, index) => {
    const method = form.querySelector('input[name="_method"]')?.value || form.method;
    console.log(`  Form ${index} method:`, method);
    
    if (method.toLowerCase() === 'post') {
      form.addEventListener('submit', function(e) {
        playMagicalSound(e);
      });
      console.log(`  ✅ Added magical sound to form ${index}`);
    }
  });
  
  // Add default click sound to other buttons
  const buttons = document.querySelectorAll('.btn-dd, .btn-start, .btn-back, .btn-send-action, .btn-quit');
  console.log('📋 Found other buttons:', buttons.length);
  buttons.forEach(button => {
    const parentForm = button.closest('form[action="/games"]');
    if (!parentForm) {
      button.addEventListener('click', playClickSound);
    }
  });
  
  console.log('✅✅✅ Click sound system loaded successfully! ✅✅✅');
});