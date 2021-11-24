[flute,fs_flute]=audioread('/Users/kushgulati/Box Sync/Junior Year/BME271/BME271Project/flute-C4.wav');
[piano,fs_piano]=audioread('/Users/kushgulati/Box Sync/Junior Year/BME271/BME271Project/piano-C4.wav');
[trumpet,fs_trumpet] = audioread('/Users/kushgulati/Box Sync/Junior Year/BME271/BME271Project/trumpet-C4.wav');
[violin, fs_violin] = audioread('/Users/kushgulati/Box Sync/Junior Year/BME271/BME271Project/violin-C4.wav');
t_flute = (0:1/fs_flute:(length(flute)-1)/fs_flute);
t_piano = (0:1/fs_piano:(length(piano)-1)/fs_piano);
t_trumpet = (0:1/fs_piano:(length(trumpet)-1)/fs_trumpet);
t_violin = (0:1/fs_piano:(length(violin)-1)/fs_violin);