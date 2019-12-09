const {classes: Cc, interfaces: Ci} = Components

const mpv_path = '/usr/bin/mpv'
const mpv_options = '' //'--video-unscaled=yes'

vimfx.addCommand({
  name: 'play_with_mpv',
  description: 'Play the focused link with MPV'
}, ({vim}) => {
  vimfx.send(vim, 'getCurrentHref', null, url => {
    let file = Cc['@mozilla.org/file/local;1'].createInstance(Ci.nsIFile)
    file.initWithPath(mpv_path)

    let process = Cc['@mozilla.org/process/util;1'].createInstance(Ci.nsIProcess)
    process.init(file)

    let args = mpv_options.split(' ')

    if (url.includes('youtube.com')) {
      // Parse url params to an object like:
      // {"v":"g04s2u30NfQ","index":"3","list":"PL58H4uS5fMRzmMC_SfMelnCoHgB8COa5r"}
      let qs = (function(a) {
        if (a == '') return {}
        let b = {}
        for (let i = 0; i < a.length; ++i) {
          let p = a[i].split('=', 2)
          if (p.length == 1) {
            b[p[0]] = ''
          } else {
            b[p[0]] = decodeURIComponent(p[1].replace(/\+/g, ' '))
          }
        }
        return b
      })(url.substr(1).split('&'))

      if (qs['list'] && qs['index']) {
        // Example args: ['--video-unscaled=yes', '--ytdl-raw-options=format=best']
        // So check for ytdl-raw-options.
        let ytdlRawOptionsIndex = -1
        for (let i = 0; i < args.length; i++) {
          if (args[i].includes('ytdl-raw-options')) {
            ytdlRawOptionsIndex = i
            break
          }
        }

        if (ytdlRawOptionsIndex > -1) {
            args[ytdlRawOptionsIndex] += `,yes-playlist=,playlist-start=${qs['index']}`
        } else {
            args.push(`--ytdl-raw-options=yes-playlist=,playlist-start=${qs['index']}`)
        }
      }
    }

    args.push(url)

    // process.run(false, args, args.length)
    process.runAsync(args, args.length)
  })
})
vimfx.set('custom.mode.normal.play_with_mpv', 'b')
