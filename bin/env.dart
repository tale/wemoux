import 'dart:io';

String discordToken() {
	return _getGenericEnv('DISCORD_TOKEN');
}

String logOfLagId() {
	return _getGenericEnv('LOG_OF_LAG_ID');
}

String _getGenericEnv(String name) {
	if (Platform.environment.containsKey(name)) {
		return Platform.environment[name]!;
	} else {
		print('Missing $name');
		exit(1);
	}
}
