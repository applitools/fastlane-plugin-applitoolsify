# applitoolsify plugin

[![fastlane Plugin Badge](https://rawcdn.githack.com/fastlane/fastlane/master/fastlane/assets/plugin-badge.svg)](https://rubygems.org/gems/fastlane-plugin-applitoolsify)

## Getting Started

This project is a [_fastlane_](https://github.com/fastlane/fastlane) plugin. To get started with `fastlane-plugin-applitoolsify`, add it to your project by running:

```bash
fastlane add_plugin applitoolsify
```

## About applitoolsify

Add Applitools SDKs (UFG_lib.xcframework) to iOS apps as fastlane-plugin

## Example

Check out the [example `Fastfile`](fastlane/Fastfile) to see how to use this plugin. Try it by cloning the repo, running `fastlane install_plugins` and `bundle exec fastlane test`.

## Using _fastlane_ Plugins

For more information about how the `fastlane` plugin system works, check out the [Plugins documentation](https://docs.fastlane.tools/plugins/create-plugin/).

Adding lib into app-file, require path to your app-file:
```
applitoolsify applitoolsify_input: './some.app'
```
For debug purposes you can store original file as is, by providing parameter where will to put app with lib:
```
applitoolsify applitoolsify_input: './before.app', applitoolsify_output: './after.app'
```

## About _fastlane_

_fastlane_ is the easiest way to automate beta deployments and releases for your iOS and Android apps. To learn more, check out [fastlane.tools](https://fastlane.tools).

### fastline-docs links:
- Install Fastline https://docs.fastlane.tools/#getting-started
- Add Plugin https://docs.fastlane.tools/plugins/using-plugins/#add-a-plugin-to-your-project
- Run tasks https://docs.fastlane.tools/plugins/using-plugins/#run-with-plugins
