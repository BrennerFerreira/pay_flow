# Pay Flow

Welcome to Pay Flow, the app that helps you to keep your daily bills organized.

## Inspiration

This project is inspired in [this repository](https://github.com/rocketseat-education/nlw-06-flutter),
that was created during the Next Level Week event organized by [Rocketseat](https://rocketseat.com.br/).

## Design

The entire design and assets used are available in [this link](https://www.figma.com/file/kLK7FYnWKMoN68sQXcSniu/PayFlow?node-id=0%3A1)
with small changes to provide a better experience to the user.

## Development

The app has three flavors: dev, preview and prod.

### Dev

Flavor to use in local development environment.

### Preview

Flavor to use for testing the app in an environment closer to the production
environment.

### Prod

Production ready environment flavor.

## Architecture

The app is separated in modules. Each module has its own UI, controller and
services to comunicate with external sources. To keep controllers and services
independent, the [Injectable](https://pub.dev/packages/injectable) package is
used to generate dependency injection. Modules that are used by other modules
are inside the [shared](lib/shared) folder.

### Services

All services have interfaces to keep third party services independent from
project, being easily replaceable.

### Controllers

This app uses [Provider](https://pub.dev/packages/provider) to manage the UI
state. All controllers that need to communicate with services do so through
the interfaces, avoid direct communication with external packages.

## CI/CD

This repository is hooked with [Codemagic](https://codemagic.io/) with three
workflows.

All pushes to the `dev` branch trigger a workflow to create an
appbundle for the preview flavor.

Pushes to the `preview` branch trigger an automatic deploy to Google Play in
alpha track (Closed Testing) to assure the app works as expected.

Finally, pushes to `main` branch trigger an automatic deploy to Google Play in
production track, making the changes available to all users.

## Possible improvements

There are a few areas to improve this app, including:

- Automated tests;
- Read bar code from PDF files;
- Add options to user configure some personal settings, such as light/dark mode
and delete account.

## Final thoughts

All constructive feedback is welcomed. I am constantly looking for way to improve
this app and the user experience when using it.
