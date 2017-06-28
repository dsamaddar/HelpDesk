Imports Microsoft.VisualBasic
Imports System.Data.SqlClient
Imports System.Data

Public Class clsSupplierDataAccess

    Dim con As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("HelpDeskConnectionString").ConnectionString)

#Region " Insert Supplier "

    Public Function fnInsertSupplier(ByVal Supplier As clsSupplier) As Integer
        Try
            Dim cmd As SqlCommand = New SqlCommand("spInsertSupplier", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@SupplierName", Supplier.SupplierName)
            cmd.Parameters.AddWithValue("@Address", Supplier.Address)
            cmd.Parameters.AddWithValue("@ContactPerson", Supplier.ContactPerson)
            cmd.Parameters.AddWithValue("@ContactNumber", Supplier.ContactNumber)
            cmd.Parameters.AddWithValue("@AboutSupplier", Supplier.AboutSupplier)
            cmd.Parameters.AddWithValue("@Company_Phone_Mobile", Supplier.Company_Phone_Mobile)
            cmd.Parameters.AddWithValue("@Fax", Supplier.Fax)
            cmd.Parameters.AddWithValue("@Email", Supplier.Email)
            cmd.Parameters.AddWithValue("@IsBlackListed", Supplier.IsBlackListed)
            cmd.Parameters.AddWithValue("@EntryBy", Supplier.EntryBy)
            cmd.ExecuteNonQuery()
            con.Close()
            Return 1
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return 0
        End Try
    End Function

#End Region

#Region " Update Supplier "

    Public Function fnUpdateSupplier(ByVal Supplier As clsSupplier) As Integer
        Try
            Dim cmd As SqlCommand = New SqlCommand("spUpdateSupplier", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@SupplierID", Supplier.SupplierID)
            cmd.Parameters.AddWithValue("@SupplierName", Supplier.SupplierName)
            cmd.Parameters.AddWithValue("@Address", Supplier.Address)
            cmd.Parameters.AddWithValue("@ContactPerson", Supplier.ContactPerson)
            cmd.Parameters.AddWithValue("@ContactNumber", Supplier.ContactNumber)
            cmd.Parameters.AddWithValue("@AboutSupplier", Supplier.AboutSupplier)
            cmd.Parameters.AddWithValue("@Company_Phone_Mobile", Supplier.Company_Phone_Mobile)
            cmd.Parameters.AddWithValue("@Fax", Supplier.Fax)
            cmd.Parameters.AddWithValue("@Email", Supplier.Email)
            cmd.Parameters.AddWithValue("@IsBlackListed", Supplier.IsBlackListed)
            cmd.Parameters.AddWithValue("@EntryBy", Supplier.EntryBy)
            cmd.ExecuteNonQuery()
            con.Close()
            Return 1
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return 0
        End Try
    End Function

#End Region

#Region " Get Supplier Details "

    Public Function fnGetSupplierDetails() As DataSet

        Dim sp As String = "spGetSupplierDetails"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                da.SelectCommand = cmd
                da.Fill(ds)
                con.Close()
                Return ds
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

#End Region

#Region " Get Supplier "

    Public Function fnGetSupplier() As DataSet

        Dim sp As String = "spGetSupplier"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                da.SelectCommand = cmd
                da.Fill(ds)
                con.Close()
                Return ds
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

#End Region

End Class
