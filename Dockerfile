FROM dart:stable AS build
WORKDIR /app
COPY pubspec.* ./
RUN dart pub get

COPY . .
RUN dart pub get --offline
RUN dart compile exe bin/wemoux.dart -o /app/wemoux

FROM alpine
COPY --from=build /runtime/ /
COPY --from=build /app/wemoux /app
RUN apk add --no-cache tzdata \
	&& cp /usr/share/zoneinfo/America/New_York /etc/localtime \
	&& echo America/New_York > /etc/timezone
ENV TZ=America/New_York
ENTRYPOINT [ "/app" ]
