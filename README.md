# TMI-Web

TMI-Web is a qualitatice social science system for managing, analyzing, coding, and visualizing data on intersectional identities. It presents identity and experience in a network graph, encouraging tactile exploration of intersections of privilege and marginalization.

[![Hippocratic License HL3-CORE](https://img.shields.io/static/v1?label=Hippocratic%20License&message=HL3-CORE&labelColor=5e2751&color=bc8c3d)](https://firstdonoharm.dev/version/3/0/core.html)

# Theoretical Grounding

Westbrook, J.P., and Ehmke, C.A. (2026) Queer(ing) Epistemology by Design: TMI-WEB—A Relational Knowledge System for Intersectional Data Science and Affective Queries, in Simeone, L., Gray, C. M., Verhoeven, A., de Götzen, A., Bakırlıoğlu, Y., Zohar, H., Stead, M., and Buwert, P. (eds.), DRS2026: Edinburgh, 8–12 June, Edinburgh, United Kingdom. [https://doi.org/10.21606/drs.2026.483](https://doi.org/10.21606/drs.2026.483)

<img width="2047" height="1081" alt="tmi-screenshot-app-and-graph" src="https://github.com/user-attachments/assets/0cd6ba80-6d33-4192-9077-d6bf038fc26a" />

# Installing TMI-WEB

## STEP 1:  DOWNLOAD/INSTALL NEO4J DESKTOP

Neo4j Desktop is an application that manages the Neo4j database used by the TMI-WEB data analysis software system. 

1. Go to the [Neo4j Desktop download page](https://neo4j.com/download) and click the blue download button.
2. You will be asked to fill out a short form before downloading.
3. When the download finishes, find the downloaded file. It will usually be in your computer’s Downloads folder.
4. Open the downloaded file and follow the instructions on your screen to install Neo4j Desktop on your computer.
5. When installation is complete, locate and open Neo4j Desktop.

You’re done with this step 1: Neo4j Desktop opens successfully on your computer.

## STEP 2: SETUP NEO4J DESKTOP 

You do not need to know how to use Neo4j or work with databases to complete this step. 

 1. Open Neo4j Desktop. ReviewApprove the licensing agreement and approve if you are comfortable. Continue.
 2. Click Create instance. Use name ‘tmi-web’ and password ‘password’. Click the Create button.
 3. Neo4j Desktop may offer to install AI tools, plugins, or other additional features. You do not need these for TMI-WEB. Skip or close these options.
 4. See your tmi-web instance in the main area. You will not be creating any databases. Neo4j automatically creates the databases we need. For future reference you may turn the tmi-instance on and off using what looks like a “play” button top right.
 5. Download project practice data using the link provided to you by the TMI research team, if you have requested one. 
 6. Stop the tmi-web instance using the “play” button. You will see STOPPED in gray. In the tmi-web instance, click Databases (2) to expand the list of databases. Find the database named neo4j. Click the three-dot menu (⋯) next to the neo4j database.
 7. Select the ‘Load database from file’ option in the menu.
 8. Find and select the TMI-WEB database file you recently downloaded to your computer.

You’re done with step 2. The database and data are ready to use. If you quit Neo4j Desktop, you may be asked whether you want to stop the running instance. It is okay to stop it. This does no harm.

## STEP 3: INSTALL TMI-WEB

TMI-WEB requires several tools to run. We’ll first check what is already installed on your computer and then install anything that is missing.

### 3.1 Check for required tools

Development tools are supporting programs that allow your computer to install, build, and run software from source code. TMI-WEB uses some software packages that need these tools during installation. You do not need to know how to use the development tools yourself; they just need to be installed on your computer.

You may or may not already have the necessary development tools installed. The particular tools and installation process vary depending on your operating system.

- If using macOS: You may need to install Apple Developer Tools from the App Store
- If using Windows: You may need to install additional development tools. 
- If using Linux: Likely all set, but packages may be needed based on your distribution.

### 3.2 Check for required Ruby version

Ruby is a programming language. You may or may not have Ruby installed on your computer. TMI-WEB requires Ruby 4 or greater. Open a command-line application: 

- If using macOS: Terminal. 
- If using Windows: PowerShell or Windows Terminal. 
- If using Linux: Terminal. 

In your command-line application copy/paste or type the command then press Enter. To execute a command you will always press Enter.

| Check Ruby Version Command: | Meaning                                                                         |
| --------------------------- | ------------------------------------------------------------------------------- |
| `ruby -v`                   | Check the version number of the Ruby environment, if Ruby is already installed. |

If Ruby is installed, you will see its version number. If you see “command not found,” or the version is below 4.0, continue to Step 3.3. If the version is 4.0 or greater, you are all set and may skip installation and go to item 3.4.

### 3.3 Install or Update Ruby

You can use a package manager or a direct Ruby installation method appropriate for your operating system. 

If you are new to this and are using macOS, we recommend using [Homebrew](https://brew.sh/). Homebrew is a package manager that makes it easier to install and update software from Terminal. 

In Terminal, run the official Homebrew installer:

|                                                                                                   |
| ------------------------------------------------------------------------------------------------- |
| Install Homebrew Command:                                                                         |
| `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"` |
It will walk you through installation and may ask for your Mac password. At the end, Homebrew usually prints commands under “Next steps” for adding brew to your PATH. Run those commands exactly as shown. Then verify.

| Verify Homebrew Installation Command: | Meaning                                              |
| ------------------------------------- | ---------------------------------------------------- |
| `brew --version`                      | Ask the Homebrew application for its version number. |

If that prints something like Homebrew 5.x.x, you're set. Then you can install Ruby.

| Install Ruby Command: | Meaning                                                                |
| --------------------- | ---------------------------------------------------------------------- |
| `brew install ruby`   | Ask the Homebrew application to install the Ruby programming language. |

Now we are ready to install TMI-WEB! Here are the commands (you may be prompted for your computer password. This is OK).

| Install TMI-WEB Commands                                              | Meaning                                                                              |
| --------------------------------------------------------------------- | ------------------------------------------------------------------------------------ |
| `git clone https://github.com/identity-research-lab/tmi-web-beta.git` | Download a copy of the TMI-WEB application source code for the first time.           |
| `cd tmi-web-beta`                                                     | Open the new "tmi-web-beta" folder.                                                  |
| bundle install                                                        | Update necessary tools/files.                                                        |
| `cp .env.example .env`                                                | Make a copy of the hidden configuration file ".env.example" and name the copy ".env" |

You’re done with step 3. TMI-WEB is installed on your computer. TMI-WEB is a local application running on your computer. It is not running in the cloud. Your project and all its data is stored locally on your computer. You do not need an internet connection to use TMI-WEB.

## STEP 4: LAUNCH THE TMI-WEB APPLICATION

Every time you want to use TMI-WEB you must follow these steps in order.

1. Launch your Neo4j desktop and start the tmi-web instance. Hit the ‘start instance’ play button on your tmi-web instance. After a moment you should see RUNNING in green.
2. Open your command-line application again and enter the following commands: 

| Start TMI-WEB Commands | Meaning                              |
| ---------------------- | ------------------------------------ |
| `cd tmi-web-beta`      | Open the "tmi-web-beta" folder       |
| `bin/rails server`     | Start the TMI-WEB server application |
3. Launch your favorite web browser and enter this url: [http://localhost:3000](http://localhost:3000/)

You’re done with this Step 4: You are running TMI-WEB successfully on your computer!

Note that the first time loading your data a page may be slow and take a minute to generate all content. The system is building its search indexes. 

## STEP 5: HOW TO HANDLE A CRASH

Software is imperfect and sometimes things go wrong. 

If TMI-WEB freezes, doesn't respond, or shows you an error that starting from the home page doesn't fix, you may need to recover from a crash. 

First ensure that you have followed all of the steps in Step 4. Double-check that the Neo4j Desktop application is open and the database instance is running.

Next, try restarting your browser. If this doesn't help, you may need to force the TMI-WEB software to restart manually, following these steps:

1. Return to your command-line application where TMI-WEB is running.
2. Press Control-c one or more times to stop the application. If this doesn't work, you may need to quit your Terminal application and restart TMI-WEB using the instructions in 4.2.
3. If Control-c stopped the application, you can start it again using `bin/rails server`
4. If this command returns an error like "A server is already running (pid: 81183, file: /Users/jesswestbrook/tmi-web-beta/tmp/pids/server.pid)", type the following command: 

| Clean Up TMI-WEB Crash Commands | Meaning                                |
| ------------------------------- | -------------------------------------- |
| `rm tmp/pids/server.pid`        | Delete the crashed server's temp file. |

5.  Then try starting it again with `bin/rails server`.

If the problem persists, you should check to see if the TMI-WEB software has been updated with a bug fix. Follow the instructions in STEP 6 to upgrade your software to the latest version.

You’re done: You have recovered from a TMI-WEB crash successfully! Sorry for the fuss.

## STEP 6: UPDATING THE SOFTWARE

When a TMI-WEB application update is available, you will follow these steps to upgrade your software.
1. Open your command-line application and enter the following commands: 

| Update TMI-WEB Commands | Meaning                        |
| ----------------------- | ------------------------------ |
| `cd tmi-web-beta`       | Open the "tmi-web-beta" folder |
| `git pull`              | Download the source code       |
| `bundle update`         | Update other necessary tools   |
2) You should be able to start the updated TMI-WEB system as you normally would.

You’re done: You have updated TMI-WEB successfully on your computer!

# References

* []
