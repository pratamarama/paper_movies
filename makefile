init: clean get generate

clean:
	echo "Cleaning the project" ; \
	flutter clean ; \

get:
	echo "Updating dependencies" ; \
	flutter pub get ; \

generate:
	echo "Generating needed codes" ; \
	flutter packages pub run build_runner build --delete-conflicting-outputs