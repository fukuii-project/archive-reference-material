This small collection of scripts can be used to archive Github Discourse data (Pull Requests, Issues) using Git version control.

__How it works__:

- `gh-clone*` scripts use the Github v3 API to download discourse information.
  + Issues
    + Issue comments, with reactions
    + Issue events
  + Pull Requests
    + PR comments, with reactions
    + PR reviews
      + PR review comments
    + PR events
  + Repo Events
    + Includes Issues and PRs (which can possibly record events in duplicate, where they will exist in the .gh-issue dir under an issue, and also under .gh-events).
      > I use this with creative freedom to not care about duplicate data, but in prioritizing a FULL PICTURE. For example, if a label is added to an issue, that doesn't necessarily show up in the issue events (as scripted) unless the Issue itself actually changes (since we only process updated Issues, instead of having to process them all all the time.)
      
- `scribe.sh` is the "manager" script, and calls the `gh-clone*` scripts and some trivial repository state management.

You can either use these as one-off scripts, or list them as a cron job, or whatever.

These are adhoc, and not intended to be super robust (or well coded), but are [a working proof-of-concept for my own personal use](https://github.com/meowsbits/ECIPs/tree/gh).

