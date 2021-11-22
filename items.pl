/* Semua item yang ada
    Jenis item:
        - commodity
        - consumable
        - equipment */
item(cow, commodity).
item(chicken, commodity).
item(sheep, commodity).
item(milk, commodity).
item(egg, commodity).
item(wool, commodity).
item(cheese, commodity).
item(mayonnaise, commodity).
item(sweater, commodity).
item(carrot_seed, commodity).
item(potato_seed, commodity).
item(corn_seed, commodity).
item(tomato_seed, commodity).
item(pumpkin_seed, commodity).
item(carrot, commodity).
item(potato, commodity).
item(corn, commodity).
item(tomato, commodity).
item(pumpkin, commodity).
item(betutu_fish, commodity). 
item(gurame_fish, commodity).
item(teri_fish, commodity).
item(energy_drink, consumable).
item(coffee_bts, consumable).
item(pupuk_mbah_subur, consumable).
item(shovel_1, equipment).
item(shovel_2, equipment).
item(shovel_3, equipment).
item(fishingrod_1, equipment).
item(fishingrod_2, equipment).
item(fishingrod_3, equipment).

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