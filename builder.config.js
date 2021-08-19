require('dotenv').config()

const ICONS_DIR = 'asset/icons/'

const windows = {
  win: {
    icon: ICONS_DIR + 'white.ico',
    requestedExecutionLevel: 'highestAvailable',
    target: 'nsis',
    // certificateFile: 'Seonglae.pfx',
    // certificatePassword: process.env.PASS,
    rfc3161TimeStampServer: 'http://timestamp.verisign.com/scripts/timestamp.dll'
  }
}

module.exports = {
  asar: false,
  productName: 'Screencast',
  appId: 'com.seonglae.screencast',
  artifactName: 'Screencast-${version}.${ext}',
  directories: { output: 'build' },
  extraResources: [{ from: './resources/ahk/', to: 'ahk' }],
  files: ['package.json', { from: 'dist/main/', to: 'dist/main/' }, { from: 'dist/renderer', to: 'dist/renderer/' }],
  ...windows
}
