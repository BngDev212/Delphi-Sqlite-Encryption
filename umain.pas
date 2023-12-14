unit umain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types,FMX.Header, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Rtti,
  FMX.Grid.Style, Data.Bind.Controls, Data.Bind.EngExt, Fmx.Bind.DBEngExt,
  Data.Bind.Components, Data.Bind.DBScope, FMX.Layouts, Fmx.Bind.Navigator,
  FMX.ScrollBox, FMX.Grid, FMX.StdCtrls, FMX.Effects, FMX.Controls.Presentation,
  Fmx.Bind.Grid, System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.Grid;

type
  TfrmMain = class(TForm)
    StyleBook1: TStyleBook;
    ToolBar1: TToolBar;
    ShadowEffect1: TShadowEffect;
    StringGrid1: TStringGrid;
    BindNavigator1: TBindNavigator;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    Button1: TButton;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure StringGrid1Resized(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure LinkGridToDataSourceBindSourceDB1Activated(Sender: TObject);
    procedure StringGrid1ApplyStyleLookup(Sender: TObject);
  private
    { Private declarations }
    FRUNOnce: boolean;
    procedure CalcColumnWidths;
    Procedure AppIdle(sender: TObject; var Done: Boolean);
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.fmx}
{$R *.iPhone55in.fmx IOS}
{$R *.LgXhdpiTb.fmx ANDROID}
{$R *.LgXhdpiPh.fmx ANDROID}

uses system.Math, udm;

//  https://youtu.be/hhzkxjYKv-g


 Procedure TfrmMain.AppIdle(sender: TObject; var Done: Boolean);
 begin
    if not FRUNOnce then
    begin
      FRUNonce:= TRUE;
      Datamod.initdatabase;
    end;
 end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  BindSourceDB1.DataSet:=DataMod.FDTable1;
  Application.OnIdle:=AppIdle;
end;

procedure TfrmMain.LinkGridToDataSourceBindSourceDB1Activated(Sender: TObject);
begin
  CalcColumnWidths;
end;

procedure TfrmMain.StringGrid1ApplyStyleLookup(Sender: TObject);
var
//https://stackoverflow.com/questions/32131522/change-theader-font-size-in-fmx-tstringgrid
  Header: THeader;
  HeaderItem: THeaderItem;
  I: Integer;
begin
  Header := THeader((Sender as TStringGrid).FindStyleResource('header'));
  if Assigned(Header) then
    begin
      for I := 0 to Header.Count - 1 do
        begin
          HeaderItem := Header.Items[I];

          HeaderItem.Font.Size := 16;
          HeaderItem.Font.Style := [TFontStyle.fsBold];
          HeaderItem.TextSettings.HorzAlign := TTextAlign.Center;
          // new code line:
          HeaderItem.StyledSettings := HeaderItem.StyledSettings - [TStyledSetting.Size, TStyledSetting.Style];
        end;
      Header.Height := 48;
    end;
end;



procedure TfrmMain.StringGrid1Resized(Sender: TObject);
begin
  CalcColumnWidths;
end;

// https://github.com/Pasquina/ResponsiveFiremonkeyStringGrid
//
procedure TfrmMain.Button1Click(Sender: TObject);
begin
   CalcColumnWidths;
end;

procedure TfrmMain.CalcColumnWidths;
type
  ColParam = (cpMinSize, cpMaxSize, cpProportion);  // to index column property array
var
  LContentWidth: Single;                            // the width available in the grid for columns
  LPropSum: Single;                                 // the sum of all column proportion values
  LColIx: Integer;                                  // column index into column property array
  LCurProp: Single;                                 // calculated column width using only proportion, without constraints
const

  { Each column has three property values associated:
    Minimum column width. The column width will never be set lower than this value
    Maximum column width. The column width will never be set greater than this value
    Column Proportion. The column's width will be calculated using this value as a proportion
    but will be constrained by the specified minimum and maximum values }

  LColumnResp: Array [0 .. 2, ColParam] of Single = // column property array
    ((50.0, 100.0, 2.0), (150.0, 350.0, 7.0), (50.0, 125.0, 2.0));
begin
  LContentWidth := StringGrid1.Content.Width;      // obtain width available for columns

  { Calculate the sum of all column proportion properties to be used as the denominator in
    the individual column width calculation by proportion. }

  LPropSum := 0;                                    // init
  for LColIx := Low(LColumnResp) to High(LColumnResp) do // loop over entire array
    LPropSum := LPropSum + LColumnResp[LColIx, cpProportion]; // add proportion property value to total

  { This routine may be called before columns are actually created. The following avoids index
    out of range violations by exiting when there are an insufficient number of columns actually defined. }

  if StringGrid1.ColumnCount < (High(LColumnResp) + 1) then // make sure there are enough columns
    Exit;                                           // hop out if insufficient column count

  { Set the column width for each column as specified by the column property array. For each column
    the width value is calculated as a proportion using the total of all proportion properties as the
    denominator and the individual proportion as the numerator of each column. This value is further
    constrained by the minimum and maximum values for the column. }

  StringGrid1.BeginUpdate;                         // increase update semaphore count to avoid painting during update

  for LColIx := Low(LColumnResp) to High(LColumnResp) do // loop over all array entries
    begin
      LCurProp := (LColumnResp[LColIx, cpProportion] / LPropSum) * LContentWidth; // determine current width by proportion
      StringGrid1.Columns[LColIx].Width := // constrain the proportional width using Min and Max values for the column
        Min(Max(LColumnResp[LColIx, cpMinSize], LCurProp), LColumnResp[LColIx, cpMaxSize]);
    end;

  StringGrid1.EndUpdate;                           // decrease update semaphore count to permit painting
end;

end.
