unit UnitDishDao;

uses
  UnitDish.pas;

interface

type
  TDishDAO = class
    private
      ID: Integer := 1; Static
    public
      procedure addNewDish(DishName: String; DishCategory: String; DishPrice: Integer);
  end;

implementation

  procedure addNewDish(DishName: String; DishCategory: String; DishPrice: Integer);
  var
    dish: TDish;
  begin
    dish := TDish.tDish(DishName, DishCategory, DishPrice);

  end;
end.
