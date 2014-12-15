##What is this?

What if you could just extract the Gradle wrapper files into the current
directory without ever running Gradle or even having it installed? Well now you
can do that with `gradle-wrapper-here`.

I like the [Gradle wrapper](http://www.gradle.org/docs/2.2.1/userguide/gradle_wrapper.html),
but I think it's silly to have to have an actual installation of Gradle on your
machine to bootstrap from before you can start using it for the first time on a
project. If you've never used Gradle before, I think this is a much quicker
mechanism to getting a working Gradle installation set up for a project.

##Installation
Drop the latest version of `gradle-wrapper-here` into your $PATH and set it executable:

```bash
sudo curl -o /usr/local/bin/gradle-wrapper-here -L https://github.com/rholder/gradle-wrapper-here/releases/download/v0.1.0/gradle-wrapper-here && \
sudo chmod +x /usr/local/bin/gradle-wrapper-here
```

##Use
There isn't really much to this project, it extracts a copy of the Gradle
wrapper out into the current directory, as in:
```bash
cd new_cool_project
gradle-wrapper-here
```
Now you should have `gradlew` and some other goodies in your project directory.
Run the following to verify it's working:
```bash
./gradlew -version
```
If you haven't ever used the Gradle wrapper before, it will download and unpack
a version of Gradle into a well-known location for the current user. Running
`./gradlew` again won't redownload it.

##License
The `gradle-wrapper-here` project is released under version 2.0 of the
[Apache License](http://www.apache.org/licenses/LICENSE-2.0).