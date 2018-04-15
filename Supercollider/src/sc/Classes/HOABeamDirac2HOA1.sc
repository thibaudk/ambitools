HOABeamDirac2HOA1 : MultiOutUGen
{
  *ar { | in1, in2, in3, in4, timer_manual(0.0), focus(0.0), on(0.0), crossfade(1.0), gain(0.0), azimuth(0.0), elevation(0.0) |
      ^this.multiNew('audio', in1, in2, in3, in4, timer_manual, focus, on, crossfade, gain, azimuth, elevation)
  }

  *kr { | in1, in2, in3, in4, timer_manual(0.0), focus(0.0), on(0.0), crossfade(1.0), gain(0.0), azimuth(0.0), elevation(0.0) |
      ^this.multiNew('control', in1, in2, in3, in4, timer_manual, focus, on, crossfade, gain, azimuth, elevation)
  } 

  checkInputs {
    if (rate == 'audio', {
      4.do({|i|
        if (inputs.at(i).rate != 'audio', {
          ^(" input at index " + i + "(" + inputs.at(i) + 
            ") is not audio rate");
        });
      });
    });
    ^this.checkValidInputs
  }

  init { | ... theInputs |
      inputs = theInputs
      ^this.initOutputs(4, rate)
  }

  name { ^"HOABeamDirac2HOA1" }


  info { ^"Generated with Faust" }
}

