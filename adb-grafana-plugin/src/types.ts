import { DataQuery, DataSourceJsonData } from '@grafana/data';

export interface ADBQuery extends DataQuery {
  queryText?: string;
}

export const defaultQuery: Partial<ADBQuery> = {};

/**
 * These are options configured for each DataSource instance
 */
export interface ADBDataSourceOptions extends DataSourceJsonData {
  connectionstring?: string;
}

/**
 * Value that is used in the backend, but never sent over HTTP to the frontend
 */
export interface ADBSecureJsonData {
  user?: string;
  password?: string;
}
