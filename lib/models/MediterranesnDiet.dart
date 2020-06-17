class MediterranesnDietData{
  int kcalAbsorb;
  int kcalBurned;
  int CarbsAbsorb;
  int CarbsBurned;
  int ProteinAbsorb;
  int ProteinBurned;
  int FatAbsorb;
  int FatBurned;
  int perCarbs;
  int perProtein;
  int perFat;


  MediterranesnDietData({
    this.kcalBurned,
    this.kcalAbsorb,
    this.CarbsAbsorb,
    this.CarbsBurned,
    this.FatAbsorb,
    this.FatBurned,
    this.ProteinAbsorb,
    this.ProteinBurned,
    this.perCarbs,
    this.perFat,
    this.perProtein,
  });

  static MediterranesnDietData diet = MediterranesnDietData(
    kcalBurned: 0,
    kcalAbsorb: 0,
    CarbsAbsorb: 0,
    CarbsBurned: 0,
    FatAbsorb: 0,
    FatBurned: 0,
    ProteinAbsorb: 0,
    ProteinBurned: 0,
    perCarbs: 0,
    perFat: 0,
    perProtein: 0,
  );
}