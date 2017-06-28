

Create database AdminInventory

GO

Use AdminInventory

GO


-- drop table tblAppSettings
Create table tblAppSettings(
PropertyName nvarchar(50) unique(PropertyName),
PropertyValue nvarchar(500)
);

GO

CREATE    function generateID(@Prefix nvarchar(50),@sl int, @Len int)
returns nvarchar(50)
as
begin
	Declare @SLen as int
	declare @GID as nvarchar(50)

	set @SLen = @Len - len(@sl)
	set @GID=''

	while @SLen>0
	begin
		set @GID=@GID+'0'
		set @SLen=@SLen-1
	end


	set @GID = @Prefix + @GID + convert(nvarchar,@sl)
	
	return @GID
end


GO

-- drop proc spGetEntryPoint
Create proc spGetEntryPoint
as
begin
	Select convert(nvarchar,getdate(),102)+'.'+convert(nvarchar,getdate(),114) as 'EntryPoint'
end

-- exec spGetEntryPoint

GO

-- drop function Split
Create FUNCTION Split(@Delimiter varchar(5), @List varchar(8000) ) 
RETURNS @TableOfValues table 
(  Value varchar(50)   ) 
AS 
BEGIN

DECLARE @LenString int 

WHILE len( @List ) > 0 
 BEGIN 
 
    SELECT @LenString = 
       (CASE charindex( @Delimiter, @List ) 
           WHEN 0 THEN len( @List ) 
           ELSE ( charindex( @Delimiter, @List ) -1 )
        END
       ) 
                        
    INSERT INTO @TableOfValues 
       SELECT substring( @List, 1, @LenString )
        
    SELECT @List = 
       (CASE ( len( @List ) - @LenString ) 
           WHEN 0 THEN '' 
           ELSE right( @List, len( @List ) - @LenString - 1 ) 
        END
       ) 
 END
  
RETURN 

END 