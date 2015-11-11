declare name        "HOA Decoder up to order 5 for a 50 nodes Lebedev grid";
declare version     "1.0";
declare author      "Pierre Lecomte";
declare license     "GPL";
declare copyright   "(c) Pierre Lecomte 2014";

import("music.lib");
import("math.lib");

// bus with gains
gain(c) = R(c) with {
  R((c,cl)) = R(c),R(cl);
  R(1)      = _;
  R(0)      = !;
  //R(0)      = !:0; // if you need to preserve the number of outputs
  R(float(0)) = R(0);
  R(float(1)) = R(1)*vol;
  R(c)      = *(c)*vol;
};

smooth(c)       = *(1-c) : +~*(c);
vmeter(x)		= attach(x, envelop(x) : vbargraph("[unit:dB]", -100, 10));
envelop			= abs : max(db2linear(-100)) : linear2db : min(10)  : max ~ -(80.0/SR);
vol             = hslider("Volume Amplifier (dB)", 0, -10, 60, 0.1) : db2linear : smooth(0.999);

id(x,delta) =  vgroup("%2a",vmeter) with{
a = x+1+delta;};

idmute(x,delta) =  vgroup("%2a",_*(1-checkbox("Mute")):vmeter) with{
a = x+1+delta;};

meterm(m) = par(i,2*m+1,hgroup("%m",_*(1-checkbox("Mute")):idmute(i,0)));

matrix(n,m) = hgroup("B-Format",meterm(0),meterm(1),meterm(2),meterm(3),meterm(4),meterm(5))<:par(i,m,gain(a(i)):>hgroup("Outputs",id(i,0)));

//matrix(n,m) = hgroup("Inputs",par(i,n,vgroup("%2i", vmeter*(1-checkbox("Mute")))))<:par(i,m,gain(a(i)):>hgroup("Outputs",id(i,0)));


a(0)=(0.0126984, 0, 0, 0.0219943, 0, 0, 0, 0, 0.0283945, 0, 0, 0, 0, 0, 0, 0.0335968, 0, 0, 0, 0, 0, 0, 0, 0, 0.0380952, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.0421159);

a(1)=(0.0126984, 0.0219943, 0, 0, 0.0245904, 0, 0, 0, -0.0141973, 0.0265606, 0, 0, 0, -0.0205738, 0, 0, 0.0281718, 0, 0, 0, -0.0212959, 0, 0, 0, 0.0142857, 0.0295468, 0, 0, 0, -0.0220229, 0, 0, 0, 0.0203893, 0, 0);

a(2)=(0.0126984, 0, 0.0219943, 0, -0.0245904, 0, 0, 0, -0.0141973, 0, -0.0265606, 0, 0, 0, -0.0205738, 0, 0.0281718, 0, 0, 0, 0.0212959, 0, 0, 0, 0.0142857, 0, 0.0295468, 0, 0, 0, 0.0220229, 0, 0, 0, 0.0203893, 0);

a(3)=(0.0126984, -0.0219943, 0, 0, 0.0245904, 0, 0, 0, -0.0141973, -0.0265606, 0, 0, 0, 0.0205738, 0, 0, 0.0281718, 0, 0, 0, -0.0212959, 0, 0, 0, 0.0142857, -0.0295468, 0, 0, 0, 0.0220229, 0, 0, 0, -0.0203893, 0, 0);

a(4)=(0.0126984, 0, -0.0219943, 0, -0.0245904, 0, 0, 0, -0.0141973, 0, 0.0265606, 0, 0, 0, 0.0205738, 0, 0.0281718, 0, 0, 0, 0.0212959, 0, 0, 0, 0.0142857, 0, -0.0295468, 0, 0, 0, -0.0220229, 0, 0, 0, -0.0203893, 0);

a(5)=(0.0126984, 0, 0, -0.0219943, 0, 0, 0, 0, 0.0283945, 0, 0, 0, 0, 0, 0, -0.0335968, 0, 0, 0, 0, 0, 0, 0, 0, 0.0380952, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -0.0421159);

