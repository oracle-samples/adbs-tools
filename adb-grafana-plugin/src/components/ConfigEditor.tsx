import React, { ChangeEvent, PureComponent } from 'react';
import { LegacyForms } from '@grafana/ui';
import { DataSourcePluginOptionsEditorProps } from '@grafana/data';
import { ADBDataSourceOptions, ADBSecureJsonData } from '../types';

const { SecretFormField, FormField } = LegacyForms;
interface Props extends DataSourcePluginOptionsEditorProps<ADBDataSourceOptions> {}

interface State {}

export class ConfigEditor extends PureComponent<Props, State> {
  // on change of user, Secure field (only sent to the backend)
  onUserChange = (event: ChangeEvent<HTMLInputElement>) => {
    const { onOptionsChange, options } = this.props;
    onOptionsChange({
      ...options,
      secureJsonData: {
        ...options.secureJsonData,
        user: event.target.value,
      },
    });
  };

  // on change of password, Secure field (only sent to the backend)
  onPasswordChange = (event: ChangeEvent<HTMLInputElement>) => {
    const { onOptionsChange, options } = this.props;
    onOptionsChange({
      ...options,
      secureJsonData: {
        ...options.secureJsonData,
        password: event.target.value,
      },
    });
  };

  onResetPassword = () => {
    const { onOptionsChange, options } = this.props;
    onOptionsChange({
      ...options,
      secureJsonFields: {
        ...options.secureJsonFields,
        password: false,
      },
      secureJsonData: {
        ...options.secureJsonData,
        password: '',
      },
    });
  };

  onResetUser = () => {
    const { onOptionsChange, options } = this.props;
    onOptionsChange({
      ...options,
      secureJsonFields: {
        ...options.secureJsonFields,
        user: false,
      },
      secureJsonData: {
        ...options.secureJsonData,
        user: '',
      },
    });
  };

  // on change of connection string
  onConnectionstringChange = (event: ChangeEvent<HTMLInputElement>) => {
    const { onOptionsChange, options } = this.props;
    onOptionsChange({
      ...options,
      jsonData: {
        ...options.jsonData,
        connectionstring: event.target.value,
      },
    });
  };

  render() {
    const { options } = this.props;
    const { jsonData, secureJsonFields } = options;
    const secureJsonData = (options.secureJsonData || {}) as ADBSecureJsonData;

    return (
      <div className="gf-form-group">
        <div className="gf-form">
          <SecretFormField
            isConfigured={(secureJsonFields && secureJsonFields.user) as boolean}
            label="User"
            labelWidth={8}
            inputWidth={20}
            onChange={this.onUserChange}
            value={secureJsonData.user || ''}
            onReset={this.onResetUser}
            placeholder="ADB user"
          />
        </div>
        <div className="gf-form">
          <SecretFormField
            isConfigured={(secureJsonFields && secureJsonFields.password) as boolean}
            value={secureJsonData.password || ''}
            label="Password"
            placeholder="User password"
            labelWidth={8}
            inputWidth={20}
            onReset={this.onResetPassword}
            onChange={this.onPasswordChange}
          />
        </div>
        <br></br>
        <br></br>
        <h5>Connection String Config</h5>
        <div className="gf-form-inline">
          <FormField
            label="Connection string"
            labelWidth={8}
            inputWidth={20}
            onChange={this.onConnectionstringChange}
            value={jsonData.connectionstring || ''}
            placeholder="Format<hostname:port:service_name>"
          />
        </div>
      </div>
    );
  }
}
