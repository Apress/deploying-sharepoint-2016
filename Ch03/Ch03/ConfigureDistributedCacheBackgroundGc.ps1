$xmlDoc = [xml](Get-Content "C:\Program Files\AppFabric 1.1 for Windows Server\DistributedCacheService.exe.config") 
$createAppElement = $xmlDoc.CreateElement("appSettings") 
$appElement = $xmlDoc.configuration.AppendChild($createAppElement) 
$createAddElement = $xmldoc.CreateElement("add") 
$addElement = $appElement.AppendChild($createAddElement) 
$addElement.SetAttribute("key", "backgroundGC") 
$addElement.SetAttribute("value", "true") 
$xmlDoc.Save("C:\Program Files\AppFabric 1.1 for Windows Server\DistributedCacheService.exe.config") 

# Adds the following text to the configuration file
#  <appSettings> 
#    <add key="backgroundGC" value="true" /> 
#  </appSettings>  