a(6)=(0.022575, 0.0276486, 0, 0.0276486, 0.0218581, 0, 0.0437162, 0, 0.0126198, 0.0166944, 0, 0.0408928, 0, 0.0387943, 0, -0.0105585, 0.0125208, 0, 0.0354142, 0, 0.0473242, 0, 0.0133853, 0, -0.0275132, 0.00928568, 0, 0.0293639, 0, 0.0484479, 0, 0.0339065, 0, -0.0192232, 0, -0.0281259);

a(7)=(0.022575, 0, 0.0276486, 0.0276486, -0.0218581, 0, 0, 0.0437162, 0.0126198, 0, -0.0166944, -0.0408928, 0, 0, 0.0387943, -0.0105585, 0.0125208, 0, 0, -0.0354142, -0.0473242, 0, 0, 0.0133853, -0.0275132, 0, 0.00928568, 0.0293639, 0, 0, -0.0484479, -0.0339065, 0, 0, -0.0192232, -0.0281259);

a(8)=(0.022575, -0.0276486, 0, 0.0276486, 0.0218581, 0, -0.0437162, 0, 0.0126198, -0.0166944, 0, 0.0408928, 0, -0.0387943, 0, -0.0105585, 0.0125208, 0, -0.0354142, 0, 0.0473242, 0, -0.0133853, 0, -0.0275132, -0.00928568, 0, 0.0293639, 0, -0.0484479, 0, 0.0339065, 0, 0.0192232, 0, -0.0281259);

a(9)=(0.022575, 0, -0.0276486, 0.0276486, -0.0218581, 0, 0, -0.0437162, 0.0126198, 0, 0.0166944, -0.0408928, 0, 0, -0.0387943, -0.0105585, 0.0125208, 0, 0, 0.0354142, -0.0473242, 0, 0, -0.0133853, -0.0275132, 0, -0.00928568, 0.0293639, 0, 0, 0.0484479, -0.0339065, 0, 0, 0.0192232, -0.0281259);

a(10)=(0.022575, 0.0276486, 0.0276486, 0, 0, 0.0437162, 0, 0, -0.0252396, -0.0333888, 0.0333888, 0, 0, -0.0258629, -0.0258629, 0, -0.0500832, 0, 0, 0, 0, -0.0378594, 0, 0, 0.0253968, -0.0371427, -0.0371427, 0, 0, 0.0276845, -0.0276845, 0, 0, 0.0256309, 0.0256309, 0);

a(11)=(0.022575, -0.0276486, 0.0276486, 0, 0, -0.0437162, 0, 0, -0.0252396, 0.0333888, 0.0333888, 0, 0, 0.0258629, -0.0258629, 0, -0.0500832, 0, 0, 0, 0, 0.0378594, 0, 0, 0.0253968, 0.0371427, -0.0371427, 0, 0, -0.0276845, -0.0276845, 0, 0, -0.0256309, 0.0256309, 0);

a(12)=(0.022575, -0.0276486, -0.0276486, 0, 0, 0.0437162, 0, 0, -0.0252396, 0.0333888, -0.0333888, 0, 0, 0.0258629, 0.0258629, 0, -0.0500832, 0, 0, 0, 0, -0.0378594, 0, 0, 0.0253968, 0.0371427, 0.0371427, 0, 0, -0.0276845, 0.0276845, 0, 0, -0.0256309, -0.0256309, 0);

a(13)=(0.022575, 0.0276486, -0.0276486, 0, 0, -0.0437162, 0, 0, -0.0252396, -0.0333888, -0.0333888, 0, 0, -0.0258629, 0.0258629, 0, -0.0500832, 0, 0, 0, 0, 0.0378594, 0, 0, 0.0253968, -0.0371427, 0.0371427, 0, 0, 0.0276845, 0.0276845, 0, 0, 0.0256309, -0.0256309, 0);

a(14)=(0.022575, 0.0276486, 0, -0.0276486, 0.0218581, 0, -0.0437162, 0, 0.0126198, 0.0166944, 0, -0.0408928, 0, 0.0387943, 0, 0.0105585, 0.0125208, 0, -0.0354142, 0, 0.0473242, 0, -0.0133853, 0, -0.0275132, 0.00928568, 0, -0.0293639, 0, 0.0484479, 0, -0.0339065, 0, -0.0192232, 0, 0.0281259);

