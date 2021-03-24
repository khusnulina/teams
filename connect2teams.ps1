# PowerShell Commands
# Connect to Microsoft Teams
Connect-MicrosoftTeams -AccountId 'user1@domain.name'

$group = New-Team -MailNickname "Marketing" -displayname "Marketing" -Visibility "private"

# Add new users
Add-TeamUser -GroupId $group.GroupId -User 'user1@domain.name'
Add-TeamUser -GroupId $group.GroupId -User 'user2@domain.name'
Add-TeamUser -GroupId $group.GroupId -User 'user3@domain.name'
Add-TeamUser -GroupId $group.GroupId -User 'user4@domain.name'

# Create channels 
New-TeamChannel -GroupId $group.GroupId -DisplayName 'Planning'
New-TeamChannel -GroupId $group.GroupId -DisplayName 'Demand Generations'
New-TeamChannel -GroupId $group.GroupId -DisplayName 'Go to Market'


# Connect to Skype for Business
$Session = New-CsOnlineSession
Import-PSSession -Session $session -AllowClobber

# Configure Direct Routing
# Configure DNS (Discover + SBC FQDN)
# FireWall - sip-all.pstnhub.microsoft.com
# Media Processor - 52.11.0.0/14
# Media Bypass
# Separate Direct Routing/Carrier/Management Interfaces
# Configure SYSLOG
#   Install Root&Intermediate Cert
#   Install Baltimore Cert
# Configure Proxy Address  (sip.pstnhub.microsoft.com | sip2.pstnhub.microsoft.com | sip3.pstnhub.microsoft.com
# Invite messages 

# Create SBC for Direct Routing
New-CsOnlinePSTNGateway -Identity "sbc.iron-neo.com" -SipSignalingPort "5067" -MaxConcurrentSessions "3" -Enabled $true
Set-CsOnlinePstnUsage -Identity Global -Usage @{Add="Russia"}
New-CsOnlineVoiceRoute -Identity "Russia" -NumberPattern "^+7(\d{9})$" -OnlinePstnGatewayList "sbc.iron-neo.com" -Priority 1 -OnlinePstnUsages "Russia"
New-CsOnlineVoiceRoutingPolicy -Identity "Russia" -OnlinePSTNUsages "Russia"

# Update current SBC
Set-CsOnlinePSTNGateway -Identity "sbc.iron-neo.com" -SipSignalingPort "5067" -MaxConcurrentSessions "3" -Enabled $true

# Enable User
Set-CsUser -Identity "user1@domain.name" -EnterpriseVoiceEnabled $true -HostedVoiceMail $true -OnPremLineURI "tel:+79172264119"
# Assign Voice Routing Policy
Grant-CSOnlineVoiceRoutingPolicy -Identity "user1@domain.name" -PolicyName "Russia"
