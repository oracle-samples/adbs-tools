import defaults from 'lodash/defaults';
import React, { ChangeEvent, PureComponent, MouseEvent } from 'react';
import { TextArea, Button } from '@grafana/ui';
import { QueryEditorProps } from '@grafana/data';
import { DataSource } from '../datasource';
import { defaultQuery, ADBDataSourceOptions, ADBQuery } from '../types';

type Props = QueryEditorProps<DataSource, ADBQuery, ADBDataSourceOptions>;

export class QueryEditor extends PureComponent<Props> {
  onqueryChange = (event: ChangeEvent<HTMLTextAreaElement>) => {
    const { onChange, query } = this.props;
    onChange({ ...query, queryText: event.target.value });
  };

  onButtonClick = (event: MouseEvent<HTMLButtonElement>) => {
    const { onRunQuery } = this.props;
    onRunQuery();
  };

  render() {
    const query = defaults(this.props.query, defaultQuery);
    const { queryText } = query;

    return (
      <div className="gf-form-group">
        <label className="gf-form-label">Query</label>
        <TextArea
          className="gf-form-input"
          type="text"
          cols={35}
          rows={3}
          width={1024}
          placeholder="Add sql query for oracle DB"
          value={queryText || ''}
          onChange={this.onqueryChange}
        ></TextArea>
        <Button style={{ float: 'right' }} color="primary" className="float-right" onClick={this.onButtonClick}>
          RunQuery
        </Button>
      </div>
    );
  }
}