a(15)=(0.022575, 0, 0.0276486, -0.0276486, -0.0218581, 0, 0, -0.0437162, 0.0126198, 0, -0.0166944, 0.0408928, 0, 0, 0.0387943, 0.0105585, 0.0125208, 0, 0, 0.0354142, -0.0473242, 0, 0, -0.0133853, -0.0275132, 0, 0.00928568, -0.0293639, 0, 0, -0.0484479, 0.0339065, 0, 0, -0.0192232, 0.0281259);

a(16)=(0.022575, -0.0276486, 0, -0.0276486, 0.0218581, 0, 0.0437162, 0, 0.0126198, -0.0166944, 0, -0.0408928, 0, -0.0387943, 0, 0.0105585, 0.0125208, 0, 0.0354142, 0, 0.0473242, 0, 0.0133853, 0, -0.0275132, -0.00928568, 0, -0.0293639, 0, -0.0484479, 0, -0.0339065, 0, 0.0192232, 0, 0.0281259);

a(17)=(0.022575, 0, -0.0276486, -0.0276486, -0.0218581, 0, 0, 0.0437162, 0.0126198, 0, 0.0166944, 0.0408928, 0, 0, -0.0387943, 0.0105585, 0.0125208, 0, 0, -0.0354142, -0.0473242, 0, 0, 0.0133853, -0.0275132, 0, -0.00928568, -0.0293639, 0, 0, 0.0484479, 0.0339065, 0, 0, 0.0192232, 0.0281259);

a(18)=(0.0210938, 0.0210938, 0.0210938, 0.0210938, 0, 0.0272319, 0.0272319, 0.0272319, 0, -0.0169821, 0.0169821, 0, 0.0415974, 0.0131543, 0.0131543, -0.0214808, -0.0207987, 0, -0.0294138, 0.0294138, 0, 0.0314447, -0.0111174, -0.0111174, -0.0246094, -0.0125942, -0.0125942, -0.0398265, 0, -0.0281616, 0.0281616, 0, 0, -0.0260726, -0.0260726, -0.00673191);

a(19)=(0.0210938, -0.0210938, 0.0210938, 0.0210938, 0, -0.0272319, -0.0272319, 0.0272319, 0, 0.0169821, 0.0169821, 0, -0.0415974, -0.0131543, 0.0131543, -0.0214808, -0.0207987, 0, 0.0294138, 0.0294138, 0, -0.0314447, 0.0111174, -0.0111174, -0.0246094, 0.0125942, -0.0125942, -0.0398265, 0, 0.0281616, 0.0281616, 0, 0, 0.0260726, -0.0260726, -0.00673191);

a(20)=(0.0210938, -0.0210938, -0.0210938, 0.0210938, 0, 0.0272319, -0.0272319, -0.0272319, 0, 0.0169821, -0.0169821, 0, 0.0415974, -0.0131543, -0.0131543, -0.0214808, -0.0207987, 0, 0.0294138, -0.0294138, 0, 0.0314447, 0.0111174, 0.0111174, -0.0246094, 0.0125942, 0.0125942, -0.0398265, 0, 0.0281616, -0.0281616, 0, 0, 0.0260726, 0.0260726, -0.00673191);

a(21)=(0.0210938, 0.0210938, -0.0210938, 0.0210938, 0, -0.0272319, 0.0272319, -0.0272319, 0, -0.0169821, -0.0169821, 0, -0.0415974, 0.0131543, -0.0131543, -0.0214808, -0.0207987, 0, -0.0294138, -0.0294138, 0, -0.0314447, -0.0111174, 0.0111174, -0.0246094, -0.0125942, 0.0125942, -0.0398265, 0, -0.0281616, -0.0281616, 0, 0, -0.0260726, 0.0260726, -0.00673191);

a(22)=(0.0210938, 0.0210938, 0.0210938, -0.0210938, 0, 0.0272319, -0.0272319, -0.0272319, 0, -0.0169821, 0.0169821, 0, -0.0415974, 0.0131543, 0.0131543, 0.0214808, -0.0207987, 0, 0.0294138, -0.0294138, 0, 0.0314447, 0.0111174, 0.0111174, -0.0246094, -0.0125942, -0.0125942, 0.0398265, 0, -0.0281616, 0.0281616, 0, 0, -0.0260726, -0.0260726, 0.00673191);

