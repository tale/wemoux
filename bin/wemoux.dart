import 'package:cron/cron.dart';
import 'package:nyxx/nyxx.dart';
import 'package:intl/intl.dart';

import 'env.dart';
import 'storage.dart';

void main() {
	final cron = Cron();
	final bot = NyxxFactory.createNyxxWebsocket(
		discordToken(),
		GatewayIntents.guilds | GatewayIntents.guildMessages
	)
		..registerPlugin(Logging())
		..registerPlugin(CliIntegration())
		..connect();

	bot.eventsWs.onReady.listen((event) async {
		bot.setPresence(PresenceBuilder.of(
			status: UserStatus.online,
			activity: ActivityBuilder.watching('for Trollspicions')
		));

		cron.schedule(Schedule.parse('0 0 * * *'), () async {
			final store = await getLatestStore();

			final date = DateTime.now();
			final dateString = DateFormat('EEEE MMMM dd, yyyy').format(date.toLocal());

			final channel = await bot.fetchChannel<ITextGuildChannel>(Snowflake(logOfLagId()));
			final embed = EmbedBuilder()
				..addField(
					name: 'Day ${store.currentDate}   <:fr:879879477138706472>',
					content: '$dateString\n[Yesterday\'s Log](${store.lastNotify})',
					inline: true
				)
				..color = DiscordColor.azure;

			final message = await channel.sendMessage(MessageBuilder.embed(embed));
			await updateStore(Storage(currentDate: store.currentDate + 1, lastNotify: message.url));

			final newTopic = 'The Classic™️ (Day ${store.currentDate})';
			await channel.edit(TextChannelBuilder()..topic = newTopic);
		});
	});
}
