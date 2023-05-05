unit UnitMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UnitDish, UnitDishDAO, Vcl.ExtCtrls,
  Vcl.StdCtrls;

type
  TFormMain = class(TForm)
    PanelShow: TPanel;
    PanelAction: TPanel;
    ButtonShow: TButton;
    PanelEditFields: TPanel;
    EditDishName: TEdit;
    EditDishCategory: TEdit;
    EditDishPrice: TEdit;
    ButtonAdd: TButton;
    ScrollBoxMain: TScrollBox;
    Panel2: TPanel;
    Panel1: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    ListBoxAllDishes: TListBox;
    Image1: TImage;
    Label1_dishName: TLabel;
    ButtonAddPanel: TButton;
    procedure ButtonAddClick(Sender: TObject);
    procedure ButtonShowClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ButtonAddPanelClick(Sender: TObject);
  private
    class var ORDER: Integer;
    listOfPanel: array[1..100] of TPanel;
  public
    { Public declarations }
  end;

var
  FormMain: TFormMain;

implementation

{$R *.dfm}
  var
    dish: TDish;
    dishDAO: TDishDAO;

    
  procedure TFormMain.ButtonAddClick(Sender: TObject);  
  begin
    dish := TDish.CreateDish(EditDishName.Text, EditDishCategory.Text, strToInt(EditDishPrice.Text));
    dishDAO := TDishDAO.getInstance;
    dishDAO.addNewDish(dish);	
  end;

  procedure TFormMain.ButtonAddPanelClick(Sender: TObject);
  var
    myPanel, myPanel2: TPanel;
  begin
    ORDER := 4;
    myPanel := TPanel.Create(ScrollBoxMain);
    myPanel.Parent := ScrollBoxMain;
    myPanel.Caption	:= 'It is here!';
    myPanel.Width := 450;
    myPanel.Height := 150;
    myPanel.Left := 40;
//    myPanel.Top := ScrollBoxMain.HorzScrollBar.Position + round(ScrollBoxMain.Height / 2);
    myPanel.Top := listOfPanel[ORDER].Top + 200;
    listOfPanel[ORDER] := myPanel;
    inc(ORDER);
  end;

procedure TFormMain.ButtonShowClick(Sender: TObject);
  var
    myDish: TDish;
    i: Integer;
  begin
    dishDAO := TDishDAO.getInstance;
    ListBoxAllDishes.Clear;

    for i := 1 to length(dishDAO.getListOfDishes) - 1 do
    begin
      if dishDAO.getItemFromListOfDishes(i) <> nil then
      begin
        myDish := dishDAO.getItemFromListOfDishes(i);
        ListBoxAllDishes.items.Add(myDish.getDishName + ' ' + myDish.getDishCategory + ' ' + intToStr(myDish.getDishPrice));
      end;

    end;

  end;

  procedure TFormMain.FormCreate(Sender: TObject);
  begin
    dishDAO := TDishDAO.getInstance;
    Label1_dishName.Caption := 'Hi';
    listOfPanel[1] := Panel1;
    listOfPanel[2] := Panel2;
    listOfPanel[3] := Panel3;
    listOfPanel[4] := Panel4;
  end;

end.
