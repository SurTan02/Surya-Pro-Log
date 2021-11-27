/* Semua item yang ada
item(ID, Name, String_Name, Type, Level, EnergyNeed, EnergySupply, Price) */

item(1, cow, "cow", commodity, 0, 1000, 0, 2000).
item(2, chicken, "chicken", commodity, 0, 300, 0, 500).
item(3, sheep, "sheep", commodity, 0, 600, 0, 1200).

item(4, milk, "milk", commodity, 0, 0, 0, 40).
item(5, egg, "egg", commodity, 0, 0, 0, 10).
item(6, wool, "wool", commodity, 0, 0, 0, 20).

item(7, cheese, "cheese", commodity, 7, 0, 0, 60).
item(8, mayonnaise, "mayonnaise", commodity, 3, 0, 0, 15).
item(9, sweater, "sweater", commodity, 5, 0, 0, 30).

item(10, carrot_seed, "carrot seed", commodity, 1, 350, 0, 5).
item(11, potato_seed, "potato seed", commodity, 1, 375, 0, 7).
item(12, corn_seed, "corn seed", commodity, 1, 400, 0, 9).
item(13, tomato_seed, "tomato seed", commodity, 2, 450, 0, 12).
item(14, pumpkin_seed, "pumpkin seed", commodity, 3, 600, 0, 15).

item(15, carrot, "carrot", commodity, 0, 0, 0, 10).
item(16, potato, "potato", commodity, 0, 0, 0, 14).
item(17, corn, "corn", commodity, 0, 0, 0, 18).
item(18, tomato, "tomato", commodity, 0, 0, 0, 25).
item(19, pumpkin, "pumpkin", commodity, 0, 0, 0, 35).

item(20, betutu_fish, "betutu fish", commodity, 0, 0, 0, 40). 
item(21, gurame_fish, "gurame fish", commodity, 0, 0, 0, 20).
item(22, teri_fish, "teri fish", commodity, 0, 0, 0, 5).

item(23, energy_drink, "energy drink", consumable, 0, 0, 50, 20).
item(24, coffee_bts, "coffee bts", consumable, 0, 0, 75, 30).
item(25, pupuk_mbah_subur, "pupu mbah subur", consumable, 0, 0, 0, 1000).

item(26, shovel, "shovel", equipment, 1, 0, 0, 50).
item(27, shovel, "shovel", equipment, 2, 0, 0, 100).
item(28, shovel, "shovel", equipment, 3, 0, 0, 150).
item(29, fishingrod, "fishing rod", equipment, 1, 0, 0, 50).
item(30, fishingrod, "fishing rod", equipment, 2, 0, 0, 100).
item(31, fishingrod, "fishing rod", equipment, 3, 0, 0, 150).

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