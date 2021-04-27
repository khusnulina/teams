Audiocodes Mediant VE Session Border Control (SBC)
CN: <* или sbc.domain.com>
SAN: <sbc.domain.com>
DNS CNAME sbc.domain.com 0.0.0.0
VM size - Standard DS1 v2
10.1.0.0/24

$Session = New-CsOnlineSession
Import-PSSession -Session $session -AllowClobber

Set-CsOnlinePSTNGateway -Identity "sbc.iron-neo.com" -SipSignalingPort "5067" -MaxConcurrentSessions "3" -Enabled $true

New-CsOnlinePSTNGateway -Identity "sbc.iron-neo.com" -SipSignalingPort "5067" -MaxConcurrentSessions "3" -Enabled $true

