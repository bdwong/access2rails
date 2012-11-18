
def create_mocks
  @index_mocks = [
      OpenStruct.new(
        :clustered => "no",
        :index_key => "Column1Name", # Column names concatenated with spaces.
        :index_name => "IndexName",
        :primary => "yes",
        :unique => "yes",
        :unique? => true
      ),
    ]

  @column_mocks = [
      Access2rails::Xsd::Column.from_hash(
        :name => "Column1Name",
        :minoccurs => "1",
        :jet_type => "longInteger",
        :sqlSType => "int",
        :type => "xsd:int",
        :max_length => nil
      ),
      Access2rails::Xsd::Column.from_hash(
        :name => "Column2Name",
        :minoccurs => "0",
        :jet_type => "text",
        :sqlSType => "nvarchar",
        :type => "xsd:string",
        :max_length => "10"
      )
    ]

  @schema_mock = OpenStruct.new(
    :name => "SchemaName",
    :indices => @index_mocks,
    :columns => @column_mocks
    )

  # @money_column = Access2rails::Xsd::Column.from_hash(
  #   :name => "Column1Name",
  #   :minoccurs => "1",
  #   :jet_type => "longInteger",
  #   :sqlSType => "int",
  #   :type => "xsd:int",
  #   :max_length => nil
  #   )

  # @decimal4_column = Access2rails::Xsd::Column.from_hash(
  #   :name => "Column1Name",
  #   :minoccurs => "1",
  #   :jet_type => "longInteger",
  #   :sqlSType => "int",
  #   :type => "xsd:int",
  #   :max_length => nil
  #   )

end
