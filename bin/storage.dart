import 'dart:convert';
import 'dart:io';

class Storage {
	Storage({ required this.currentDate, required this.lastNotify });

	int currentDate;
	String lastNotify;

	factory Storage.fromJson(dynamic json) {
		return Storage(currentDate: json['currentDate'], lastNotify: json['lastNotify']);
	}

	Map<String, dynamic> toJson() => {
		'currentDate': currentDate,
		'lastNotify': lastNotify,
	};
}

Future<void> updateStore(Storage store) async {
	final handle = File('/bot/config.json');
	await handle.writeAsString(jsonEncode(store));
	return;
}

Future<Storage> getLatestStore() async {
	final handle = File('/bot/config.json');
	final exists = await handle.exists();

	if (!exists) {
		return Storage(currentDate: 1, lastNotify: '');
	}

	final contents = await handle.readAsString();
	final decoded = jsonDecode(contents);
	final storage = Storage.fromJson(decoded);
	return storage;
}
