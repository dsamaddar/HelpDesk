Imports Microsoft.VisualBasic
Imports System.Data.SqlClient
Imports System.Data

Public Class clsItemRequisitionDataAccess

    Dim con As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("HelpDeskConnectionString").ConnectionString)

#Region " Insert Multiple Requisition "

    Public Function fnInsertMultipleRequisition(ByVal ItemRequisition As clsItemRequisition) As Integer
        Try
            Dim cmd As SqlCommand = New SqlCommand("spInsertMultipleRequisition", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure

            cmd.Parameters.AddWithValue("@EmployeeID", ItemRequisition.EmployeeID)
            cmd.Parameters.AddWithValue("@RequisitionItemList", ItemRequisition.RequisitionItemList)
            cmd.Parameters.AddWithValue("@EntryBy", ItemRequisition.EntryBy)

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

#Region " Insert Multiple On Demand Requisition "

    Public Function fnInsertMultipleOnDemandReq(ByVal ItemRequisition As clsItemRequisition) As Integer
        Try
            Dim cmd As SqlCommand = New SqlCommand("spInsertMultipleOnDemandReq", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@RequisitionItemList", ItemRequisition.RequisitionItemList)
            cmd.Parameters.AddWithValue("@EntryBy", ItemRequisition.EntryBy)
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

#Region " Search Item Requisition "

    Public Function fnSearchItemRequisition(ByVal ItemRequisition As clsItemRequisition) As DataSet

        Dim sp As String = "spSearchItemRequisition"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@DateFrom", ItemRequisition.DateFrom)
                cmd.Parameters.AddWithValue("@DateTo", ItemRequisition.DateTo)
                cmd.Parameters.AddWithValue("@WarehouseID", ItemRequisition.WarehouseID)
                cmd.Parameters.AddWithValue("@BranchID", ItemRequisition.ULCBranchID)
                cmd.Parameters.AddWithValue("@DepartmentID", ItemRequisition.DepartmentID)
                cmd.Parameters.AddWithValue("@EmployeeID", ItemRequisition.EmployeeID)
                cmd.Parameters.AddWithValue("@ItemID", ItemRequisition.ItemID)
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

#Region " Reject Requisition "

    Public Function fnRejectRequisition(ByVal ItemRequisition As clsItemRequisition) As Integer
        Try
            Dim cmd As SqlCommand = New SqlCommand("spRejectRequisition", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure

            cmd.Parameters.AddWithValue("@RequisitionID", ItemRequisition.RequisitionID)
            cmd.Parameters.AddWithValue("@ApproverRemarks", ItemRequisition.ApproverRemarks)
            cmd.Parameters.AddWithValue("@EntryBy", ItemRequisition.EntryBy)
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

#Region " Accept Requisition "

    Public Function fnAcceptRequisition(ByVal ItemRequisition As clsItemRequisition) As Integer
        Try
            Dim cmd As SqlCommand = New SqlCommand("spAcceptRequisition", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure

            cmd.Parameters.AddWithValue("@RequisitionID", ItemRequisition.RequisitionID)
            cmd.Parameters.AddWithValue("@WarehouseID", ItemRequisition.WarehouseID)
            cmd.Parameters.AddWithValue("@ItemID", ItemRequisition.ItemID)
            cmd.Parameters.AddWithValue("@ApprovedQuantity", ItemRequisition.ApprovedQuantity)
            cmd.Parameters.AddWithValue("@ApproverRemarks", ItemRequisition.ApproverRemarks)
            cmd.Parameters.AddWithValue("@EntryBy", ItemRequisition.EntryBy)
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

#Region " Advance Accept Requisition "

    Public Function fnAdvAcceptRequisition(ByVal ItemRequisition As clsItemRequisition) As Integer
        Try
            Dim cmd As SqlCommand = New SqlCommand("spAdvAcceptRequisition", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure

            cmd.Parameters.AddWithValue("@RequisitionIDList", ItemRequisition.RequisitionIDList)
            cmd.Parameters.AddWithValue("@WarehouseID", ItemRequisition.WarehouseID)
            cmd.Parameters.AddWithValue("@ApproverRemarks", ItemRequisition.ApproverRemarks)
            cmd.Parameters.AddWithValue("@EntryBy", ItemRequisition.EntryBy)
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

#Region " Request Departmental Approval "

    Public Function fnReqDeptApproval(ByVal ItemRequisition As clsItemRequisition) As Integer
        Try
            Dim cmd As SqlCommand = New SqlCommand("spReqDeptApproval", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure

            cmd.Parameters.AddWithValue("@RequisitionIDList", ItemRequisition.RequisitionIDList)
            cmd.Parameters.AddWithValue("@EntryBy", ItemRequisition.EntryBy)
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

#Region " Deliver Requisition "

    Public Function fnDeliverRequisition(ByVal ItemRequisition As clsItemRequisition) As Integer
        Try
            Dim cmd As SqlCommand = New SqlCommand("spDeliverRequisition", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure

            cmd.Parameters.AddWithValue("@RequisitionIDList", ItemRequisition.RequisitionIDList)
            cmd.Parameters.AddWithValue("@DeliveredBy", ItemRequisition.DeliveredBy)
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

#Region " Request Departmental Rejection "

    Public Function fnReqDeptRejection(ByVal ItemRequisition As clsItemRequisition) As Integer
        Try
            Dim cmd As SqlCommand = New SqlCommand("spReqDeptRejection", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure

            cmd.Parameters.AddWithValue("@RequisitionIDList", ItemRequisition.RequisitionIDList)
            cmd.Parameters.AddWithValue("@ApproverRemarks", ItemRequisition.ApproverRemarks)
            cmd.Parameters.AddWithValue("@EntryBy", ItemRequisition.EntryBy)
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

#Region " Get Requisition History By UserID "

    Public Function fnGetReqHistoryByUserID(ByVal ItemRequisition As clsItemRequisition) As DataSet
        Try
            Dim cmd As SqlCommand = New SqlCommand("spGetReqHistoryByUserID", con)
            Dim ds As New DataSet()
            Dim da As New SqlDataAdapter()
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@EmployeeID", ItemRequisition.EmployeeID)
            da.SelectCommand = cmd
            da.Fill(ds)
            con.Close()
            Return ds
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

#End Region

#Region " Itm Requisition For Dept Approval "

    Public Function fnItmReqForDeptApproval(ByVal ItemRequisition As clsItemRequisition) As DataSet
        Try
            Dim cmd As SqlCommand = New SqlCommand("spItmReqForDeptApproval", con)
            Dim ds As New DataSet()
            Dim da As New SqlDataAdapter()
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@DateFrom", ItemRequisition.DateFrom)
            cmd.Parameters.AddWithValue("@DateTo", ItemRequisition.DateTo)
            cmd.Parameters.AddWithValue("@BranchID", ItemRequisition.ULCBranchID)
            cmd.Parameters.AddWithValue("@DepartmentID", ItemRequisition.DepartmentID)
            cmd.Parameters.AddWithValue("@SupervisorID", ItemRequisition.SupervisorID)
            da.SelectCommand = cmd
            da.Fill(ds)
            con.Close()
            Return ds
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

#End Region

#Region " Get Pending Requisition List To Deliver"

    Public Function fnGetPendingReqListToDeliver(ByVal ItemRequisition As clsItemRequisition) As DataSet
        Try
            Dim cmd As SqlCommand = New SqlCommand("spGetPendingReqListToDeliver", con)
            Dim ds As New DataSet()
            Dim da As New SqlDataAdapter()
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@DateFrom", ItemRequisition.DateFrom)
            cmd.Parameters.AddWithValue("@DateTo", ItemRequisition.DateTo)
            cmd.Parameters.AddWithValue("@ULCBranchID", ItemRequisition.ULCBranchID)
            cmd.Parameters.AddWithValue("@DepartmentID", ItemRequisition.DepartmentID)
            da.SelectCommand = cmd
            da.Fill(ds)
            con.Close()
            Return ds
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

#End Region

#Region " Get Requisition By Delivery Entry Point "

    Public Function fnGetReqByDeliveryEntryPoint(ByVal DeliveryEntryPoint As String, ByVal DateFrom As DateTime, ByVal DateTo As DateTime) As DataSet
        Try
            Dim cmd As SqlCommand = New SqlCommand("spGetReqByDeliveryEntryPoint", con)
            Dim ds As New DataSet()
            Dim da As New SqlDataAdapter()
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@DeliveryEntryPoint", DeliveryEntryPoint)
            cmd.Parameters.AddWithValue("@DateFrom", DateFrom)
            cmd.Parameters.AddWithValue("@DateTo", DateTo)
            da.SelectCommand = cmd
            da.Fill(ds)
            con.Close()
            Return ds
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

#End Region

#Region " Get Delivery Entry Point "

    Public Function fnGetDeliveryEntryPoint() As DataSet
        Try
            Dim cmd As SqlCommand = New SqlCommand("spGetDeliveryEntryPoint", con)
            Dim ds As New DataSet()
            Dim da As New SqlDataAdapter()
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            da.SelectCommand = cmd
            da.Fill(ds)
            con.Close()
            Return ds
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

#End Region

#Region " Get Requisition Status "

    Public Function fnGetRequisitionStatus() As DataSet
        Try
            Dim cmd As SqlCommand = New SqlCommand("spGetRequisitionStatus", con)
            Dim ds As New DataSet()
            Dim da As New SqlDataAdapter()
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            da.SelectCommand = cmd
            da.Fill(ds)
            con.Close()
            Return ds
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

#End Region

#Region " Show Requisition Report "

    Public Function fnShowRequisitionReport(ByVal ItemRequisitionInfo As clsItemRequisition) As DataSet
        Try
            Dim cmd As SqlCommand = New SqlCommand("spShowRequisitionReport", con)
            Dim ds As New DataSet()
            Dim da As New SqlDataAdapter()
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@DateFrom", ItemRequisitionInfo.DateFrom)
            cmd.Parameters.AddWithValue("@DateTo", ItemRequisitionInfo.DateTo)
            cmd.Parameters.AddWithValue("@ULCBranchID", ItemRequisitionInfo.ULCBranchID)
            cmd.Parameters.AddWithValue("@DepartmentID", ItemRequisitionInfo.DepartmentID)
            cmd.Parameters.AddWithValue("@EmployeeID", ItemRequisitionInfo.EmployeeID)
            cmd.Parameters.AddWithValue("@Status", ItemRequisitionInfo.Status)
            cmd.Parameters.AddWithValue("@ItemID", ItemRequisitionInfo.ItemID)
            da.SelectCommand = cmd
            da.Fill(ds)
            con.Close()
            Return ds
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

#End Region

End Class