a(23)=(0.0210938, -0.0210938, 0.0210938, -0.0210938, 0, -0.0272319, 0.0272319, -0.0272319, 0, 0.0169821, 0.0169821, 0, 0.0415974, -0.0131543, 0.0131543, 0.0214808, -0.0207987, 0, -0.0294138, -0.0294138, 0, -0.0314447, -0.0111174, 0.0111174, -0.0246094, 0.0125942, -0.0125942, 0.0398265, 0, 0.0281616, 0.0281616, 0, 0, 0.0260726, -0.0260726, 0.00673191);

a(24)=(0.0210938, -0.0210938, -0.0210938, -0.0210938, 0, 0.0272319, 0.0272319, 0.0272319, 0, 0.0169821, -0.0169821, 0, -0.0415974, -0.0131543, -0.0131543, 0.0214808, -0.0207987, 0, -0.0294138, 0.0294138, 0, 0.0314447, -0.0111174, -0.0111174, -0.0246094, 0.0125942, 0.0125942, 0.0398265, 0, 0.0281616, -0.0281616, 0, 0, 0.0260726, 0.0260726, 0.00673191);

a(25)=(0.0210938, 0.0210938, -0.0210938, -0.0210938, 0, -0.0272319, -0.0272319, 0.0272319, 0, -0.0169821, -0.0169821, 0, 0.0415974, 0.0131543, -0.0131543, 0.0214808, -0.0207987, 0, 0.0294138, 0.0294138, 0, -0.0314447, 0.0111174, -0.0111174, -0.0246094, -0.0125942, 0.0125942, 0.0398265, 0, -0.0281616, -0.0281616, 0, 0, -0.0260726, 0.0260726, 0.00673191);

a(26)=(0.0201733, 0.0105352, 0.0105352, 0.0316055, 0, 0.00710282, 0.0213085, 0.0213085, 0.0328065, -0.00231317, 0.00231317, 0, 0.0169983, 0.0304602, 0.0304602, 0.0263336, -0.00147951, 0, -0.00627703, 0.00627703, 0, 0.0290785, 0.0355874, 0.0355874, 0.0142547, -0.000467862, -0.000467862, -0.00443853, 0, -0.0122053, 0.0122053, 0, 0.0410014, 0.0351912, 0.0351912, -0.000750248);

a(27)=(0.0201733, -0.0105352, 0.0105352, 0.0316055, 0, -0.00710282, -0.0213085, 0.0213085, 0.0328065, 0.00231317, 0.00231317, 0, -0.0169983, -0.0304602, 0.0304602, 0.0263336, -0.00147951, 0, 0.00627703, 0.00627703, 0, -0.0290785, -0.0355874, 0.0355874, 0.0142547, 0.000467862, -0.000467862, -0.00443853, 0, 0.0122053, 0.0122053, 0, -0.0410014, -0.0351912, 0.0351912, -0.000750248);

a(28)=(0.0201733, -0.0105352, -0.0105352, 0.0316055, 0, 0.00710282, -0.0213085, -0.0213085, 0.0328065, 0.00231317, -0.00231317, 0, 0.0169983, -0.0304602, -0.0304602, 0.0263336, -0.00147951, 0, 0.00627703, -0.00627703, 0, 0.0290785, -0.0355874, -0.0355874, 0.0142547, 0.000467862, 0.000467862, -0.00443853, 0, 0.0122053, -0.0122053, 0, 0.0410014, -0.0351912, -0.0351912, -0.000750248);

a(29)=(0.0201733, 0.0105352, -0.0105352, 0.0316055, 0, -0.00710282, 0.0213085, -0.0213085, 0.0328065, -0.00231317, -0.00231317, 0, -0.0169983, 0.0304602, -0.0304602, 0.0263336, -0.00147951, 0, -0.00627703, -0.00627703, 0, -0.0290785, 0.0355874, -0.0355874, 0.0142547, -0.000467862, 0.000467862, -0.00443853, 0, -0.0122053, -0.0122053, 0, -0.0410014, 0.0351912, -0.0351912, -0.000750248);

