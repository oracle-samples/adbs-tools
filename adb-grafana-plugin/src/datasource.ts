import { DataSourceInstanceSettings } from '@grafana/data';
import { DataSourceWithBackend, getTemplateSrv } from '@grafana/runtime';
import { ADBQuery, ADBDataSourceOptions } from './types';

export class DataSource extends DataSourceWithBackend<ADBQuery, ADBDataSourceOptions> {
  constructor(instanceSettings: DataSourceInstanceSettings<ADBDataSourceOptions>) {
    super(instanceSettings);
  }

  applyTemplateVariables(query: ADBQuery) {
    const templateSrv = getTemplateSrv();
    return {
      ...query,
      queryText: query.queryText ? templateSrv.replace(query.queryText) : '',
    };
  }
}
