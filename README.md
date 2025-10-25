# Documentation: https://vibrantrp.gitbook.io/vibrant-documentation/free-resources/blackmarket
# Discord: https://discord.gg/mTzwCnNcaX

# DEPENDENCIES

- QBCore
- ox_lib
- ox_inventory
- ox_target
- bl_ui

# FAQ

# What does this resource provide?

- Peds where players can buy & sell items
- Ped where players can interact with and see what attachments can be applied to their currently equipped weapon
- Ped where players can fully repair their currently equipped weapon using repair values based on the weapon type
- Placable items where players can put [Config.DirtyMoneyItem] in the stash of and see a return of [Config.CleanMoneyItem] over time

# How do players access the blackmarket?

- Players can  correctly answer a randomly generated riddle, which can be found and configured in [Config.EntranceTypes.Riddles]

# How do players exit the market?

- Players can simply speak to one of the peds inside the market and select the leave option. Upom leaving they'll be dropped in one of the configured 
[Config.BlackMarketAccess.ExitInfo.ExitLandingLocations]

# How do I move the locations of stuff?

All locations are in the [config.lua] so moving everything is kept just about all in one place!

# Why can't my players take a car inside the market?

Not all servers will have their markets in vehicle friendly locations, we decided not to allow this by default.

# Why aren't you using ["marked_bills"] for your currency of dirty money?

- We prefer the use of individual items for money!

# How do players wash their money?

- Well, firstly you'll need to create an item and trigger this even in the item [moneywash:client:PlaceDownObject], once the item is placed
- all the player needs to do is add any [Config.DirtyMoneyItem] into the stash of the item and it'll  be converted automatically
- These items are NOT persistant as it'll help encourage players to manage what they're doing

# If there's anything you'd like to see added to this resource in the future, head over to our Discord and throw a suggestion our way!