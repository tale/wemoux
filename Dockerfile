FROM dart:stable AS build
WORKDIR /app
COPY pubspec.* ./
RUN dart pub get

COPY . .
RUN dart pub get --offline
RUN dart compile exe bin/wemoux.dart -o bin/wemoux

FROM scratch
COPY --from=build /runtime/ /
COPY --from=build /app/bin/wemoux /app/bin
CMD [ "/app/bin/wemoux" ]
