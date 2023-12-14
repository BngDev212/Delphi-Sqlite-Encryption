unit udm;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.FMXUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLiteWrapper.Stat,
  FireDAC.Phys.SQLiteDef, FireDAC.Phys.SQLite, FireDAC.Comp.Client, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Stan.StorageBin;

type
  Tdatamod = class(TDataModule)
    FDConnection1: TFDConnection;
    FDMemTable1: TFDMemTable;
    FDTable1: TFDTable;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    FDSQLiteSecurity1: TFDSQLiteSecurity;
  private
    { Private declarations }
  public
    { Public declarations }
     procedure initdatabase;
  end;

CONST
    DB_FILENAME = 'Shopping2.sdb';
    DB_PASSWORD = 'MYSQLitePassword';
    DB_ENCRYPTION = 'aes-256';
    DB_TABLE = 'Shopping';

var
  datamod: Tdatamod;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}
uses
  system.IOUtils;

procedure Tdatamod.initdatabase;
begin
 // set the sqlite database file name and location in DocumentsPath.
 FDConnection1.Params.Values['Database']:= Tpath.Combine(Tpath.GetDocumentsPath,DB_FILENAME);

 FDTable1.TableName:= DB_TABLE;

 if TFile.Exists(FDConnection1.Params.Values['Database'])=true then
  begin
    // use this file
    //  sets the database file name and location by combining the documents path with the DB_FILENAME constant value.
    FDSQLiteSecurity1.Database:=FDConnection1.Params.Values['Database'];
  end
  else
  begin
    FDConnection1.Open;
    // create / load default data
    Try
     FDTable1.FieldDefs.Clear;
     FDTable1.FieldDefs.Assign(FDMemtable1.FieldDefs);
     FDTable1.CreateTable(false); //
     FDTable1.CopyDataSet(FDMemTable1,[coStructure, coRestart,coAppend]);
    Finally
      FDConnection1.Close;
    End;
    //Encrypt database
    FDSQLiteSecurity1.Database:=FDConnection1.Params.Values['Database'];
    FDSQLiteSecurity1.Password:=DB_ENCRYPTION + ':' +DB_PASSWORD;
    FDSQLiteSecurity1.SetPassword;
  end;

  FDConnection1.Params.values['Encrypt']:= DB_ENCRYPTION;
  FDConnection1.Params.Password:=DB_PASSWORD;
  FDConnection1.Open;
  FDTable1.Open;
  FDMemtable1.Free;
end;

end.
