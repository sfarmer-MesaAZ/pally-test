require('dotenv').config({
  path: process.env.dotenv_config_path
});

module.exports = {
  url: `${process.env.BASE_URL}/`,
  actions: [
    `set field input[name=user-name] to ${process.env.USERNAME}`,
    `set field input[name=password] to ${process.env.PASSWORD}`,
    'click element input[name=login-button]',
    'wait for element div[class="app_logo"] to be visible',
  ]
}