# Engarde

# File system's structure
- Assets -> folder for image, sound , video and etc
- Component -> folder for prefab and script that have been made
- Resource -> folder for resource object
- Scene -> folder for main scenes
- Script -> folder for widely used scripts like singleton and objects

# Singleton
- GameManager -> Manages mainly game state and persistence data
- NotificationManager -> Manages notification popup for confirmation/information
- SceneHandler -> Manages transition between scenes
- SignalManager -> Stores global signal that can aid on reducing coupling

# Main scenes 
- CampaignStage -> playing arena
- MainMenu -> start menu
- EditDeckMenu -> editing deck menu

# Object & resource
- card_configuration -> blueprint for a card information
- player_profile -> stores deck and collection info

# UI Component
- card_object_ui -> interactive ui for card that use card_configuration to initialize
- card_bullet_ui -> shows card information and available interaction for the card
- general_button -> base button 
- general_popup_menu -> popup sub menu 

# How to play 
- Player can select their deck to open edit menu.
- In edit menu player can discard / add / buy / sell card from / to deck.
