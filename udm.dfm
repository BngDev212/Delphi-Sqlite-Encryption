object datamod: Tdatamod
  OldCreateOrder = False
  Height = 361
  Width = 328
  object FDConnection1: TFDConnection
    Params.Strings = (
      'DriverID=SQLite')
    Left = 56
    Top = 16
  end
  object FDMemTable1: TFDMemTable
    Active = True
    FieldDefs = <
      item
        Name = 'id'
        Attributes = [faReadonly]
        DataType = ftAutoInc
      end
      item
        Name = 'items'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'Qty'
        DataType = ftFloat
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvPersistent, rvSilentMode]
    ResourceOptions.Persistent = True
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 160
    Top = 16
    Content = {
      414442530F000000A7010000FF00010001FF02FF03040016000000460044004D
      0065006D005400610062006C006500310005000A0000005400610062006C0065
      00060000000000070000080032000000090000FF0AFF0B040004000000690064
      00050004000000690064000C00010000000E000D000F00011000011100011200
      0113000114000115000116000117000118000119000400000069006400FEFF0B
      04000A0000006900740065006D00730005000A0000006900740065006D007300
      0C00020000000E001A001B00320000000F000110000113000114000116000117
      000119000A0000006900740065006D0073001C0032000000FEFF0B0400060000
      005100740079000500060000005100740079000C00030000000E001D000F0001
      100001130001140001160001170001190006000000510074007900FEFEFF1EFE
      FF1FFEFF20FF21220000000000FF230000010000000100050000004170706C65
      02000000000000000040FEFEFF21220001000000FF2300000200000001000600
      000042616E616E610200000000000000F03FFEFEFEFEFEFF24FEFF2526000500
      0000FF27FEFEFE0E004D0061006E0061006700650072001E0055007000640061
      007400650073005200650067006900730074007200790012005400610062006C
      0065004C006900730074000A005400610062006C00650008004E0061006D0065
      00140053006F0075007200630065004E0061006D0065000A0054006100620049
      004400240045006E0066006F0072006300650043006F006E0073007400720061
      0069006E00740073001E004D0069006E0069006D0075006D0043006100700061
      006300690074007900180043006800650063006B004E006F0074004E0075006C
      006C00140043006F006C0075006D006E004C006900730074000C0043006F006C
      0075006D006E00100053006F007500720063006500490044000E006400740049
      006E007400330032001000440061007400610054007900700065001400530065
      006100720063006800610062006C006500120041006C006C006F0077004E0075
      006C006C00100052006500610064004F006E006C0079000E004100750074006F
      0049006E0063000800420061007300650014004F0041006C006C006F0077004E
      0075006C006C0012004F0052006500610064004F006E006C00790012004F0049
      006E0055007000640061007400650010004F0049006E00570068006500720065
      0020004F004100660074006500720049006E0073004300680061006E00670065
      0064001A004F0072006900670069006E0043006F006C004E0061006D00650018
      006400740041006E007300690053007400720069006E0067000800530069007A
      006500140053006F007500720063006500530069007A00650010006400740044
      006F00750062006C0065001C0043006F006E00730074007200610069006E0074
      004C00690073007400100056006900650077004C006900730074000E0052006F
      0077004C00690073007400060052006F0077000A0052006F0077004900440010
      004F0072006900670069006E0061006C001800520065006C006100740069006F
      006E004C006900730074001C0055007000640061007400650073004A006F0075
      0072006E0061006C001200530061007600650050006F0069006E0074000E0043
      00680061006E00670065007300}
  end
  object FDTable1: TFDTable
    Connection = FDConnection1
    Left = 56
    Top = 80
  end
  object FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink
    Left = 160
    Top = 88
  end
  object FDSQLiteSecurity1: TFDSQLiteSecurity
    DriverLink = FDPhysSQLiteDriverLink1
    Left = 168
    Top = 160
  end
end