[CmdletBinding()]
param(
	[Parameter(Mandatory = $true, ValueFromPipeLine = $false,ValueFromPipelineByPropertyName = $false)][int] $precision
)
#example:   .\pi.ps1 -precision 100
Begin{
	class PI {
		
		
		PI($prec){
			$Big = [bigint[]](0..10)
			$ndigits = 0
			$Output = ""
	 
			$q = $t = $k = $big[1]
			$r =           $big[0]
			$l = $n =      $big[3]
			# Calculate first digit
			$nr = ( $big[2] * $q + $r ) * $l
			$nn = ( $q * ( $big[7] * $k + $big[2] ) + $r * $l ) / ( $t * $l )
			$q *= $k
			$t *= $l
			$l += $big[2]
			$k = $k + $big[1]
			$n = $nn
			$r = $nr
	 
			$Output += [string]$n + '.'
			$ndigits++
	 
			$nr = $big[10] * ( $r - $n * $t )
			$n = ( ( $big[10] * ( 3 * $q + $r ) ) / $t ) - 10 * $n
			$q *= $big[10]
			$r = $nr
		 
			While ( $ndigits -lt $prec ){
				While ( $ndigits % 100 -ne 0 -or -not $Output ){
					If ( $big[4] * $q + $r - $t -lt $n * $t ){
						$Output += [string]$n
						$ndigits++
						$nr = $big[10] * ( $r - $n * $t )
						$n = ( ( $big[10] * ( 3 * $q + $r ) ) / $t ) - 10 * $n
						$q *= $big[10]
						$r = $nr
					}Else{
						$nr = ( $big[2] * $q + $r ) * $l
						$nn = ( $q * ( $big[7] * $k + $big[2] ) + $r * $l ) / ( $t * $l )
						$q *= $k
						$t *= $l
						$l += $big[2]
						$k = $k + $big[1]
						$n = $nn
						$r = $nr
					}
				}
				write-host $Output
				$Output = ""
			}

		}
	}
}
Process{
	[PI]::new($precision)
}
End{

}
