// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'index.dart'; // Imports other custom widgets

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:permission_handler/permission_handler.dart';

class JarvisHtmlWebViewV2 extends StatefulWidget {
  const JarvisHtmlWebViewV2({
    Key? key,
    this.width,
    this.height,
  }) : super(key: key);

  final double? width;
  final double? height;

  @override
  State<JarvisHtmlWebViewV2> createState() => _JarvisHtmlWebViewV2State();
}

class _JarvisHtmlWebViewV2State extends State<JarvisHtmlWebViewV2> {
  bool _micPermissionRequested = false;
  bool _showWebView = false;

  static const String _htmlContent = r'''<!DOCTYPE html>
<html lang="ru">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>JARVIS Assistant | Gemini Live</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@400;500;600;700;900&display=swap" rel="stylesheet">
  <style>
    .voicyfy-page * { margin: 0; padding: 0; box-sizing: border-box; }
    .voicyfy-page { width: 100vw; height: 100vh; overflow: hidden; background: radial-gradient(ellipse at center, #1a2942 0%, #0d1b3a 30%, #0a1f3d 60%, #050b15 100%); display: flex; align-items: center; justify-content: center; position: relative; font-family: 'Orbitron', monospace; }
    #voicyfy-three-canvas { position: absolute; top: 0; left: 0; width: 100%; height: 100%; z-index: 1; opacity: 0; transition: opacity 1s ease; }
    #voicyfy-three-canvas.active { opacity: 1; }
    .voicyfy-page::before { content: ''; position: absolute; top: 50%; left: 50%; width: 200%; height: 200%; transform: translate(-50%, -50%); background: linear-gradient(0deg, transparent 0%, rgba(0, 217, 255, 0.03) 50%, transparent 100%), linear-gradient(45deg, transparent 0%, rgba(0, 217, 255, 0.02) 50%, transparent 100%), linear-gradient(90deg, transparent 0%, rgba(0, 217, 255, 0.03) 50%, transparent 100%), linear-gradient(135deg, transparent 0%, rgba(0, 217, 255, 0.02) 50%, transparent 100%); background-size: 100% 100%; animation: voicyfy-rays-rotate 60s linear infinite; pointer-events: none; z-index: 2; opacity: 0.4; }
    @keyframes voicyfy-rays-rotate { 0% { transform: translate(-50%, -50%) rotate(0deg); } 100% { transform: translate(-50%, -50%) rotate(360deg); } }
    .voicyfy-page::after { content: ''; position: absolute; top: 50%; left: 50%; width: 60%; height: 60%; transform: translate(-50%, -50%); background: radial-gradient(ellipse at center, rgba(0, 217, 255, 0.08) 0%, transparent 70%); pointer-events: none; z-index: 2; animation: voicyfy-glow-pulse 8s ease-in-out infinite; }
    @keyframes voicyfy-glow-pulse { 0%, 100% { opacity: 0.3; transform: translate(-50%, -50%) scale(1); } 50% { opacity: 0.6; transform: translate(-50%, -50%) scale(1.1); } }
    .voicyfy-boot-screen { position: fixed; inset: 0; background: #000; display: flex; flex-direction: column; align-items: center; justify-content: center; z-index: 10000; transition: opacity 0.8s ease; }
    .voicyfy-boot-screen.hidden { opacity: 0; pointer-events: none; }
    .voicyfy-boot-title { font-family: 'Orbitron', monospace; font-size: 72px; font-weight: 700; color: #00d9ff; text-transform: uppercase; letter-spacing: 16px; margin-bottom: 60px; text-shadow: 0 0 20px rgba(0, 217, 255, 0.8), 0 0 40px rgba(0, 217, 255, 0.6), 0 0 60px rgba(0, 217, 255, 0.4); animation: voicyfy-boot-glow 2s ease-in-out infinite; }
    @keyframes voicyfy-boot-glow { 0%, 100% { text-shadow: 0 0 20px rgba(0, 217, 255, 0.8), 0 0 40px rgba(0, 217, 255, 0.6), 0 0 60px rgba(0, 217, 255, 0.4); } 50% { text-shadow: 0 0 30px rgba(0, 217, 255, 1), 0 0 60px rgba(0, 217, 255, 0.8), 0 0 90px rgba(0, 217, 255, 0.6); } }
    .voicyfy-boot-progress { width: 300px; height: 3px; background: rgba(0, 217, 255, 0.2); border-radius: 2px; overflow: hidden; margin-bottom: 20px; }
    .voicyfy-boot-progress-bar { height: 100%; background: linear-gradient(90deg, #00d9ff, #00ffff); border-radius: 2px; width: 0%; transition: width 0.3s ease; }
    .voicyfy-boot-text { font-family: 'Orbitron', monospace; font-size: 14px; color: #00d9ff; text-transform: uppercase; letter-spacing: 4px; }
    .voicyfy-hud-frame { position: fixed; pointer-events: none; z-index: 50; opacity: 0; transition: opacity 0.5s ease; }
    .voicyfy-hud-frame.active { opacity: 1; }
    .voicyfy-hud-frame::before, .voicyfy-hud-frame::after { content: ''; position: absolute; background: rgba(0, 217, 255, 0.6); }
    .voicyfy-hud-tl { top: 20px; left: 20px; } .voicyfy-hud-tl::before { width: 60px; height: 2px; top: 0; left: 0; } .voicyfy-hud-tl::after { width: 2px; height: 60px; top: 0; left: 0; }
    .voicyfy-hud-tr { top: 20px; right: 20px; } .voicyfy-hud-tr::before { width: 60px; height: 2px; top: 0; right: 0; } .voicyfy-hud-tr::after { width: 2px; height: 60px; top: 0; right: 0; }
    .voicyfy-hud-bl { bottom: 20px; left: 20px; } .voicyfy-hud-bl::before { width: 60px; height: 2px; bottom: 0; left: 0; } .voicyfy-hud-bl::after { width: 2px; height: 60px; bottom: 0; left: 0; }
    .voicyfy-hud-br { bottom: 20px; right: 20px; } .voicyfy-hud-br::before { width: 60px; height: 2px; bottom: 0; right: 0; } .voicyfy-hud-br::after { width: 2px; height: 60px; bottom: 0; right: 0; }
    .voicyfy-status-indicator { position: fixed; top: 30px; left: 50%; transform: translateX(-50%); padding: 10px 30px; background: rgba(10, 30, 50, 0.9); border: 2px solid rgba(0, 217, 255, 0.6); border-radius: 25px; display: flex; align-items: center; gap: 12px; opacity: 0; transition: opacity 0.5s ease; z-index: 100; }
    .voicyfy-status-indicator.active { opacity: 1; }
    .voicyfy-status-dot { width: 10px; height: 10px; background: #00ff88; border-radius: 50%; }
    .voicyfy-status-dot.interrupted { background: #ff8c00; } .voicyfy-status-dot.disconnected { background: #ef4444; } .voicyfy-status-dot.connecting { background: #f59e0b; }
    .voicyfy-status-text { font-family: 'Orbitron', monospace; font-size: 14px; color: #00d9ff; text-transform: uppercase; letter-spacing: 2px; }
    .voicyfy-power-button { width: 120px; height: 120px; border-radius: 50%; background: radial-gradient(circle at 30% 30%, rgba(0, 217, 255, 0.2), transparent 70%), linear-gradient(145deg, #0d1520, #080b13); box-shadow: 0 10px 40px rgba(0, 217, 255, 0.3), inset 0 -3px 10px rgba(0,0,0,0.5); display: flex; align-items: center; justify-content: center; cursor: pointer; border: 2px solid rgba(0, 217, 255, 0.4); opacity: 0; z-index: 10; }
    .voicyfy-power-button.visible { opacity: 1; }
    .voicyfy-power-icon { font-size: 48px; color: #00d9ff; z-index: 2; }
    .voicyfy-power-button.activating { animation: voicyfy-activate 1.5s ease-out forwards; }
    @keyframes voicyfy-activate { 0% { transform: scale(1); } 30% { transform: scale(1.1); } 60% { transform: scale(2.5); } 100% { width: 300px; height: 300px; transform: scale(1); background: transparent; border-color: transparent; } }
    .voicyfy-power-button.activating .voicyfy-power-icon { animation: voicyfy-icon-transform 1.5s ease-out forwards; }
    @keyframes voicyfy-icon-transform { 0% { opacity: 1; transform: scale(1) rotate(0deg); } 50% { opacity: 0.5; transform: scale(1.5) rotate(180deg); } 100% { opacity: 0; transform: scale(2) rotate(360deg); } }
    .voicyfy-call-text { position: fixed; bottom: 120px; left: 50%; transform: translateX(-50%); font-family: 'Orbitron', monospace; font-size: 24px; font-weight: 600; color: #00d9ff; text-transform: uppercase; letter-spacing: 4px; opacity: 0; z-index: 10; }
    .voicyfy-call-text.visible { opacity: 1; } .voicyfy-call-text.hidden { opacity: 0; transform: translateX(-50%) translateY(20px); }
    .voicyfy-assistant-sphere { width: 120px; height: 120px; border-radius: 50%; background: transparent; position: absolute; overflow: visible; transition: all 0.5s ease; display: flex; align-items: center; justify-content: center; cursor: pointer; pointer-events: none; opacity: 0; z-index: 10; }
    .voicyfy-assistant-sphere.active { width: 300px; height: 300px; pointer-events: all; opacity: 1; }
    .voicyfy-sphere-glass { position: absolute; width: 100%; height: 100%; border-radius: 50%; background: radial-gradient(circle at 30% 30%, rgba(0, 217, 255, 0.15), transparent 70%); border: 2px solid rgba(0, 217, 255, 0.3); opacity: 0; transition: all 0.5s ease; }
    .voicyfy-assistant-sphere.active .voicyfy-sphere-glass { opacity: 1; }
    .voicyfy-assistant-sphere.listening .voicyfy-sphere-glass { border-color: rgba(0, 217, 255, 0.6); animation: voicyfy-pulse-glass 2s ease-in-out infinite; }
    @keyframes voicyfy-pulse-glass { 0%, 100% { box-shadow: 0 0 60px rgba(0, 217, 255, 0.5); } 50% { box-shadow: 0 0 80px rgba(0, 217, 255, 0.7); } }
    .voicyfy-assistant-sphere.speaking .voicyfy-sphere-glass { border-color: rgba(0, 255, 200, 0.6); animation: voicyfy-pulse-speaking 1s ease-in-out infinite; }
    @keyframes voicyfy-pulse-speaking { 0%, 100% { transform: scale(1); } 50% { transform: scale(1.05); } }
    .voicyfy-assistant-sphere.interrupted .voicyfy-sphere-glass { border-color: rgba(255, 140, 0, 0.6); }
    .voicyfy-mic-icon { color: #00d9ff; font-size: 64px; z-index: 10; opacity: 0; transform: scale(0); }
    .voicyfy-assistant-sphere.active .voicyfy-mic-icon { opacity: 1; transform: scale(1); animation: voicyfy-mic-appear 0.5s ease-out 1.3s forwards; }
    @keyframes voicyfy-mic-appear { 0% { opacity: 0; transform: scale(0) rotate(-180deg); } 100% { opacity: 1; transform: scale(1) rotate(0deg); } }
    .voicyfy-assistant-sphere.listening .voicyfy-mic-icon { color: #00d9ff; } .voicyfy-assistant-sphere.speaking .voicyfy-mic-icon { color: #00ffc8; } .voicyfy-assistant-sphere.interrupted .voicyfy-mic-icon { color: #ff8c00; }
    .voicyfy-circular-visualizer { position: absolute; width: 100%; height: 100%; opacity: 0; pointer-events: none; z-index: 5; }
    .voicyfy-assistant-sphere.active .voicyfy-circular-visualizer { opacity: 1; }
    .voicyfy-viz-bar { position: absolute; width: 3px; background: linear-gradient(to top, transparent, #00d9ff, transparent); border-radius: 2px; bottom: 50%; left: 50%; transform-origin: bottom center; height: 20px; }
    .voicyfy-loader-overlay { position: fixed; inset: 0; background: rgba(0,0,0,0.95); display: none; flex-direction: column; align-items: center; justify-content: center; z-index: 9999; }
    .voicyfy-loader-overlay.active { display: flex; }
    .voicyfy-connection-ring { position: absolute; width: 100%; height: 100%; border: 3px solid transparent; border-top-color: #00d9ff; border-radius: 50%; animation: voicyfy-spin 1.5s linear infinite; }
    @keyframes voicyfy-spin { to { transform: rotate(360deg); } }
    .voicyfy-loader-text { color: #00d9ff; margin-top: 30px; font-size: 16px; font-family: 'Orbitron', monospace; letter-spacing: 3px; }
    .voicyfy-model-badge { position: fixed; bottom: 20px; left: 50%; transform: translateX(-50%); padding: 8px 20px; background: rgba(10, 30, 50, 0.8); border: 1px solid rgba(0, 217, 255, 0.3); border-radius: 20px; font-family: 'Orbitron', monospace; font-size: 10px; color: rgba(0, 217, 255, 0.6); z-index: 50; opacity: 0; }
    .voicyfy-model-badge.active { opacity: 1; }
    @media (max-width: 768px) { .voicyfy-boot-title { font-size: 48px; } .voicyfy-power-button { width: 100px; height: 100px; } .voicyfy-assistant-sphere.active { width: 250px; height: 250px; } }
    @media (max-width: 480px) { .voicyfy-boot-title { font-size: 36px; } .voicyfy-power-button { width: 80px; height: 80px; } .voicyfy-assistant-sphere.active { width: 200px; height: 200px; } }
  </style>
</head>
<body>
  <div id="voicyfy-fallback" style="position:fixed;inset:0;background:#0d1b3a;color:#00d9ff;display:flex;align-items:center;justify-content:center;font-family:sans-serif;font-size:18px;z-index:99999;">Загрузка JARVIS...</div>
  <div class="voicyfy-page">
    <canvas id="voicyfy-three-canvas"></canvas>
    <div class="voicyfy-boot-screen" id="voicyfy-bootScreen">
      <div class="voicyfy-boot-title">JARVIS</div>
      <div class="voicyfy-boot-progress"><div class="voicyfy-boot-progress-bar" id="voicyfy-bootProgress"></div></div>
      <div class="voicyfy-boot-text">INITIALIZING GEMINI SYSTEMS...</div>
    </div>
    <div class="voicyfy-hud-frame voicyfy-hud-tl" id="voicyfy-hudTL"></div>
    <div class="voicyfy-hud-frame voicyfy-hud-tr" id="voicyfy-hudTR"></div>
    <div class="voicyfy-hud-frame voicyfy-hud-bl" id="voicyfy-hudBL"></div>
    <div class="voicyfy-hud-frame voicyfy-hud-br" id="voicyfy-hudBR"></div>
    <div class="voicyfy-status-indicator" id="voicyfy-statusIndicator">
      <div class="voicyfy-status-dot" id="voicyfy-statusDot"></div>
      <div class="voicyfy-status-text" id="voicyfy-statusText">ПОДКЛЮЧЕНО</div>
    </div>
    <div class="voicyfy-loader-overlay" id="voicyfy-loader">
      <div style="width:100px;height:100px;position:relative;"><div class="voicyfy-connection-ring"></div><div class="voicyfy-connection-ring" style="width:70%;height:70%;top:15%;left:15%;border-top-color:#00ffff;animation-duration:1s;animation-direction:reverse;"></div></div>
      <div class="voicyfy-loader-text">ПОДКЛЮЧЕНИЕ К GEMINI...</div>
    </div>
    <div class="voicyfy-power-button" id="voicyfy-powerButton"><i class="fas fa-power-off voicyfy-power-icon"></i></div>
    <div class="voicyfy-call-text" id="voicyfy-callText">АКТИВИРОВАТЬ JARVIS</div>
    <div class="voicyfy-assistant-sphere" id="voicyfy-sphere">
      <div class="voicyfy-sphere-glass"></div>
      <i class="fas fa-microphone voicyfy-mic-icon"></i>
      <div class="voicyfy-circular-visualizer" id="voicyfy-circularViz"></div>
    </div>
    <div class="voicyfy-model-badge" id="voicyfy-modelBadge">Gemini 2.5 Flash Native Audio</div>
  </div>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/three.js/r128/three.min.js" onerror="window.THREE_LOAD_FAILED=1"></script>
  <script>
(function(){'use strict';
var DEBUG_MODE=true,MAX_RECONNECT_ATTEMPTS=5,PING_INTERVAL=3e4,ASSISTANT_ID="bd59c93e-5437-421b-85c5-b85a9f2d3d92",SERVER_URL="https://voicyfy.ru",WS_URL=SERVER_URL.replace(/^http/,'ws')+"/ws/gemini/"+ASSISTANT_ID,AUDIO_CONFIG={inputSampleRate:16e3,outputSampleRate:24e3,playbackSampleRate:24e3,actualSampleRate:null,needsResampling:false},isMobile=/iPhone|iPad|iPod|Android/i.test(navigator.userAgent);
var RECORDER_WORKLET='class RecorderWorkletProcessor extends AudioWorkletProcessor{constructor(){super();this.bufferSize=4096;this.buffer=new Float32Array(this.bufferSize);this.bufferIndex=0}process(inputs,outputs,parameters){var input=inputs[0];if(!input||!input[0])return true;var inputData=input[0];for(var i=0;i<inputData.length;i++){this.buffer[this.bufferIndex++]=inputData[i];if(this.bufferIndex>=this.bufferSize){this.port.postMessage({type:"audioData",data:this.buffer.slice(0,this.bufferIndex)});this.bufferIndex=0}}return true}}registerProcessor("recorder-worklet",RecorderWorkletProcessor);';
var STREAM_WORKLET='class AudioStreamProcessor extends AudioWorkletProcessor{constructor(){super();this.audioQueue=[];this.currentBuffer=null;this.bufferIndex=0;this.isActive=!1;this.port.onmessage=function(e){if(e.data.type==="audioData"){this.audioQueue.push(e.data.buffer);if(!this.isActive){this.isActive=!0;this.port.postMessage({type:"started"})}}else if(e.data.type==="clear"){this.audioQueue=[];this.currentBuffer=null;this.bufferIndex=0;this.isActive=!1}else if(e.data.type==="stop")this.isActive=!1}}(this)}process(inputs,outputs,parameters){var output=outputs[0];if(!output||!output[0])return true;var ch=output[0];for(var i=0;i<ch.length;i++){if(!this.currentBuffer||this.bufferIndex>=this.currentBuffer.length){if(this.audioQueue.length>0){this.currentBuffer=this.audioQueue.shift();this.bufferIndex=0}else{ch[i]=0;continue}}ch[i]=this.currentBuffer[this.bufferIndex++]}return true}}registerProcessor("audio-stream-processor",AudioStreamProcessor);';
var STATE={ws:null,isConnected:!1,isSetupComplete:!1,readyToRecord:!1,isRecording:!1,isPlaying:!1,isSpeaking:!1,audioContext:null,mediaStream:null,recorderWorklet:null,streamWorklet:null,pingInterval:null,reconnectAttempts:0,audioWorkletReady:!1,streamWorkletReady:!1,isActivated:!1,isSystemReady:!1};
var bootScreen,bootProgress,loader,powerButton,callText,sphere,circularViz,statusIndicator,statusDot,statusText,modelBadge,hudFrames;
function log(msg,type){if(DEBUG_MODE||type==='error'){var p='[JARVIS-GEMINI]';if(type==='error')console.error(p+' ERROR:',msg);else if(type==='warn')console.warn(p+' WARNING:',msg);else console.log(p,msg)}}
function initAudioContext(){if(STATE.audioContext){if(STATE.audioContext.state==='suspended')return STATE.audioContext.resume().then(function(){return true});return Promise.resolve(true)}log('Creating AudioContext...');var C=window.AudioContext||window.webkitAudioContext;STATE.audioContext=new C({sampleRate:AUDIO_CONFIG.playbackSampleRate,latencyHint:'interactive'});AUDIO_CONFIG.actualSampleRate=STATE.audioContext.sampleRate;if(AUDIO_CONFIG.actualSampleRate!==AUDIO_CONFIG.outputSampleRate)AUDIO_CONFIG.needsResampling=true;return loadAudioWorklets().then(function(){return true})}
function loadAudioWorklets(){var r=new Blob([RECORDER_WORKLET],{type:'application/javascript'}),ru=URL.createObjectURL(r);return STATE.audioContext.audioWorklet.addModule(ru).then(function(){STATE.audioWorkletReady=true;URL.revokeObjectURL(ru);log('Recorder worklet loaded');var s=new Blob([STREAM_WORKLET],{type:'application/javascript'}),su=URL.createObjectURL(s);return STATE.audioContext.audioWorklet.addModule(su)}).then(function(){STATE.streamWorkletReady=true;URL.revokeObjectURL(URL.createObjectURL(new Blob([STREAM_WORKLET],{type:'application/javascript'})));log('Stream worklet loaded')})}
function startRecording(){if(STATE.isRecording)return;log('Starting recording...');navigator.mediaDevices.getUserMedia({audio:{sampleRate:AUDIO_CONFIG.inputSampleRate,echoCancellation:true,noiseSuppression:true,autoGainControl:true}}).then(function(stream){STATE.mediaStream=stream;var src=STATE.audioContext.createMediaStreamSource(stream),node=new AudioWorkletNode(STATE.audioContext,'recorder-worklet');node.port.onmessage=function(ev){if(!STATE.isRecording)return;var d=ev.data.data;updateCircularVisualization(d);var pcm=float32ToPCM16(d),b64=arrayBufferToBase64(pcm.buffer);if(STATE.ws&&STATE.ws.readyState===WebSocket.OPEN)STATE.ws.send(JSON.stringify({type:'input_audio_buffer.append',audio:b64}))};src.connect(node);node.connect(STATE.audioContext.destination);STATE.recorderWorklet={source:src,workletNode:node};STATE.isRecording=true;sphere.classList.add('listening');sphere.classList.remove('speaking');updateConnectionStatus('connected','Слушаю');log('Recording started')}).catch(function(err){log('Microphone error: '+err.message,'error');updateConnectionStatus('error','Нет доступа к микрофону')})}
function stopRecording(){if(!STATE.isRecording)return;STATE.isRecording=false;if(STATE.mediaStream){STATE.mediaStream.getTracks().forEach(function(t){t.stop()});STATE.mediaStream=null}if(STATE.recorderWorklet){STATE.recorderWorklet.source.disconnect();STATE.recorderWorklet.workletNode.disconnect();STATE.recorderWorklet=null}resetCircularVisualization();log('Recording stopped')}
function startAudioStream(){if(STATE.isPlaying)return;var p=STATE.audioContext&&STATE.audioContext.state==='suspended'?STATE.audioContext.resume():Promise.resolve();p.then(function(){if(!STATE.streamWorklet&&STATE.streamWorkletReady){STATE.streamWorklet=new AudioWorkletNode(STATE.audioContext,'audio-stream-processor');STATE.streamWorklet.connect(STATE.audioContext.destination);log('Stream worklet connected')}STATE.isPlaying=true}).catch(function(e){log('Stream error: '+e.message,'error')})}
function stopPlayback(){if(!STATE.isPlaying)return;if(STATE.streamWorklet)STATE.streamWorklet.port.postMessage({type:'clear'});STATE.isPlaying=false;STATE.isSpeaking=false;resetCircularVisualization();log('Playback stopped')}
function handleAudioDelta(data){if(!data.delta)return;var resume=STATE.audioContext&&STATE.audioContext.state==='suspended'?STATE.audioContext.resume():Promise.resolve();resume.then(function(){try{var bin=atob(data.delta),bytes=new Uint8Array(bin.length),i;for(i=0;i<bin.length;i++)bytes[i]=bin.charCodeAt(i);var pcm16=new Int16Array(bytes.buffer),float32=new Float32Array(pcm16.length);for(i=0;i<pcm16.length;i++)float32[i]=pcm16[i]/32768;var audioData=float32;if(AUDIO_CONFIG.needsResampling)audioData=resampleAudio(float32,AUDIO_CONFIG.outputSampleRate,AUDIO_CONFIG.actualSampleRate);if(STATE.streamWorklet)STATE.streamWorklet.port.postMessage({type:'audioData',buffer:audioData});if(!STATE.isPlaying)startAudioStream();updateCircularVisualization(audioData)}catch(e){log('Audio delta error: '+e.message,'error')}})}
function resampleAudio(inBuf,inRate,outRate){if(inRate===outRate)return inBuf;var ratio=inRate/outRate,outLen=Math.round(inBuf.length/ratio),out=new Float32Array(outLen),i;for(i=0;i<outLen;i++){var si=i*ratio,fl=Math.floor(si),cl=Math.min(fl+1,inBuf.length-1),t=si-fl;out[i]=inBuf[fl]*(1-t)+inBuf[cl]*t}return out}
function connectWebSocket(){updateConnectionStatus('connecting','Подключение...');loader.classList.add('active');STATE.ws=new WebSocket(WS_URL);STATE.ws.binaryType='arraybuffer';STATE.ws.onopen=function(){log('WebSocket connected');STATE.isConnected=true;STATE.reconnectAttempts=0;loader.classList.remove('active');hudFrames.forEach(function(f){f.classList.add('active')});statusIndicator.classList.add('active');modelBadge.classList.add('active');updateConnectionStatus('connected','Подключено');STATE.pingInterval=setInterval(function(){if(STATE.ws&&STATE.ws.readyState===WebSocket.OPEN)STATE.ws.send(JSON.stringify({type:'ping'}))},PING_INTERVAL);setTimeout(function(){if(!STATE.isSetupComplete){STATE.isSetupComplete=true;STATE.readyToRecord=true;startRecording()}},1e4)};STATE.ws.onmessage=handleWSMessage;STATE.ws.onerror=function(){updateConnectionStatus('error','Ошибка соединения')};STATE.ws.onclose=function(ev){log('WS Closed: '+ev.code);STATE.isConnected=false;STATE.readyToRecord=false;stopPlayback();stopRecording();if(STATE.pingInterval){clearInterval(STATE.pingInterval);STATE.pingInterval=null}updateConnectionStatus('disconnected','Отключено');modelBadge.classList.remove('active');if(STATE.isActivated&&STATE.reconnectAttempts<MAX_RECONNECT_ATTEMPTS){STATE.reconnectAttempts++;setTimeout(connectWebSocket,2e3)}}}
function handleWSMessage(ev){if(ev.data instanceof ArrayBuffer||ev.data instanceof Blob)return;try{var data=JSON.parse(ev.data);switch(data.type){case 'gemini.setup.complete':log('Gemini ready');STATE.isSetupComplete=true;updateConnectionStatus('connected','Готов');setTimeout(function(){STATE.readyToRecord=true;startRecording()},800);break;case 'connection_status':if(data.model)modelBadge.textContent=data.model;break;case 'response.audio.delta':handleAudioDelta(data);break;case 'assistant.speech.started':STATE.isSpeaking=true;sphere.classList.remove('listening');sphere.classList.add('speaking');updateConnectionStatus('connected','Ассистент говорит');if(!STATE.isPlaying)startAudioStream();break;case 'assistant.speech.ended':STATE.isSpeaking=false;stopPlayback();sphere.classList.remove('speaking');sphere.classList.add('listening');updateConnectionStatus('connected','Слушаю');break;case 'conversation.interrupted':STATE.isSpeaking=false;stopPlayback();sphere.classList.remove('speaking','listening');sphere.classList.add('interrupted');updateConnectionStatus('interrupted','Перебивание');setTimeout(function(){sphere.classList.remove('interrupted');sphere.classList.add('listening')},800);break;case 'error':updateConnectionStatus('error',data.error&&data.error.message||'Ошибка');break}}catch(e){log('Parse error: '+e,'error')}}
function updateConnectionStatus(status,message){if(!statusIndicator||!statusDot||!statusText)return;statusText.textContent=message||status;statusDot.classList.remove('connected','disconnected','connecting','interrupted');if(status==='connected')statusDot.classList.add('connected');else if(status==='disconnected')statusDot.classList.add('disconnected');else if(status==='interrupted')statusDot.classList.add('interrupted');else statusDot.classList.add('connecting');statusIndicator.classList.add('active');setTimeout(function(){if(status!=='interrupted')statusIndicator.classList.remove('active')},3e3)}
function createCircularVisualizer(){var n=isMobile?40:60,step=360/n,i;for(i=0;i<n;i++){var bar=document.createElement('div');bar.className='voicyfy-viz-bar';bar.style.transform='rotate('+(i*step)+'deg) translateY(-150px)';bar.style.height='20px';circularViz.appendChild(bar)}}
function updateCircularVisualization(audioData){var bars=circularViz.querySelectorAll('.voicyfy-viz-bar'),step=Math.floor(audioData.length/bars.length),i;for(i=0;i<bars.length;i++){var sum=0,j;for(j=0;j<step;j++){var idx=i*step+j;if(idx<audioData.length)sum+=Math.abs(audioData[idx])}var avg=sum/step,h=20+Math.min(80,Math.floor(avg*200));bars[i].style.height=h+'px'}}
function resetCircularVisualization(){var bars=circularViz.querySelectorAll('.voicyfy-viz-bar');bars.forEach(function(b){b.style.height='20px'})}
function float32ToPCM16(arr){var pcm=new Int16Array(arr.length),i;for(i=0;i<arr.length;i++){var s=Math.max(-1,Math.min(1,arr[i]));pcm[i]=s<0?s*0x8000:s*0x7FFF}return pcm}
function arrayBufferToBase64(buf){var bytes=new Uint8Array(buf),b='',i;for(i=0;i<bytes.byteLength;i++)b+=String.fromCharCode(bytes[i]);return btoa(b)}
function bootSystem(){log('Loading JARVIS...');var steps=[300,400,500,300,400],progress=0,inc=100/steps.length;steps.forEach(function(d){setTimeout(function(){progress+=inc;bootProgress.style.width=Math.min(progress,100)+'%'},d)});setTimeout(function(){bootProgress.style.width='100%'},500);setTimeout(function(){bootScreen.classList.add('hidden')},1300);setTimeout(function(){if(typeof THREE!=='undefined'){try{var c=document.getElementById('voicyfy-three-canvas');if(c){var scene=new THREE.Scene(),cam=new THREE.PerspectiveCamera(75,window.innerWidth/window.innerHeight,0.1,2e3);cam.position.z=500;var renderer=new THREE.WebGLRenderer({canvas:c,alpha:true});renderer.setSize(window.innerWidth,window.innerHeight);var geo=new THREE.BufferGeometry(),cnt=isMobile?800:1500,pos=new Float32Array(cnt*3),col=new Float32Array(cnt*3),i;for(i=0;i<cnt;i++){pos[i*3]=(Math.random()-0.5)*2e3;pos[i*3+1]=(Math.random()-0.5)*2e3;pos[i*3+2]=(Math.random()-0.5)*1500;var cl=[0x00d9ff,0x00ffff,0x0099cc][Math.floor(Math.random()*3)];col[i*3]=(cl>>16)/255;col[i*3+1]=((cl>>8)&255)/255;col[i*3+2]=(cl&255)/255}geo.setAttribute('position',new THREE.BufferAttribute(pos,3));geo.setAttribute('color',new THREE.BufferAttribute(col,3));var mat=new THREE.PointsMaterial({size:isMobile?2:3,vertexColors:true,transparent:true,opacity:0.8,blending:THREE.AdditiveBlending}),pts=new THREE.Points(geo,mat);scene.add(pts);function anim(){requestAnimationFrame(anim);if(pts){pts.rotation.y+=0.0002;pts.rotation.x+=0.0001}renderer.render(scene,cam)}anim();setTimeout(function(){c.classList.add('active')},500)}catch(e){}}},1800);setTimeout(function(){powerButton.classList.add('visible');callText.classList.add('visible');STATE.isSystemReady=true;log('System ready')},2300)},500)}
function initializeAndStart(){initAudioContext().then(function(ok){if(!ok){loader.querySelector('.voicyfy-loader-text').textContent='ОШИБКА АУДИО';return}connectWebSocket()})}
window.addEventListener('load',function(){bootScreen=document.getElementById('voicyfy-bootScreen');bootProgress=document.getElementById('voicyfy-bootProgress');loader=document.getElementById('voicyfy-loader');powerButton=document.getElementById('voicyfy-powerButton');callText=document.getElementById('voicyfy-callText');sphere=document.getElementById('voicyfy-sphere');circularViz=document.getElementById('voicyfy-circularViz');statusIndicator=document.getElementById('voicyfy-statusIndicator');statusDot=document.getElementById('voicyfy-statusDot');statusText=document.getElementById('voicyfy-statusText');modelBadge=document.getElementById('voicyfy-modelBadge');hudFrames=[document.getElementById('voicyfy-hudTL'),document.getElementById('voicyfy-hudTR'),document.getElementById('voicyfy-hudBL'),document.getElementById('voicyfy-hudBR')];var fallback=document.getElementById('voicyfy-fallback');if(fallback)fallback.style.display='none';createCircularVisualizer();bootSystem();powerButton.addEventListener('click',function(){if(STATE.isActivated||!STATE.isSystemReady)return;STATE.isActivated=true;powerButton.classList.add('activating');callText.classList.add('hidden');setTimeout(function(){powerButton.style.display='none';sphere.classList.add('active');loader.classList.add('active');initializeAndStart()},1500)});sphere.addEventListener('click',function(){if(!STATE.audioContext)initAudioContext().then(function(){if(!STATE.isRecording&&!STATE.isPlaying&&STATE.isConnected)startRecording()});else if(!STATE.isRecording&&!STATE.isPlaying&&STATE.isConnected)startRecording()})});
})();
  </script>
</body>
</html>''';