a(30)=(0.0201733, 0.0316055, 0.0105352, 0.0105352, 0.0284113, 0.0213085, 0.0213085, 0.00710282, -0.0164033, 0.0208185, 0.0300712, 0.0226644, 0.0169983, -0.016126, -0.00537532, -0.0204817, 0.0103566, 0.0355082, 0.0188311, 0.0272004, -0.00894723, -0.00671042, -0.0308424, -0.0102808, 0.00425141, -0.00140359, 0.0369611, 0.0103566, 0.0355082, -0.00313851, -0.00453341, -0.0273342, -0.0205007, -0.0029057, -0.000968566, 0.023091);

a(31)=(0.0201733, 0.0105352, 0.0316055, 0.0105352, -0.0284113, 0.0213085, 0.00710282, 0.0213085, -0.0164033, -0.0300712, -0.0208185, -0.0226644, 0.0169983, -0.00537532, -0.016126, -0.0204817, 0.0103566, -0.0355082, -0.0272004, -0.0188311, 0.00894723, -0.00671042, -0.0102808, -0.0308424, 0.00425141, 0.0369611, -0.00140359, 0.0103566, -0.0355082, 0.00453341, 0.00313851, 0.0273342, -0.0205007, -0.000968566, -0.0029057, 0.023091);

a(32)=(0.0201733, -0.0105352, 0.0316055, 0.0105352, -0.0284113, -0.0213085, -0.00710282, 0.0213085, -0.0164033, 0.0300712, -0.0208185, -0.0226644, -0.0169983, 0.00537532, -0.016126, -0.0204817, 0.0103566, 0.0355082, 0.0272004, -0.0188311, 0.00894723, 0.00671042, 0.0102808, -0.0308424, 0.00425141, -0.0369611, -0.00140359, 0.0103566, 0.0355082, -0.00453341, 0.00313851, 0.0273342, 0.0205007, 0.000968566, -0.0029057, 0.023091);

a(33)=(0.0201733, -0.0316055, 0.0105352, 0.0105352, 0.0284113, -0.0213085, -0.0213085, 0.00710282, -0.0164033, -0.0208185, 0.0300712, 0.0226644, -0.0169983, 0.016126, -0.00537532, -0.0204817, 0.0103566, -0.0355082, -0.0188311, 0.0272004, -0.00894723, 0.00671042, 0.0308424, -0.0102808, 0.00425141, 0.00140359, 0.0369611, 0.0103566, -0.0355082, 0.00313851, -0.00453341, -0.0273342, 0.0205007, 0.0029057, -0.000968566, 0.023091);

a(34)=(0.0201733, -0.0316055, -0.0105352, 0.0105352, 0.0284113, 0.0213085, -0.0213085, -0.00710282, -0.0164033, -0.0208185, -0.0300712, 0.0226644, 0.0169983, 0.016126, 0.00537532, -0.0204817, 0.0103566, 0.0355082, -0.0188311, -0.0272004, -0.00894723, -0.00671042, 0.0308424, 0.0102808, 0.00425141, 0.00140359, -0.0369611, 0.0103566, 0.0355082, 0.00313851, 0.00453341, -0.0273342, -0.0205007, 0.0029057, 0.000968566, 0.023091);

a(35)=(0.0201733, -0.0105352, -0.0316055, 0.0105352, -0.0284113, 0.0213085, -0.00710282, -0.0213085, -0.0164033, 0.0300712, 0.0208185, -0.0226644, 0.0169983, 0.00537532, 0.016126, -0.0204817, 0.0103566, -0.0355082, 0.0272004, 0.0188311, 0.00894723, -0.00671042, 0.0102808, 0.0308424, 0.00425141, -0.0369611, 0.00140359, 0.0103566, -0.0355082, -0.00453341, -0.00313851, 0.0273342, -0.0205007, 0.000968566, 0.0029057, 0.023091);

a(36)=(0.0201733, 0.0105352, -0.0316055, 0.0105352, -0.0284113, -0.0213085, 0.00710282, -0.0213085, -0.0164033, -0.0300712, 0.0208185, -0.0226644, -0.0169983, -0.00537532, 0.016126, -0.0204817, 0.0103566, 0.0355082, -0.0272004, 0.0188311, 0.00894723, 0.00671042, -0.0102808, 0.0308424, 0.00425141, 0.0369611, 0.00140359, 0.0103566, 0.0355082, 0.00453341, -0.00313851, 0.0273342, 0.0205007, -0.000968566, 0.0029057, 0.023091);

