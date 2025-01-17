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

- Peds where players can buy configurable stock from using [Config.MoneyItem]
- Ped where players can sell configurable items, receiving [Config.MoneyItem]
- Configurable & unique money washing locations across the city, with the ability to be robbed and interrogated (Converts[Config.MoneyItem] to ["money"])
- Ped where players can interact with and see what attachments can be applied to their currently equipped weapon
- Ped where players can fully repair their currently equipped weapon

# How do players access the blackmarket?

One of two ways:

- Players can complete a hack, providing them a code, that is generated when the resource first starts, that they can give to the entrance ped
- Players can  correctly answer a randomly generated riddle, which can be found and configured in [Config.EntranceTypes.Riddles]

# How do players exit the market?

- Players can simply speak to one of the peds inside the market and select the leave option. Upom leaving they'll be dropped in one of the configured 
[Config.BlackMarketAccess.ExitInfo.ExitLandingLocations]

# How do I move the locations of stuff?

All locations are in the [config.lua]. So moving everything is kept just about all in one place!

# Why can't my players take a car inside the market?

Not all servers will have their markets in vehicle friendly locations, we decided not to allow this by default.

# Why aren't you using ["marked_bills"] for your currency of dirty money?

- We prefer the use of individual items for money!

# If there's anything you'd like to see added to this resource in the future, head over to our Discord and throw a suggestion our way!

# Special thanks to Baubles for all her contributions