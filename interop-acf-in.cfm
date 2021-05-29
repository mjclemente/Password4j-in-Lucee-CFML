<cfscript>

	// Read-in the file generated by Lucee CFML (with Password4j).
	data = deserializeJson( fileRead( expandPath( "./interop.json" ) ) );

	for ( test in data ) {

		switch ( test.algorithm ) {
			case "bcrypt":

				input = test.input;
				hashedInput = test.hashedInput;

				writeDump( verifyBcryptHash( input, hashedInput ) );

			break;
			case "scrypt":

				input = test.input;
				// CAUTION: I have to remove "$s0" to get Adobe ColdFusion 2021 to like
				// the hash generated by the Password4j scrypt function.
				hashedInput = test
					.hashedInput
					.reReplace( "^\$s0", "" )
				;

				writeDump( verifyScryptHash( input, hashedInput ) );

			break;
		}

	}

</cfscript>
