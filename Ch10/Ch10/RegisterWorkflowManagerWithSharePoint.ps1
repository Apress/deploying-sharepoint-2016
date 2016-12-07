$wa = Get-SPWebApplication https://sharepoint.learn-sp2016.com 
$zp = $wa.ZonePolicies("Default") 
$policy = $zp.Add("i:0#.w|CORP\s-wfm", "Workflow Manager") 
$policyRole = $wa.PolicyRoles.GetSpecialRole("FullControl") 
$policy.PolicyRoleBindings.Add($policyRole) 
$wa.Update() 
Register-SPWorkflowService -SPSite https://sharepoint.learn-sp2016.com -WorkflowHostUri https://workflow.corp.learn-sp2016.com:12290 