  @override
  void initState() {
    super.initState();
  }

  Future<void> _requestMicrophoneAndStart() async {
    if (_micPermissionRequested) return;
    setState(() => _micPermissionRequested = true);
    try {
      final status = await Permission.microphone.request();
      if (!status.isGranted) {
        debugPrint('JARVIS: Microphone permission denied: $status');
        if (mounted) setState(() => _micPermissionRequested = false);
        return;
      }
      debugPrint('JARVIS: Microphone permission granted');
      if (mounted) setState(() => _showWebView = true);
    } on Exception catch (e) {
      debugPrint('JARVIS: Microphone permission request failed: $e');
      if (mounted) setState(() => _showWebView = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_showWebView) {
      return SizedBox(
        width: widget.width ?? double.infinity,
        height: widget.height ?? double.infinity,
        child: Container(
          color: const Color(0xFF0d1b3a),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.mic, size: 64, color: Color(0xFF00d9ff)),
                const SizedBox(height: 24),
                Text(
                  'Для голосового ассистента нужен доступ к микрофону',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFF00d9ff),
                    fontSize: 16,
                    fontFamily: 'Orbitron',
                  ),
                ),
                const SizedBox(height: 32),
                ElevatedButton.icon(
                  onPressed: _micPermissionRequested
                      ? null
                      : _requestMicrophoneAndStart,
                  icon: const Icon(Icons.mic_none),
                  label: const Text('Разрешить микрофон'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00d9ff),
                    foregroundColor: const Color(0xFF0d1b3a),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return SizedBox(
      width: widget.width ?? double.infinity,
      height: widget.height ?? double.infinity,
      child: InAppWebView(
        initialData: InAppWebViewInitialData(
          data: _htmlContent,
          baseUrl: WebUri('https://voicyfy.ru'),
        ),
        initialOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(
            javaScriptEnabled: true,
            mediaPlaybackRequiresUserGesture: false,
            transparentBackground: false,
          ),
          android: AndroidInAppWebViewOptions(
            useHybridComposition: true,
          ),
          ios: IOSInAppWebViewOptions(
            allowsInlineMediaPlayback: true,
          ),
        ),
        androidOnPermissionRequest: (controller, origin, resources) async {
          return PermissionRequestResponse(
            resources: resources,
            action: PermissionRequestResponseAction.GRANT,
          );
        },
        onConsoleMessage: (controller, consoleMessage) {
          debugPrint(
            'JARVIS [${consoleMessage.messageLevel}]: ${consoleMessage.message}',
          );
        },
      ),
    );
  }
}
