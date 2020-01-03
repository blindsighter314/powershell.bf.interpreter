$code = '$memory = 0, 0; $pointer = 0; $i = 0; while ($i -lt 98) { $memory += 0; $i++ }; '
$raw = Read-Host

foreach ($func in $raw.ToCharArray()) {
	If ($func -eq '+') {
		$code = $code + '$memory[$pointer]++; If ($memory[$pointer] -eq 256) { $memory[$pointer] = 0 }; '
	}

	If ($func -eq '-') {
		$code = $code + '$memory[$pointer]--; If ($memory[$pointer] -eq -1) { $memory[$pointer] = 255 }; '
	}

	If ($func -eq '>') {
		$code = $code + '$pointer++; If ($pointer -gt 99) { throw "Pointer outside of limit" }; '
	}

	If ($func -eq '<') {
		$code = $code + '$pointer--; If ($pointer -lt 0) { throw "Pointer outside of limit" }; '
	}

	If ($func -eq '[') {
		$code = $code + 'while ($memory[$pointer] -ne 0) { '
	}

	If ($func -eq ']') {
		$code = $code + '}; '
	}

	If ($func -eq '.') {
		$code = $code + '$out = [char]$memory[$pointer]; echo $out; '
	}

	If ($func -eq ',') {
		$code = $code + '$in = Read-Host; $in = [int[]][char[]]$in; $memory[$pointer] = $in[0]; '
	}
}

Invoke-Expression -Command $code
