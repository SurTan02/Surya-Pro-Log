/* Semua item yang ada
item(ID, Name, Type, Level, EnergyNeed, EnergySupply, Price) */

item(1, cow, commodity, 0, 1000, 0, 2000).
item(2, chicken, commodity, 0, 300, 0, 500).
item(3, sheep, commodity, 0, 600, 0, 1200).
item(4, milk, commodity, 0, 0, 0, 40).
item(5, egg, commodity, 0, 0, 0, 10).
item(6, wool, commodity, 0, 0, 0, 20).
item(7, cheese, commodity, 0, 0, 0, 60).
item(8, mayonnaise, commodity, 0, 0, 0, 15).
item(9, sweater, commodity, 0, 0, 0, 30).
item(10, carrot_seed, commodity, 1, 350, 0, 5).
item(11, potato_seed, commodity, 1, 375, 0, 7).
item(12, corn_seed, commodity, 1, 400, 0, 9).
item(13, tomato_seed, commodity, 2, 450, 0, 12).
item(14, pumpkin_seed, commodity, 3, 600, 0, 15).
item(15, carrot, commodity, 0, 0, 0, 10).
item(16, potato, commodity, 0, 0, 0, 14).
item(17, corn, commodity, 0, 0, 0, 18).
item(18, tomato, commodity, 0, 0, 0, 25).
item(19, pumpkin, commodity, 0, 0, 0, 35).
item(20, betutu_fish, commodity, 0, 0, 0, 40). 
item(21, gurame_fish, commodity, 0, 0, 0, 20).
item(22, teri_fish, commodity, 0, 0, 0, 5).
item(23, energy_drink, consumable, 0, 0, 50, 20).
item(24, coffee_bts, consumable, 0, 0, 75, 30).
item(25, pupuk_mbah_subur, consumable, 0, 0, 0, 1000).
item(26, shovel, equipment, 1, 0, 0, 50).
item(27, shovel, equipment, 2, 0, 0, 100).
item(28, shovel, equipment, 3, 0, 0, 150).
item(29, fishingrod, equipment, 1, 0, 0, 50).
item(30, fishingrod, equipment, 2, 0, 0, 100).
item(31, fishingrod, equipment, 3, 0, 0, 150).

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
onsale(shovel_1).
onsale(shovel_2).
onsale(shovel_3).
onsale(fishingrod_1).
onsale(fishingrod_2).
onsale(fishingrod_3).

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