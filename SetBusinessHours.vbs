Set result = objUX.ExecMethod_("SetBusinessHours", inParam)Set objUX = GetObject("winmgmts:\\.\root\ccm\ClientSDK:CCM_ClientUXSettings")
 
Set inParam = objUX.Methods_.Item("SetBusinessHours").inParameters.SpawnInstance_()
 inParam.StartTime = 23
 inParam.EndTime = 0
 inParam.WorkingDays = 62