a(37)=(0.0201733, 0.0316055, -0.0105352, 0.0105352, 0.0284113, -0.0213085, 0.0213085, -0.00710282, -0.0164033, 0.0208185, -0.0300712, 0.0226644, -0.0169983, -0.016126, 0.00537532, -0.0204817, 0.0103566, -0.0355082, 0.0188311, -0.0272004, -0.00894723, 0.00671042, -0.0308424, 0.0102808, 0.00425141, -0.00140359, -0.0369611, 0.0103566, -0.0355082, -0.00313851, 0.00453341, -0.0273342, 0.0205007, -0.0029057, 0.000968566, 0.023091);

a(38)=(0.0201733, 0.0316055, 0.0105352, -0.0105352, 0.0284113, 0.0213085, -0.0213085, -0.00710282, -0.0164033, 0.0208185, 0.0300712, -0.0226644, -0.0169983, -0.016126, -0.00537532, 0.0204817, 0.0103566, 0.0355082, -0.0188311, -0.0272004, -0.00894723, -0.00671042, 0.0308424, 0.0102808, 0.00425141, -0.00140359, 0.0369611, -0.0103566, -0.0355082, -0.00313851, -0.00453341, 0.0273342, 0.0205007, -0.0029057, -0.000968566, -0.023091);

a(39)=(0.0201733, 0.0105352, 0.0316055, -0.0105352, -0.0284113, 0.0213085, -0.00710282, -0.0213085, -0.0164033, -0.0300712, -0.0208185, 0.0226644, -0.0169983, -0.00537532, -0.016126, 0.0204817, 0.0103566, -0.0355082, 0.0272004, 0.0188311, 0.00894723, -0.00671042, 0.0102808, 0.0308424, 0.00425141, 0.0369611, -0.00140359, -0.0103566, 0.0355082, 0.00453341, 0.00313851, -0.0273342, 0.0205007, -0.000968566, -0.0029057, -0.023091);

a(40)=(0.0201733, -0.0105352, 0.0316055, -0.0105352, -0.0284113, -0.0213085, 0.00710282, -0.0213085, -0.0164033, 0.0300712, -0.0208185, 0.0226644, 0.0169983, 0.00537532, -0.016126, 0.0204817, 0.0103566, 0.0355082, -0.0272004, 0.0188311, 0.00894723, 0.00671042, -0.0102808, 0.0308424, 0.00425141, -0.0369611, -0.00140359, -0.0103566, -0.0355082, -0.00453341, 0.00313851, -0.0273342, -0.0205007, 0.000968566, -0.0029057, -0.023091);

a(41)=(0.0201733, -0.0316055, 0.0105352, -0.0105352, 0.0284113, -0.0213085, 0.0213085, -0.00710282, -0.0164033, -0.0208185, 0.0300712, -0.0226644, 0.0169983, 0.016126, -0.00537532, 0.0204817, 0.0103566, -0.0355082, 0.0188311, -0.0272004, -0.00894723, 0.00671042, -0.0308424, 0.0102808, 0.00425141, 0.00140359, 0.0369611, -0.0103566, 0.0355082, 0.00313851, -0.00453341, 0.0273342, -0.0205007, 0.0029057, -0.000968566, -0.023091);

a(42)=(0.0201733, -0.0316055, -0.0105352, -0.0105352, 0.0284113, 0.0213085, 0.0213085, 0.00710282, -0.0164033, -0.0208185, -0.0300712, -0.0226644, -0.0169983, 0.016126, 0.00537532, 0.0204817, 0.0103566, 0.0355082, 0.0188311, 0.0272004, -0.00894723, -0.00671042, -0.0308424, -0.0102808, 0.00425141, 0.00140359, -0.0369611, -0.0103566, -0.0355082, 0.00313851, 0.00453341, 0.0273342, 0.0205007, 0.0029057, 0.000968566, -0.023091);

