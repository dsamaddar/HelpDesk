Imports System.Data.SqlClient
Imports System.Data

Public Class clsEmployeeInfoDataAccess

    Public con As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("HelpDeskConnectionString").ConnectionString)
    Public conHRM As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("HRMConnectionString").ConnectionString)

    Public Function fnInsertEmployeeInfo(ByVal EmpInfo As clsEmployeeInfo) As clsResult
        Dim Result As New clsResult()
        Try
            Dim cmd As SqlCommand = New SqlCommand("spInsertEmployeeInfo", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@UserID", EmpInfo.UserID)
            cmd.Parameters.AddWithValue("@UserPassword", EmpInfo.UserPassword)
            cmd.Parameters.AddWithValue("@UserType", EmpInfo.UserType)
            cmd.Parameters.AddWithValue("@EmployeeName", EmpInfo.EmployeeName)
            cmd.Parameters.AddWithValue("@EmpCode", EmpInfo.EmpCode)
            cmd.Parameters.AddWithValue("@DateOfBirth", EmpInfo.DateOfBirth)
            cmd.Parameters.AddWithValue("@JoiningDate", EmpInfo.JoiningDate)
            cmd.Parameters.AddWithValue("@DesignationID", EmpInfo.DesignationID)
            cmd.Parameters.AddWithValue("@DepartmentID", EmpInfo.DepartmentID)
            cmd.Parameters.AddWithValue("@ULCBranchID", EmpInfo.ULCBranchID)
            cmd.Parameters.AddWithValue("@CurrentSupervisor", EmpInfo.CurrentSupervisor)
            cmd.Parameters.AddWithValue("@EmpStatus", EmpInfo.EmpStatus)
            cmd.Parameters.AddWithValue("@EntryBy", EmpInfo.EntryBy)
            cmd.ExecuteNonQuery()
            con.Close()
            Result.Success = True
            Result.Message = "Employee Info: Inserted Successfully."
            Return Result
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Result.Success = False
            Result.Message = "Error Found: " & ex.Message
            Return Result
        End Try
    End Function

    Public Function fnAddNewlyAddedEmp(ByVal EmpInfo As clsEmployeeInfo) As clsResult
        Dim Result As New clsResult()
        Try
            Dim cmd As SqlCommand = New SqlCommand("spAddNewlyAddedEmp", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@EmployeeID", EmpInfo.EmployeeID)
            cmd.Parameters.AddWithValue("@UserID", EmpInfo.UserID)
            cmd.Parameters.AddWithValue("@UserPassword", EmpInfo.UserPassword)
            cmd.Parameters.AddWithValue("@UserType", EmpInfo.UserType)
            cmd.Parameters.AddWithValue("@EmployeeName", EmpInfo.EmployeeName)
            cmd.Parameters.AddWithValue("@EmpCode", EmpInfo.EmpCode)
            cmd.Parameters.AddWithValue("@DateOfBirth", EmpInfo.DateOfBirth)
            cmd.Parameters.AddWithValue("@JoiningDate", EmpInfo.JoiningDate)
            cmd.Parameters.AddWithValue("@DesignationID", EmpInfo.DesignationID)
            cmd.Parameters.AddWithValue("@DepartmentID", EmpInfo.DepartmentID)
            cmd.Parameters.AddWithValue("@ULCBranchID", EmpInfo.ULCBranchID)
            cmd.Parameters.AddWithValue("@CurrentSupervisor", EmpInfo.CurrentSupervisor)
            cmd.Parameters.AddWithValue("@EmpStatus", EmpInfo.EmpStatus)
            cmd.Parameters.AddWithValue("@MailAddress", EmpInfo.MailAddress)
            cmd.Parameters.AddWithValue("@MobileNo", EmpInfo.MobileNo)
            cmd.Parameters.AddWithValue("@IsActive", EmpInfo.IsActive)
            cmd.Parameters.AddWithValue("@EntryBy", EmpInfo.EntryBy)
            cmd.ExecuteNonQuery()
            con.Close()
            Result.Success = True
            Result.Message = "Employee Info: Added Successfully."
            Return Result
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Result.Success = False
            Result.Message = "Error Found: " & ex.Message
            Return Result
        End Try
    End Function

    Public Function fnSyncEmpInfo(ByVal EmpInfo As clsEmployeeInfo) As clsResult
        Dim Result As New clsResult()
        Try
            Dim cmd As SqlCommand = New SqlCommand("spSyncEmpInfo", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@EmployeeID", EmpInfo.EmployeeID)
            cmd.Parameters.AddWithValue("@UserID", EmpInfo.UserID)
            cmd.Parameters.AddWithValue("@Password", EmpInfo.Password)
            cmd.Parameters.AddWithValue("@UserType", EmpInfo.UserType)
            cmd.Parameters.AddWithValue("@EmployeeName", EmpInfo.EmployeeName)
            cmd.Parameters.AddWithValue("@EmpCode", EmpInfo.EmpCode)
            cmd.Parameters.AddWithValue("@DateOfBirth", EmpInfo.DateOfBirth)
            cmd.Parameters.AddWithValue("@JoiningDate", EmpInfo.JoiningDate)
            cmd.Parameters.AddWithValue("@DesignationID", EmpInfo.DesignationID)
            cmd.Parameters.AddWithValue("@DepartmentID", EmpInfo.DepartmentID)
            cmd.Parameters.AddWithValue("@ULCBranchID", EmpInfo.ULCBranchID)
            cmd.Parameters.AddWithValue("@CurrentSupervisor", EmpInfo.CurrentSupervisor)
            cmd.Parameters.AddWithValue("@EmpStatus", EmpInfo.EmpStatus)
            cmd.Parameters.AddWithValue("@MailAddress", EmpInfo.MailAddress)
            cmd.Parameters.AddWithValue("@MobileNo", EmpInfo.MobileNo)
            cmd.Parameters.AddWithValue("@IsActive", EmpInfo.IsActive)
            cmd.ExecuteNonQuery()
            con.Close()
            Result.Success = True
            Result.Message = "Employee Info: Sync. Successfully."
            Return Result
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Result.Success = False
            Result.Message = "Error Found: " & ex.Message
            Return Result
        End Try
    End Function

    Public Function fnUpdateEmpInfo(ByVal EmpInfo As clsEmployeeInfo) As clsResult
        Dim Result As New clsResult()
        Try
            Dim cmd As SqlCommand = New SqlCommand("spUpdateEmpInfo", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@EmployeeID", EmpInfo.EmployeeID)
            cmd.Parameters.AddWithValue("@UserID", EmpInfo.UserID)
            cmd.Parameters.AddWithValue("@UserPassword", EmpInfo.UserPassword)
            cmd.Parameters.AddWithValue("@UserType", EmpInfo.UserType)
            cmd.Parameters.AddWithValue("@EmployeeName", EmpInfo.EmployeeName)
            cmd.Parameters.AddWithValue("@EmpCode", EmpInfo.EmpCode)
            cmd.Parameters.AddWithValue("@DateOfBirth", EmpInfo.DateOfBirth)
            cmd.Parameters.AddWithValue("@JoiningDate", EmpInfo.JoiningDate)
            cmd.Parameters.AddWithValue("@DesignationID", EmpInfo.DesignationID)
            cmd.Parameters.AddWithValue("@DepartmentID", EmpInfo.DepartmentID)
            cmd.Parameters.AddWithValue("@ULCBranchID", EmpInfo.ULCBranchID)
            cmd.Parameters.AddWithValue("@CurrentSupervisor", EmpInfo.CurrentSupervisor)
            cmd.Parameters.AddWithValue("@EmpStatus", EmpInfo.EmpStatus)
            cmd.Parameters.AddWithValue("@IsActive", EmpInfo.IsActive)
            cmd.Parameters.AddWithValue("@EntryBy", EmpInfo.EntryBy)
            cmd.ExecuteNonQuery()
            con.Close()
            Result.Success = True
            Result.Message = "Employee Info: Updated Successfully."
            Return Result
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Result.Success = False
            Result.Message = "Error Found: " & ex.Message
            Return Result
        End Try
    End Function

    Public Function fnGetActiveEmpList() As DataSet

        Dim sp As String = "spGetActiveEmpList"
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

    Public Function fnGetAllEmpDetails() As DataSet

        Dim sp As String = "spGetAllEmpDetails"
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

#Region " Get Employee List "

    Public Function fnGetEmployeeList() As DataSet

        Dim sp As String = "spGetEmployeeList"
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

    Public Function fnGetBranchWiseEmpList(ByVal ULCBranchID As String) As DataSet

        Dim sp As String = "spGetBranchWiseEmpList"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@ULCBranchID", ULCBranchID)
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

    Public Function fnGetSubordinateList(ByVal CurrentSupervisor As String) As DataSet

        Dim sp As String = "spGetSubordinateList"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@CurrentSupervisor", CurrentSupervisor)
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

    Public Function fnGetSubordinateUsrChaseList(ByVal CurrentSupervisor As String) As DataSet

        Dim sp As String = "spGetSubordinateUsrChaseList"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@CurrentSupervisor", CurrentSupervisor)
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

    Public Function fnCheckUserLogin(ByVal EmpInfo As clsEmployeeInfo) As clsEmployeeInfo
        Dim sp As String = "spCheckUserLogin"
        Dim dr As SqlDataReader
        Try
            con.Open()
            Using cmd = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@UserID", EmpInfo.UserID)
                cmd.Parameters.AddWithValue("@UserPassword", EmpInfo.UserPassword)
                dr = cmd.ExecuteReader()
                While dr.Read()
                    EmpInfo.EmployeeID = dr.Item("EmployeeID")
                    EmpInfo.UserID = dr.Item("UserID")
                    EmpInfo.UserType = dr.Item("UserType")
                    EmpInfo.EmployeeName = dr.Item("EmployeeName")
                    EmpInfo.PermittedMenus = dr.Item("PermittedMenus")
                End While
                con.Close()
                Return EmpInfo
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

    Public Function fnGetEmpInfoForChaser(ByVal EmployeeID As String) As clsEmployeeInfo
        Dim Emp As New clsEmployeeInfo()
        Dim sp As String = "spGetEmpInfoForChaser"
        Dim dr As SqlDataReader
        Try
            conHRM.Open()
            Using cmd = New SqlCommand(sp, conHRM)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@EmployeeID", EmployeeID)
                dr = cmd.ExecuteReader()
                While dr.Read()
                    Emp.EmployeeID = dr.Item("EmployeeID")
                    Emp.UserID = dr.Item("UserID")
                    Emp.Password = dr.Item("Password")
                    Emp.UserType = dr.Item("UserType")
                    Emp.EmployeeName = dr.Item("EmployeeName")
                    Emp.EmpCode = dr.Item("EmpCode")
                    Emp.DateOfBirth = dr.Item("DateOfBirth")
                    Emp.JoiningDate = dr.Item("JoiningDate")
                    Emp.DesignationID = dr.Item("OfficialDesignationID")
                    Emp.DepartmentID = dr.Item("DepartmentID")
                    Emp.ULCBranchID = dr.Item("ULCBranchID")
                    Emp.CurrentSupervisor = dr.Item("CurrentSupervisor")
                    Emp.EmpStatus = dr.Item("Status")
                    Emp.MailAddress = dr.Item("MailAddress")
                    Emp.MobileNo = dr.Item("MobileNo")
                    Emp.IsActive = dr.Item("IsActive")
                End While
            End Using
            conHRM.Close()
            Return Emp
        Catch ex As Exception
            If conHRM.State = ConnectionState.Open Then
                conHRM.Close()
            End If
            Return Nothing
        End Try
    End Function

    Public Function fnGetAllEmpIDList() As String

        Dim EmpIDList As String = ""
        Dim sp As String = "spGetAllEmpIDList"
        Dim dr As SqlDataReader
        Try
            con.Open()
            Using cmd = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                dr = cmd.ExecuteReader()
                While dr.Read()
                    EmpIDList = dr.Item("EmpIDList")
                End While
            End Using
            con.Close()
            Return EmpIDList
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

    Public Function fnGetNewlyAddedEmp(ByVal EmpIDList As String) As DataSet

        Dim sp As String = "spGetNewlyAddedEmp"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            conHRM.Open()
            Using cmd = New SqlCommand(sp, conHRM)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@EmpIDList", EmpIDList)
                da.SelectCommand = cmd
                da.Fill(ds)
                conHRM.Close()
                Return ds
            End Using
        Catch ex As Exception
            If conHRM.State = ConnectionState.Open Then
                conHRM.Close()
            End If
            Return Nothing
        End Try
    End Function

    Public Function fnGetEmpDetailsByID(ByVal EmployeeID As String) As clsEmployeeInfo

        Dim EmpInfo As New clsEmployeeInfo()
        Dim sp As String = "spGetEmpDetailsByID"
        Dim dr As SqlDataReader
        Try
            con.Open()
            Using cmd = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@EmployeeID", EmployeeID)
                dr = cmd.ExecuteReader()
                While dr.Read()
                    EmpInfo.EmployeeName = dr.Item("EmployeeName")
                    EmpInfo.UserID = dr.Item("UserID")
                    EmpInfo.EmpCode = dr.Item("EmpCode")
                    EmpInfo.MailAddress = dr.Item("MailAddress")
                    EmpInfo.MobileNo = dr.Item("MobileNo")
                    EmpInfo.Designation = dr.Item("Designation")
                    EmpInfo.Department = dr.Item("Department")
                    EmpInfo.ULCBranchName = dr.Item("ULCBranchName")
                    EmpInfo.Supervisor = dr.Item("Supervisor")
                End While
            End Using
            con.Close()
            Return EmpInfo
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function


End Class
