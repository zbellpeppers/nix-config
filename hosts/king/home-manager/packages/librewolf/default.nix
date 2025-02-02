{...}: {
  programs.librewolf = {
    enable = true;
    # settings = {
    #   # FASTFOX
    #   "browser.sessionstore.restore_pinned_tabs_on_demand" = true;
    #   "browser.sessionhistory.max_total_viewers" = 4;
    #   "browser.cache.disk.enable" = false;
    #   "network.http.max-persistent-connections-per-server" = 20;

    #   # SECUREFOX
    #   "signon.rememberSignons" = false;
    #   "extensions.formautofill.addresses.enabled" = false;
    #   "extensions.formautofill.creditCards.enabled" = false;
    #   "browser.urlbar.suggest.recentsearches" = false;
    #   "browser.urlbar.showSearchSuggestionsFirst" = false;
    #   "signon.management.page.breach-alerts.enabled" = false;
    #   "signon.autofillForms" = false;
    #   "signon.generation.enabled" = false;
    #   "signon.firefoxRelay.feature" = "";
    #   "browser.safebrowsing.downloads.enabled" = false;
    #   "browser.safebrowsing.downloads.remote.url" = "";
    #   "browser.safebrowsing.downloads.remote.block_potentially_unwanted" = false;
    #   "browser.safebrowsing.downloads.remote.block_uncommon" = false;
    #   "browser.safebrowsing.allowOverride" = false;
    #   "browser.search.update" = false;
    #   "network.trr.confirmationNS" = "skip";
    #   "extensions.webextensions.restrictedDomains" = "";
    #   "identity.fxaccounts.enabled" = false;
    #   "browser.firefox-view.feature-tour" = "{\"screen\":\"\",\"complete\":true}";
    #   "accessibility.force_disabled" = 1;
    #   "security.cert_pinning.enforcement_level" = 2;

    #   # PESKYFOX
    #   "cookiebanners.service.mode" = 0;
    #   "cookiebanners.service.mode.privateBrowsing" = 0;
    #   "devtools.accessibility.enabled" = false;
    #   "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
    #   "browser.newtabpage.activity-stream.showSponsored" = false;
    #   "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" = false;
    #   "browser.newtabpage.activity-stream.section.highlights.includeDownloads" = false;
    #   "browser.newtabpage.activity-stream.section.highlights.includeVisited" = false;
    #   "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
    #   "browser.toolbars.bookmarks.visibility" = "never";
    #   "browser.startup.homepage_override.mstone" = "ignore";
    #   "browser.urlbar.suggest.history" = false;
    #   "browser.urlbar.suggest.bookmark" = false;
    #   "browser.urlbar.suggest.openpage" = false;
    #   "browser.urlbar.suggest.topsites" = false;
    #   "browser.urlbar.suggest.engines" = false;
    #   "browser.urlbar.quicksuggest.enabled" = false;
    #   "browser.bookmarks.max_backups" = 0;
    #   "view_source.wrap_long_lines" = true;
    #   "devtools.debugger.ui.editor-wrapping" = true;
    #   "browser.zoom.full" = false;
    #   "pdfjs.sidebarViewOnLoad" = 2;
    #   "layout.word_select.eat_space_to_next_word" = false;
    #   "browser.tabs.loadBookmarksInTabs" = true;
    #   "ui.key.menuAccessKey" = 0;
    #   "general.autoScroll" = false;
    #   "ui.SpellCheckerUnderlineStyle" = 1;
    #   "media.videocontrols.picture-in-picture.display-text-tracks.size" = "small";
    #   "media.videocontrols.picture-in-picture.urlbar-button.enabled" = false;
    #   "reader.parse-on-load.enabled" = false;
    # };
  };
}
