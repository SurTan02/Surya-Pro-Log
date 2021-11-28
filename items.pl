/* Semua item yang ada
item(ID, Name, String_Name, Type, Level, EnergyNeed, EnergySupply, Price) */
:- dynamic(item/8).

item(1, cow, 'cow', rancher, 0, 0, 0, 2000).
item(2, chicken, 'chicken', rancher, 0, 0, 0, 500).
item(3, sheep, 'sheep', rancher, 0, 0, 0, 1200).

item(4, milk, 'milk', rancherProd, 0, 1000, 0, 40).
item(5, egg, 'egg', rancherProd, 0, 300, 0, 10).
item(6, wool, 'wool', rancherProd, 0, 600, 0, 20).

item(7, cheese, 'cheese', rancher, 7, 0, 0, 60).
item(8, mayonnaise, 'mayonnaise', rancher, 3, 0, 0, 15).
item(9, sweater, 'sweater', rancher, 5, 0, 0, 30).

item(10, carrot_seed, 'carrot seed', farmer, 1, 0, 0, 5).
item(11, potato_seed, 'potato seed', farmer, 1, 0, 0, 7).
item(12, corn_seed, 'corn seed', farmer, 1, 0, 0, 9).
item(13, tomato_seed, 'tomato seed', farmer, 2, 0, 0, 12).
item(14, pumpkin_seed, 'pumpkin seed', farmer, 3, 0, 0, 15).

item(15, carrot, 'carrot', farmerProd, 0, 150, 0, 10).
item(16, potato, 'potato', farmerProd, 0, 175, 0, 14).
item(17, corn, 'corn', farmerProd, 0, 450, 0, 18).
item(18, tomato, 'tomato', farmerProd, 0, 800, 0, 25).
item(19, pumpkin, 'pumpkin', farmerProd, 0, 1000, 0, 35).

item(20, betutu_fish, 'betutu fish', fisherman, 0, 0, 0, 40). 
item(21, gurame_fish, 'gurame fish', fisherman, 0, 0, 0, 20).
item(22, teri_fish, 'teri fish', fisherman, 0, 0, 0, 5).

item(23, energy_drink, 'energyDrink', consumable, 0, 0, 50, 20).
item(24, coffee_bts, 'coffeeBTS', consumable, 0, 0, 75, 30).
item(25, specialties_potion, 'specialtiesPotion', consumable, 0, 0, 0, 1000).

item(26, shovel, 'level 1 shovel', equipment, 1, 0, 0, 50).
item(27, shovel, 'level 2 shovel', equipment, 2, 0, 0, 100).
item(28, shovel, 'level 3 shovel', equipment, 3, 0, 0, 150).
item(29, fishingrod, 'level 1 fishing rod', equipment, 1, 0, 0, 50).
item(30, fishingrod, 'level 2 fishing rod', equipment, 2, 0, 0, 100).
item(31, fishingrod, 'level 3 fishing rod', equipment, 3, 0, 0, 150).
item(32, boat, 'level 1  boat', equipment, 1, 0, 0, 200).
item(33, boat, 'level 2 boat', equipment, 2, 0, 0, 300).
item(34, boat, 'level 3 boat', equipment, 3, 0, 0, 400).



/* Item yang bisa dibeli di market */
onsale(cow).
onsale(chicken).
onsale(sheep).
onsale(carrot_seed).
onsale(potato_seed).
onsale(corn_seed).
onsale(tomato_seed).
onsale(pumpkin_seed).
onsale(energy_drink).
onsale(coffee_bts).
onsale(pupuk_mbah_subur).
onsale(shovel).
onsale(fishingrod).

/* Item yang bisa dijual ke market */
sellable(milk).
sellable(egg).
sellable(wool).
sellable(cheese).
sellable(mayonnaise).
sellable(sweater).
sellable(carrot).
sellable(potato).
sellable(corn).
sellable(tomato).
sellable(pumpkin).
sellable(betutu_fish).
sellable(gurame_fish).
sellable(teri_fish).