var readline = require('readline'),
    fs = require('fs');
var LinkMap = function (filePath) {
    this.files = []
    this.filePath = filePath
}
LinkMap.prototype = {
    start: function (cb) {
        var self = this
        var rl = readline.createInterface({
            input: fs.createReadStream(self.filePath),
            output: process.stdout,
            terminal: false
        });
        var currParser = "";
        rl.on('line', function (line) {
            if (line[0] == '#') {
                if (line.indexOf('Object files') > -1) {
                    currParser = "_parseFiles";
                } else if (line.indexOf('Sections') > -1) {
                    currParser = "_parseSection";
                } else if (line.indexOf('Symbols') > -1) {
                    currParser = "_parseSymbols";
                }
                return;
            }
            if (self[currParser]) {
                self[currParser](line)
            }
        });
        rl.on('close', function (line) {
            cb(self)
        });
    },
    _parseFiles: function (line) {
        var arr = line.split(']')
        if (arr.length > 1) {
            var idx = Number(arr[0].replace('[', ''));
            var file = arr[1].split('/').pop().trim()
            this.files[idx] = {
                name: file,
                size: 0
            }
        }
    },
    _parseSection: function (line) {
    },
    _parseSymbols: function (line) {
        var arr = line.split('\t')
        if (arr.length > 2) {
            var size = parseInt(arr[1], 16)
            var idx = Number(arr[2].split(']')[0].replace('[', ''))
            if (idx && this.files[idx]) {
                this.files[idx].size += size;
            }
        }
    },
    _formatSize: function (size) {
        if (size > 1024 * 1024) return (size / (1024 * 1024)).toFixed(2) + "MB"
        if (size > 1024) return (size / 1024).toFixed(2) + "KB"
        return size + "B"
    },
    statLibs: function (h) {
        var libs = {}
        var files = this.files;
        var self = this;
        for (var i in files) {
            var file = files[i]
            var libName
            if (file.name.indexOf('.o)') > -1) {
                libName = file.name.split('(')[0]
            } else {
                libName = file.name
            }
            if (!libs[libName]) {
                libs[libName] = 0
            }
            libs[libName] += file.size
        }
        var i = 0, sortLibs = []
        for (var name in libs) {
            sortLibs[i++] = {
                name: name,
                size: libs[name]
            }
        }
        sortLibs.sort(function (a, b) {
            return a.size > b.size ? -1 : 1
        })
        if (h) {
            sortLibs.map(function (o) {
                o.size = self._formatSize(o.size)
            })
        }
        return sortLibs
    },
    statFiles: function (h) {
        var self = this
        self.files.sort(function (a, b) {
            return a.size > b.size ? -1 : 1
        })
        if (h) {
            self.files.map(function (o) {
                o.size = self._formatSize(o.size)
            })
        }
        return this.files
    }
}
if (!process.argv[2]) {
    console.log('usage: node linkmap.js filepath -hl')
    console.log('-h: format size')
    console.log('-l: stat libs')
    return
}
var isStatLib, isFomatSize
var opts = process.argv[3];
if (opts && opts[0] == '-') {
    if (opts.indexOf('h') > -1) isFomatSize = true
    if (opts.indexOf('l') > -1) isStatLib = true
}
var linkmap = new LinkMap(process.argv[2])
linkmap.start(function () {
    var ret = isStatLib ? linkmap.statLibs(isFomatSize)
        : linkmap.statFiles(isFomatSize)
    console.log("| 文件" + "|" + "size|")
    console.log("|---" + "|" + "---|")
    for (var i in ret) {
        console.log("|" + ret[i].name + "|" + ret[i].size + "|")
    }
})

//调用: node linkMap.js linkMap.txt -hl  > linkMap.md
