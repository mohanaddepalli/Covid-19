USE [CovidBot]
GO
/****** Object:  Table [dbo].[Case]    Script Date: 4/24/2020 12:18:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Case](
	[case_id] [int] IDENTITY(1,1) NOT NULL,
	[city_id] [int] NOT NULL,
	[State_id] [int] NOT NULL,
	[country_id] [int] NOT NULL,
	[zipcode_id] [int] NOT NULL,
	[total_case_count] [int] NOT NULL,
	[active_case_count] [int] NOT NULL,
	[discharged_case_count] [int] NOT NULL,
	[death_count] [int] NOT NULL,
	[isolation_case_count] [int] NOT NULL,
	[timestamp] [datetime] NOT NULL,
 CONSTRAINT [PK_Case] PRIMARY KEY CLUSTERED 
(
	[case_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[Chat]    Script Date: 4/24/2020 12:18:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Chat](
	[Chat_id] [int] IDENTITY(1,1) NOT NULL,
	[session_id] [varchar](100) NOT NULL,
	[queryText] [varchar](max) NULL,
	[fulfillmentText] [varchar](max) NULL,
	[fulfillmentMessages] [nvarchar](max) NULL,
	[timestamp] [datetime] NOT NULL,
 CONSTRAINT [PK_Chat] PRIMARY KEY CLUSTERED 
(
	[Chat_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[City]    Script Date: 4/24/2020 12:18:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[City](
	[city_id] [int] IDENTITY(1,1) NOT NULL,
	[city_name] [varchar](50) NOT NULL,
	[state_id] [int] NOT NULL,
	[zipcode_id] [int] NOT NULL,
	[timestamp] [datetime] NOT NULL,
 CONSTRAINT [PK_City] PRIMARY KEY CLUSTERED 
(
	[city_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[Country]    Script Date: 4/24/2020 12:18:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Country](
	[country_id] [int] IDENTITY(1,1) NOT NULL,
	[country_name] [varchar](50) NOT NULL,
	[timestamp] [datetime] NOT NULL,
 CONSTRAINT [PK_Country] PRIMARY KEY CLUSTERED 
(
	[country_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[Customer]    Script Date: 4/24/2020 12:18:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[customer_id] [int] IDENTITY(1,1) NOT NULL,
	[customer_name] [varchar](50) NOT NULL,
	[email_id] [varchar](250) NOT NULL,
	[mobile_number] [varchar](15) NOT NULL,
	[city_id] [int] NULL,
	[State_id] [int] NULL,
	[country_id] [int] NULL,
	[Zipcode_id] [int] NULL,
	[city_name] [varchar](50) NULL,
	[State_name] [varchar](50) NULL,
	[country_name] [varchar](50) NULL,
	[zipcode_number] [varchar](50) NULL,
	[timestamp] [datetime] NOT NULL,
 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
(
	[customer_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[State]    Script Date: 4/24/2020 12:18:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[State](
	[state_id] [int] IDENTITY(1,1) NOT NULL,
	[state_name] [varchar](50) NOT NULL,
	[country_id] [int] NOT NULL,
	[timestamp] [datetime] NOT NULL,
 CONSTRAINT [PK_State] PRIMARY KEY CLUSTERED 
(
	[state_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[Zipcode]    Script Date: 4/24/2020 12:18:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Zipcode](
	[zipcode_id] [int] IDENTITY(1,1) NOT NULL,
	[zipcode_number] [varchar](50) NOT NULL,
	[country_id] [int] NOT NULL,
	[timestamp] [datetime] NOT NULL,
 CONSTRAINT [PK_Zipcode] PRIMARY KEY CLUSTERED 
(
	[zipcode_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO

ALTER TABLE [dbo].[Case] ADD  DEFAULT (getdate()) FOR [timestamp]
GO
ALTER TABLE [dbo].[Chat] ADD  DEFAULT (getdate()) FOR [timestamp]
GO
ALTER TABLE [dbo].[City] ADD  DEFAULT (getdate()) FOR [timestamp]
GO
ALTER TABLE [dbo].[Country] ADD  DEFAULT (getdate()) FOR [timestamp]
GO
ALTER TABLE [dbo].[Customer] ADD  DEFAULT (getdate()) FOR [timestamp]
GO
ALTER TABLE [dbo].[State] ADD  DEFAULT (getdate()) FOR [timestamp]
GO
ALTER TABLE [dbo].[Zipcode] ADD  DEFAULT (getdate()) FOR [timestamp]
GO
ALTER TABLE [dbo].[Case]  WITH NOCHECK ADD  CONSTRAINT [FK_Case_City] FOREIGN KEY([city_id])
REFERENCES [dbo].[City] ([city_id])
GO
ALTER TABLE [dbo].[Case] CHECK CONSTRAINT [FK_Case_City]
GO
ALTER TABLE [dbo].[Case]  WITH NOCHECK ADD  CONSTRAINT [FK_Case_Country] FOREIGN KEY([country_id])
REFERENCES [dbo].[Country] ([country_id])
GO
ALTER TABLE [dbo].[Case] CHECK CONSTRAINT [FK_Case_Country]
GO
ALTER TABLE [dbo].[Case]  WITH NOCHECK ADD  CONSTRAINT [FK_Case_State] FOREIGN KEY([State_id])
REFERENCES [dbo].[State] ([state_id])
GO
ALTER TABLE [dbo].[Case] CHECK CONSTRAINT [FK_Case_State]
GO
ALTER TABLE [dbo].[Case]  WITH NOCHECK ADD  CONSTRAINT [FK_Case_Zipcode] FOREIGN KEY([zipcode_id])
REFERENCES [dbo].[Zipcode] ([zipcode_id])
GO
ALTER TABLE [dbo].[Case] CHECK CONSTRAINT [FK_Case_Zipcode]
GO
ALTER TABLE [dbo].[City]  WITH NOCHECK ADD  CONSTRAINT [FK_City_State] FOREIGN KEY([state_id])
REFERENCES [dbo].[State] ([state_id])
GO
ALTER TABLE [dbo].[City] CHECK CONSTRAINT [FK_City_State]
GO
ALTER TABLE [dbo].[City]  WITH NOCHECK ADD  CONSTRAINT [FK_City_Zipcode] FOREIGN KEY([zipcode_id])
REFERENCES [dbo].[Zipcode] ([zipcode_id])
GO
ALTER TABLE [dbo].[City] CHECK CONSTRAINT [FK_City_Zipcode]
GO
ALTER TABLE [dbo].[State]  WITH NOCHECK ADD  CONSTRAINT [FK_State_Country] FOREIGN KEY([country_id])
REFERENCES [dbo].[Country] ([country_id])
GO
ALTER TABLE [dbo].[State] CHECK CONSTRAINT [FK_State_Country]
GO
ALTER TABLE [dbo].[Zipcode]  WITH NOCHECK ADD  CONSTRAINT [FK_State_Zipcode] FOREIGN KEY([country_id])
REFERENCES [dbo].[Country] ([country_id])
GO
ALTER TABLE [dbo].[Zipcode] CHECK CONSTRAINT [FK_State_Zipcode]
GO
/****** Object:  StoredProcedure [dbo].[SaveChat]    Script Date: 4/24/2020 12:18:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--EXEC [SaveCustomer] 'test', 'test@test', '931', 'hyd','500000'
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SaveChat]
	-- Add the parameters for the stored procedure here
	@session_id varchar(100),
	@queryText varchar(max),
	@fulfillmentText varchar(max)
AS
BEGIN
	INSERT INTO [dbo].[Chat]
           ([session_id]
           ,[queryText]
           ,[fulfillmentText])
     VALUES
           (@session_id
           ,@queryText
           ,@fulfillmentText
		   )

END

GO
/****** Object:  StoredProcedure [dbo].[SaveCustomer]    Script Date: 4/24/2020 12:18:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--EXEC [SaveCustomer] 'test', 'test@test', '931', 'hyd','500000'
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SaveCustomer]
	-- Add the parameters for the stored procedure here
	@customer_name varchar(50), 
	@email_id varchar(250),
	@mobile_number varchar(15),
	@city_name varchar(50), 
	@zipcode_number varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @city_id int
	DECLARE @zipcode_id int
	DECLARE @state_id int
	DECLARE @country_id int

	SELECT @city_id=city_id, @state_id=state_id FROM City where city_name=@city_name

	SELECT @zipcode_id*zipcode_id FROM Zipcode where zipcode_number=@zipcode_number

	SELECT @country_id=country_id FROM [State] where state_id=@state_id

	Insert into Customer ([customer_name]
           ,[email_id]
           ,[mobile_number]
           ,[city_id]
           ,[State_id]
           ,[country_id]
		   ,[Zipcode_id]
           ,[city_name]
           ,[State_name]
           ,[country_name]
           ,[zipcode_number]
           )
		   VALUES
           (@customer_name
           ,@email_id
           ,@mobile_number
           ,@city_id
           ,@state_id
           ,@country_id
		   ,@zipcode_id
           ,CASE when ISNULL(@city_id,0)=0 THEN @city_name ELSE '' END
           ,CASE when ISNULL(@state_id,0)=0 THEN @city_name ELSE '' END
           ,CASE when ISNULL(@country_id,0)=0 THEN @city_name ELSE '' END
           ,CASE when ISNULL(@zipcode_id,0)=0 THEN @zipcode_number ELSE '' END
           )
		   --select @city_id,@state_id,@country_id,@zipcode_id
		   SELECT C.city_name, Z.zipcode_number, CS.isolation_case_count, CS.total_case_count, CS.active_case_count, CS.discharged_case_count, CS.death_count FROM [Case] CS
                    left join City C on C.city_id=CS.city_id
                    left join Zipcode Z on Z.zipcode_id=CS.zipcode_id
                    where C.city_name like ''+@city_name+''
                    OR Z.zipcode_number=''+@zipcode_number+''

END

GO
