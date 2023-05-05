unit UnitDishDAO;

interface

uses
  UnitDish;

type

  TListOfDishes = array[1..100] of TDish;

  TDishDAO = class
    private
      curr: Integer;
      listOfDishes: TListOfDishes;
      constructor actualCreate;
    public
      class function getInstance: TDishDAO;
//      constructor Create;
      procedure addNewDish(const newDish: TDish);
      function getListOfDishes(): TListOfDishes;
      function getItemFromListOfDishes(pos: Integer): TDish;
  end;



implementation

var
  DAO: TDishDAO;

  constructor TDishDAO.actualCreate;
  begin
    inherited Create;
  end;

  class function TDishDAO.getInstance: TDishDAO;
  begin
    if DAO = nil then
      DAO := TDishDAO.actualCreate;
    Result := DAO;
  end;

  procedure TDishDAO.addNewDish(const newDish: TDish);
  begin
    inc(curr);
    listOfDishes[curr] := newDish;
  end;


  function TDishDAO.getListOfDishes: TListOfDishes;
  begin
    result := listOfDishes;
  end;


  function TDIshDAO.getItemFromListOfDishes(pos: Integer): TDish;
  begin
    result := listOfDishes[pos];
  end;

end.