a(43)=(0.0201733, -0.0105352, -0.0316055, -0.0105352, -0.0284113, 0.0213085, 0.00710282, 0.0213085, -0.0164033, 0.0300712, 0.0208185, 0.0226644, -0.0169983, 0.00537532, 0.016126, 0.0204817, 0.0103566, -0.0355082, -0.0272004, -0.0188311, 0.00894723, -0.00671042, -0.0102808, -0.0308424, 0.00425141, -0.0369611, 0.00140359, -0.0103566, 0.0355082, -0.00453341, -0.00313851, -0.0273342, 0.0205007, 0.000968566, 0.0029057, -0.023091);

a(44)=(0.0201733, 0.0105352, -0.0316055, -0.0105352, -0.0284113, -0.0213085, -0.00710282, 0.0213085, -0.0164033, -0.0300712, 0.0208185, 0.0226644, 0.0169983, -0.00537532, 0.016126, 0.0204817, 0.0103566, 0.0355082, 0.0272004, -0.0188311, 0.00894723, 0.00671042, 0.0102808, -0.0308424, 0.00425141, 0.0369611, 0.00140359, -0.0103566, -0.0355082, 0.00453341, -0.00313851, -0.0273342, -0.0205007, -0.000968566, 0.0029057, -0.023091);

a(45)=(0.0201733, 0.0316055, -0.0105352, -0.0105352, 0.0284113, -0.0213085, -0.0213085, 0.00710282, -0.0164033, 0.0208185, -0.0300712, -0.0226644, 0.0169983, -0.016126, 0.00537532, 0.0204817, 0.0103566, -0.0355082, -0.0188311, 0.0272004, -0.00894723, 0.00671042, 0.0308424, -0.0102808, 0.00425141, -0.00140359, -0.0369611, -0.0103566, 0.0355082, -0.00313851, 0.00453341, 0.0273342, -0.0205007, -0.0029057, 0.000968566, -0.023091);

a(46)=(0.0201733, 0.0105352, 0.0105352, -0.0316055, 0, 0.00710282, -0.0213085, -0.0213085, 0.0328065, -0.00231317, 0.00231317, 0, -0.0169983, 0.0304602, 0.0304602, -0.0263336, -0.00147951, 0, 0.00627703, -0.00627703, 0, 0.0290785, -0.0355874, -0.0355874, 0.0142547, -0.000467862, -0.000467862, 0.00443853, 0, -0.0122053, 0.0122053, 0, -0.0410014, 0.0351912, 0.0351912, 0.000750248);

a(47)=(0.0201733, -0.0105352, 0.0105352, -0.0316055, 0, -0.00710282, 0.0213085, -0.0213085, 0.0328065, 0.00231317, 0.00231317, 0, 0.0169983, -0.0304602, 0.0304602, -0.0263336, -0.00147951, 0, -0.00627703, -0.00627703, 0, -0.0290785, 0.0355874, -0.0355874, 0.0142547, 0.000467862, -0.000467862, 0.00443853, 0, 0.0122053, 0.0122053, 0, 0.0410014, -0.0351912, 0.0351912, 0.000750248);

a(48)=(0.0201733, -0.0105352, -0.0105352, -0.0316055, 0, 0.00710282, 0.0213085, 0.0213085, 0.0328065, 0.00231317, -0.00231317, 0, -0.0169983, -0.0304602, -0.0304602, -0.0263336, -0.00147951, 0, -0.00627703, 0.00627703, 0, 0.0290785, 0.0355874, 0.0355874, 0.0142547, 0.000467862, 0.000467862, 0.00443853, 0, 0.0122053, -0.0122053, 0, -0.0410014, -0.0351912, -0.0351912, 0.000750248);

a(49)=(0.0201733, 0.0105352, -0.0105352, -0.0316055, 0, -0.00710282, -0.0213085, 0.0213085, 0.0328065, -0.00231317, -0.00231317, 0, 0.0169983, 0.0304602, -0.0304602, -0.0263336, -0.00147951, 0, 0.00627703, 0.00627703, 0, -0.0290785, -0.0355874, 0.0355874, 0.0142547, -0.000467862, 0.000467862, 0.00443853, 0, -0.0122053, -0.0122053, 0, 0.0410014, 0.0351912, -0.0351912, 0.000750248);

process = matrix(36,50);
