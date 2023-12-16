state("BERSERK") 
{
	// level value from 0 to 46
	byte level: 0x7C835C;
	// window value, 47 at rewards screen, 
	byte level0: 0x853650;
	byte level2: 0x853658;
}

startup 
{
	vars.to_split = 0;
	vars.last_level = 0;
	vars.level0_to_split = new byte[47];
	// level0 values at the end of each level
	vars.level0_to_split[0] = 61;  // Prologue
	vars.level0_to_split[1] = 21;  // The Golden Age
	vars.level0_to_split[2] = 23;  // Attacked by the Band of the Hawk
	vars.level0_to_split[3] = 43;  // The First Battle
	vars.level0_to_split[4] = 52;  // The Invasion of Chuder
	vars.level0_to_split[5] = 61;  // Field Battle with Chuder
	vars.level0_to_split[6] = 61;  // The Wind of Swords
	vars.level0_to_split[7] = 25;  // Nosferatu Zodd
	vars.level0_to_split[8] = 61;  // Encounter with Chuder Soldiers
	vars.level0_to_split[9] = 61;  // Pursuit Battle with Chuder
	vars.level0_to_split[10] = 21; // Blue Whales
	vars.level0_to_split[11] = 61; // Prepared for Death
	vars.level0_to_split[12] = 15; // The Battle for Doldrey
	vars.level0_to_split[13] = 23; // The Morning of Departure
	vars.level0_to_split[14] = 61; // The Assailant
	vars.level0_to_split[15] = 61; // Intrusion
	vars.level0_to_split[16] = 61; // First Mercenary Work in a While
	vars.level0_to_split[17] = 51; // The Fugitives
	vars.level0_to_split[18] = 40; // Infiltrating Windham
	vars.level0_to_split[19] = 61; // Devil Dogs
	vars.level0_to_split[20] = 64; // The Eclipse
	vars.level0_to_split[21] = 37; // Vow of Retaliation
	vars.level0_to_split[22] = 61; // The Black Swordman
	vars.level0_to_split[23] = 22; // The Brand's Guidance
	vars.level0_to_split[24] = 61; // Marked for Sacrifice
	vars.level0_to_split[25] = 22; // Those Who Have Transcended
	vars.level0_to_split[26] = 19; // Holy Iron Chain Knights
	vars.level0_to_split[27] = 61; // Night of Miracles
	vars.level0_to_split[28] = 61; // Premonition
	vars.level0_to_split[29] = 61; // Self-Discipline
	vars.level0_to_split[30] = 10; // Kushan Scouts
	vars.level0_to_split[31] = 37; // Spirit Road
	vars.level0_to_split[32] = 21; // Reunion
	vars.level0_to_split[33] = 27; // Inquisitor Mozgus
	vars.level0_to_split[34] = 25; // The Beast Swordman vs The Black Swordman
	vars.level0_to_split[35] = 61; // The Stranger
	vars.level0_to_split[36] = 32; // Winter Journey
	vars.level0_to_split[37] = 61; // Expectation
	vars.level0_to_split[38] = 54; // Witch
	vars.level0_to_split[39] = 61; // Slaying of the Trolls
	vars.level0_to_split[40] = 61; // Enoch Village
	vars.level0_to_split[41] = 28; // Darkness (Qliphoth)
	vars.level0_to_split[42] = 29; // The Blaze
	vars.level0_to_split[43] = 63; // The Berserk Armor
	vars.level0_to_split[44] = 24; // Familiars
	vars.level0_to_split[45] = 61; // Road to the City
	vars.level0_to_split[46] = 61; // Pishaka Invasion
}

start 
{
	if (old.level0 == 41 && current.level0 == 35) {
		vars.last_level = 0;
		vars.to_split = 0;
		return true;
	}
}

split 
{
	print (current.level + " " + current.level0 + " " + current.level2 + "  AAA");
	
	// 
	if (current.level != 0 && vars.to_split == 0) {
		vars.to_split = 1;
	}
	if (current.level0 == 43 || (current.level0 == 41 && current.level2 == 41 && current.level == 0)) {
		vars.to_split = 0;
	}

	if (vars.last_level == 0 && current.level == 1) {
		vars.last_level = 1;
		return true;
	}
	if (current.level != 0) {
		vars.last_level = current.level;
	}
	
	//using 2 methods to split as fast as possible, only method 1 would probably work too
	// method 1
	if (current.level == 0 && vars.to_split == 1 && (current.level0 == 61 || current.level0 == 47) && (current.level2 == 61 || current.level2 == 47 || current.level2 == 85)) {
		vars.to_split = 0;
		return true;
	}
	
	// method 2
	if (old.level == vars.last_level 1 && current.level == 0 && vars.to_split == 1 && current.level0 == vars.level0_to_split[vars.last_level] && (current.level2 == 85 || current.level2 == current.level0)) {
		vars.to_split = 0;
		return true;
	}
	
	if (current.level == 46 && current.level0 == 30 && old.level2 == 30 && current.level2 == 85) {
		return true;
	}
}
