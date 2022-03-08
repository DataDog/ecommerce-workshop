import React from 'react';
import ReactDOM from 'react-dom';
import './index.css';
import App from './App';

import { datadogRum } from '@datadog/browser-rum';

datadogRum.init({
  applicationId: `${
    import.meta.env.REACT_APP_DD_APPLICATION_ID ||
    'DD_APPLICATION_ID_PLACEHOLDER'
  }`,
  clientToken: `${
    import.meta.env.REACT_APP_DD_CLIENT_TOKEN || 'DD_CLIENT_TOKEN_PLACEHOLDER'
  }`,
  site: `${import.meta.env.REACT_APP_DD_SITE || 'datadoghq.com'}`,
  service: `${import.meta.env.REACT_APP_DD_SERVICE || 'discounts-frontend'}`,
  version: `${import.meta.env.REACT_APP_DD_VERSION || '1.0.0'}`,
  env: `${import.meta.env.REACT_APP_DD_ENV || 'production'}`,
  sampleRate: 100,
  trackInteractions: true,
  defaultPrivacyLevel: 'mask-user-input',
  allowedTracingOrigins: [
    /https:\/\/.*\.env.play.instruqt\.com/,
    'http://localhost:3001',
  ],
});

datadogRum.startSessionReplayRecording();

ReactDOM.render(
  <React.StrictMode>
    <App />
  </React.StrictMode>,
  document.getElementById('root')
);
