module.exports = {
  launch_url: "https://www.saucedemo.com",
  src_folders: "tests",
  reports_path: "reports",
  reporter: ["json", "html"],
  test_settings: {
    runners: [
      'axe',
      'htmlcs'
    ],
    standard: 'WCAG2A',
    timeout: 120000,
    includeNotices: true,
    includeWarnings: true
  },
  puppeteer_settings: {
    headless: false,
    executablePath: '/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome'
  }
};
