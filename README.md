# rsyslog-server
Simple docker image providing a cluster global rsyslog server

# Certificate creation

```
mkdir ssl

openssl req -nodes -x509 -sha256 -newkey rsa:4096   \
    -keyout ssl/key.pem   -out ssl/cert.pem   -days 356   \
    -subj "/CN=localhost"    -addext "subjectAltName = DNS:rsyslog.rsyslog"
    
cp ssl/cert.pem ssl/ca.pem
```

# Docker run
```shell
docker run -dti -v $(pwd)/ssl:/etc/rsyslog/ssl -v $(pwd)/log/:/var/log/ -e RSYSLOG_PORT=514 -p 514:514 yadavankur95/rsyslog-tls-server:latest

```

# Docker compose

```
docker compose up
```

# helm install

The rsyslog-server can be installed using the helm chart under charts/


# sample Kubernetes deployment

The following deployment creates a `syslog` service to a Kubernets cluster.

Applications in the cluster may then direct syslog messages via TCP or UDP to the server `syslog`.

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: rysylog-rsyslog-tls-cert
  namespace: default
type: Opaque
data:
  cert.pem: "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUZKVENDQXcyZ0F3SUJBZ0lVZmpzeXNXMFY1czJkTXM4SnAvdUFlUy9palFJd0RRWUpLb1pJaHZjTkFRRUwKQlFBd0ZERVNNQkFHQTFVRUF3d0piRzlqWVd4b2IzTjBNQjRYRFRJME1USXdOVEEzTVRnMU1sb1hEVEkxTVRFeQpOakEzTVRnMU1sb3dGREVTTUJBR0ExVUVBd3dKYkc5allXeG9iM04wTUlJQ0lqQU5CZ2txaGtpRzl3MEJBUUVGCkFBT0NBZzhBTUlJQ0NnS0NBZ0VBMTlNZHFGQkhGTjNxbkdBV2czN1ovUDk1MmRjUy9RSXllRTUzZGhQRmhIQzEKRkZ5OWFJeTN2aHJvaHl3NUNrMkg1Y2tROVBhQXdzMHBUdDZ3NmR4Wmt6N0kvaG9UL3F6VURQbE8wLzBRVFh4YwpBckNwWkxVYmpJQjY3ejNmUnBOdHMzZm5xalo1aUZxMFBhNGcvY0lpUUVQalBDeCtJZnVGY3pkb0x3SWo2YzdECkRBU253eFVGNy91ZzBKaWs0dGYzSEl2N2ZCT2ZaSzQ1RTdRdVdXUXJFVUhkUXFWcStNeE9ZbGxSbWdKa3grS1MKQnA4WW9QWTBNWXFwRm81NHhKbnN4YlRPTkFrM0VuajBPQ1ptcGc5cHBYTTBGanpxRlhHeEJvcnUwOEtqOWZFYQoxUHVwT1FSdG9md24xLzZGQ2tpVnRlYUUxZWp0bEt3djJtTGQ1ckQrOXB0U0IxUGs2Vm1YbG1RK0g0Zm5rcElJCkg5bFFUQk5BeUVaRTM2ZHQrb015N1pPS0haVFBSdExkMndmUmdJbm1RTU5sRFE2Qm42NktENk5xckt3V3FudXcKYWxmTkF5TGRWc0crY1RtMTV2VjR2VTl3ZlZBYmJhTkQ0R3Joa1AvT3dhOWZwTzVHa1VDWFhFdmdvS1RCZk1BUgo2UDRTaHAzNjZabzlJaHRwNGdteXQ5b1lOOW9xQkw4QjFtNUVtc0ZqcjFhbDFMbEtXZU9WNHhFOURKSXdUY3NaCjcveG1TK1Qxa3NseWZZcjFSWHF3SG14L1pLMzlIa2dpdkhLNjRsd0xFOHNVSlBiS3AwSkJPZXRVQXJpU1dYUngKNFBXdUk0Z2ZDbVhsRTd3SGxaaThBdkRsc0YvZVQzekN1cW1kTTc1eFJGZjRFZlgrb242T2t4bGtDVmlKVHNVQwpBd0VBQWFOdk1HMHdIUVlEVlIwT0JCWUVGRXFhMEhVemwvc0hVSHZLTjNUc0M5c0N3c1JnTUI4R0ExVWRJd1FZCk1CYUFGRXFhMEhVemwvc0hVSHZLTjNUc0M5c0N3c1JnTUE4R0ExVWRFd0VCL3dRRk1BTUJBZjh3R2dZRFZSMFIKQkJNd0VZSVBjbk41YzJ4dlp5NXljM2x6Ykc5bk1BMEdDU3FHU0liM0RRRUJDd1VBQTRJQ0FRQVJnS29CYkQyQwo2dlZlLzRydnFSWk9ZUEM0Zm1xOVR6NzhwU2YvMzZVcExJM3Vaemp4ZXhWUUIrWmRUdURIUXVUUElzcmczSVRTCmJJSWJ1K2Y0VFNmdzlFMm5Wb1VZOGFOaUk4YlZnT3B4SkM2NDFFN21yOFZXTDAzeU5IVGhRY05PcE9rY05YQTAKM3c1dHVtSVplL2VMOW5KSVhBY29IVi9HK1VyWFVFZDZyZnEwWkkvbktwaUVhNTZjR1BIN3V0RVk1Q3FxY3RlSQpURjNadmVqR1hvQUFhaVdKZ0JQM3lGRFRZMDlhdUlITG5wcFNKbHlhaVJaeENpTFlWb2xmQ0NZOUxzZXlodGpYCmNTWDdUTnpyZStrMWxsb0x6WEdtQjBQSmN1dERsdFFWcHZaVUpSVWovYkwwY2k3TkRHRzdUTTBDbTB3ZENtSWIKY2tJQlhqcm93cytsK2pIY2h2UTJQMG9yTUc4azhBdE80WWgyYnJkMGdyUzU0U1BBNWx6MStzeXREOUpKZE5TNwpURUpZUlVmVWQwOW9tR3BhMVZIWmpHNndhKzhFdTlUVnNzQWVoSk1hV1ZUN0hjclc5TERUWkxDdjlTVTZjLzA4ClgrU2l5OFVRZzFWZ2NlMFVDWjk1REFvWm44WVlNSk1NSnNpWDFJSGE2TmFRa29pVFdEOEYyT3ZPKy94Mjc3U3IKTjBOc0kyU2JySlJRRUVYS2Q3YmJGc1VJQ3R6T1RITFFXQkJTOE91VlQ3MlpkdHRyMUUzdVZiODFjaElaTWszbQo2OXFVaUNBVlhuQ1Y4SkdKZ0k1UTlVWUpKaW1nck5CWGxva2x2Zy9PV21heENMWHp6NCtDOEhjRzlqa05xUmZqCjVWTEZvSUVGUWZuWnk1Z1VveFE1QkRSbGs5aStUTjZNWlE9PQotLS0tLUVORCBDRVJUSUZJQ0FURS0tLS0tCg=="
  key.pem: "LS0tLS1CRUdJTiBQUklWQVRFIEtFWS0tLS0tCk1JSUpSQUlCQURBTkJna3Foa2lHOXcwQkFRRUZBQVNDQ1M0d2dna3FBZ0VBQW9JQ0FRRFgweDJvVUVjVTNlcWMKWUJhRGZ0bjgvM25aMXhMOUFqSjRUbmQyRThXRWNMVVVYTDFvakxlK0d1aUhMRGtLVFlmbHlSRDA5b0RDelNsTwozckRwM0ZtVFBzaitHaFArck5RTStVN1QvUkJOZkZ3Q3NLbGt0UnVNZ0hydlBkOUdrMjJ6ZCtlcU5ubUlXclE5CnJpRDl3aUpBUStNOExINGgrNFZ6TjJndkFpUHB6c01NQktmREZRWHYrNkRRbUtUaTEvY2NpL3Q4RTU5a3Jqa1QKdEM1WlpDc1JRZDFDcFdyNHpFNWlXVkdhQW1USDRwSUdueGlnOWpReGlxa1dqbmpFbWV6RnRNNDBDVGNTZVBRNApKbWFtRDJtbGN6UVdQT29WY2JFR2l1N1R3cVAxOFJyVSs2azVCRzJoL0NmWC9vVUtTSlcxNW9UVjZPMlVyQy9hCll0M21zUDcybTFJSFUrVHBXWmVXWkQ0ZmgrZVNrZ2dmMlZCTUUwRElSa1RmcDIzNmd6THRrNG9kbE05RzB0M2IKQjlHQWllWkF3MlVORG9HZnJvb1BvMnFzckJhcWU3QnFWODBESXQxV3diNXhPYlhtOVhpOVQzQjlVQnR0bzBQZwphdUdRLzg3QnIxK2s3a2FSUUpkY1MrQ2dwTUY4d0JIby9oS0duZnJwbWowaUcybmlDYkszMmhnMzJpb0V2d0hXCmJrU2F3V092VnFYVXVVcFo0NVhqRVQwTWtqQk55eG52L0daTDVQV1N5WEo5aXZWRmVyQWViSDlrcmYwZVNDSzgKY3JyaVhBc1R5eFFrOXNxblFrRTU2MVFDdUpKWmRISGc5YTRqaUI4S1plVVR2QWVWbUx3QzhPV3dYOTVQZk1LNgpxWjB6dm5GRVYvZ1I5ZjZpZm82VEdXUUpXSWxPeFFJREFRQUJBb0lDQUJMUS9XWXgvNHgrYjRpc0tQSlVjaWxvClZhV01Kb1BuOStIOHgxWUVVY1ZpOVNxZURrWnA5RkFPOVFScDh0d20xOGtOSDEwWUM3QlFKa0NSMGo5RlhvcmoKbjY3bHM2WVJ4OWdNdVZacW13d0NZbHc2cmo0Uk95SmtCalBMQTJjYURlZW1kY3hsZlBHS0pPbzJ2dm9ZdlpjNApRL3k0VFZQbG82UWdxY1RsYlIraWp1ZENsYVRBdGJpUFNkMDkzYXhJVTJ0SitnWStpTGhFcDBYRVFRRTZwaldXCk5qWHNDWmhBNmJtUjIzY3ZxNzB3ai9ZalUwaWZSbndtUUdrdXlURXMwVk9JV0t6NU83T3cxMnY0enh5OXZjSjIKdVkwUnlQL1BIblc1VWFxbEx0blBxRHoyNXZGSlpVeUkyU2x2NzRYdXY1eXhDUlpFUFVobnZiRk95dFZreTRtbwpCMkxJVjZsSEpyRHI0cFN0N2VZVEwybnh3WDU3VGFCajJ2YU5QMTFGZnhkenFIbCtqVnBSOFgrcWw5VEhpQTNZCnFMUXUrVUdsRkJOd2R1aVNQTi9aSTJQZUdtUmwzc0gwVTJ0enF0NnRLRzgramJvamF2aWZhdm9UYjVjWGEyNGEKMjR6YnBZYkphakwyYnlaczhOVmdiNlpjYVFPLzRQOE1BY0hGUXI5dnp4UkhmM3ZkbjIvbkxOTm9DRzJGYUh4Zgp6N0QyRG5rNmdBN1FTRlgwRm1xMHZwMGpXQmxqclBYMEFWdEJib3UyaDJKaE1sRUcyZ3dlOWl0NUd3WG83MjRNClhreDFqcWR6VDA1RFZiUnZjeTM2bEtWMFJNWnFwNFhuR0xub2FtaE0yQkYwdUpTNjhGL2I1cGlpVStRSE52YkQKNWx3eGhqUG01VmpPZ0FUZG55WUpBb0lCQVFEMlZ6QmcyR2NYNXp6bGhvQTNhdU1lL2tDUjR3Vjdjci9MemdPUQp3cmplVzZiOTdOeEdpTFM3SkhjaXkwc0lCTTNzUFNBcno2V3NFSTc2SjBxTC9GcjArdHpyMkQzVm00RE5ubnh6CmIwdzVRT2NMSkZPaUxOS0lmbmxVVUE1Rk5US3JCOU5NSk53MmFMU1dTcW5nZFdGTHMrZXd6dHZmNU1Gekt3R1IKV2JRNGdrc29GT3FpVWt1Z082QjVPaVRlbHJ3MXliSmhHQVhSaTlGeWdBb0JZMWpmOFY5VnoxSkkvRXFmV1k4WgpDcUNxV3g0MTVncmNaTWZCek13ZFBwVmcyc3FBQUlvZ0V0VDlEZnRmdEZRSTZpekNKSkN4bkVVZGJaamRyTEFNCjdVR2YydUVtaUFFWEtqZkhZVTlSL3hJbU9SaWQxMGNjMFQ5TnlmTEVzZUloSnNZSkFvSUJBUURnU1pwSkZpNWUKZjlXbnZFU1RBYSs1d3pMdW12UkdPK0psUjBzRHFoL1AwSFRqdTlPL1FaMUU3YlNWTjRXUlFZYUZ1Tm9BK1c4YQpCVUhkeFBTWVVKd0hZRTBNc05ZWGM1bERPSmpqYmMzTXNKeHZzUkNCRVNNTHBTMXpreEQrTlZwYjhJTmMzcHJNCllCL2JaVDdpNHcrTzQ5M2hvNVhwME0yakJPdDZxVExwUExKdC9RTkRseGVIWWI2eDJtcXhOcFhhNkFvMDA1eGEKSGRBOFNSMEdwRGR2TkZxUzdyYXVrQ0hCNzZleWkxbVliRmtSVFV3QzhZNDZKOURZdlZneUFLWWkrUFE5bzdGWApRWWladDFPdWtMWXFvUmlJaFRWOFZtWVhLWXc4bEpQclBoQ2JPQlhBRkYvcnFhL1o3ZnFRdjZqY0wxUEF0U2lnCmdvSTA5YjhRQzlIZEFvSUJBUUNPWlFuZkFWaGVkZGs2cUF2WGZONjZuS2ZBYktWUG5aNEdkaGlUaGl1TXhSZjcKY2Y1R2UyRlZTQmZoc2ZlMk0rakFwUGpDdW0zK3p6ZUduRTI0SzNCOGFjSm9SZ0JBU0hvazRYYjQxeDROZmxuUAprL2tRSnE2d0hjT09uQlFUcDFPWmo1VnhUMkZIeGpDVks2V1V6T1VuK0Y5MlVhekJlQjdtcnJaaVNhTW1neEprCm9lcWJWOHpGVzVKQVlQN005LzdsYktqQy9Ucm56TldPUlRzRFlHVVFWaHNRcEIzaGVJeStIZXZjd3NycWptOGgKSXMrbVpFOGYxSDBzYm0rMG8rUW9KNmV3TUpLVGtKQjgydVUwbmdDdlhLbVRNVXkyWFJMZkdLSlBacG5uaUlOYgpYWVNiMmxpUjFNc2dEN3h6QWRBYjlVUHpBWFdCUnJvaFB0NEM0Y0haQW9JQkFRREFuRlREK1NsKysvY21vaGFkCnpHLzFibjJaelRhRDdqK0JURlZPWTFZSWFITkpjMjducTFoODdrb0xidS9raTBvVUltZ05PQ2hDUjB1R1FQTHcKcnlFZmNJTWFwKzVqbTJGK0NlZTZQL3poa0xYM2NTN0VPRXhKWHVPR2drQ3dubTduejhkd0JMY1pWbDlsVVRCTgpOa09SS1h6Tm5tZEtzWWMzUFMxZ1hGZWRWd1BBVXV6dnFaeUtKZFhXOU1SMVJYUXgxdDJVK2prbVpyNENWNk4yCnBhWDVlUk5qWlY4NjBBbzlleXNmdUc0TDZOZ2dkS29YU1F3a1F6Y21Pb3kzL0Rpd2hlMXgxZGFoSVdWRzVOb1gKYXEwV05OeFZ1VmZ5WEZ3MS9mY3h1MExBWGI5ekhSb0lwemFzc2orVFByelVlOU51cTdJWUp6c3BoSXAvSXArZgpEeGQ5QW9JQkFRREJoOGZpMlZ4U0pkd2hKdkFWM2tsOUk4dGRMYmhLZ0xpdzF5WVROSnppT0xuWjhOQkxVMzk5CjU4Y2doWm9SUnVpY0x0TjNoYzZkYTlNSXMyWGM3cVBsOGhOaVBDenU0L0pXd3E1YVV2dE53WnBCUTVRd29HVVMKeDBCcjZlVmtDbkdPRUtBMTBtdGpFWGlDaVA2aEd0UGF1K2hsdXZtZHpDMWpmdGVkelUxeVQ4QTVsSldaZWJNYQpVQ3lEdnBvSHU4dy9zVWRjVFo4VyszUzhnWXpKTEczclBtZStTZlNMYWZhK0RoM2k0cVl3L0pyWGptWndRWTdLCkEyUGlTRXBGNGloSUdkQmVyZDNDY1R0RSsrRzV0a1dVWGFVU3o0UDAxVHZzVDRzTkNidmJXTktCYno4UDdPQkUKZW1IMEZLNDUxc2JLYWJBRzU1eW93TTdRMXM0VTJTQnYKLS0tLS1FTkQgUFJJVkFURSBLRVktLS0tLQo="
  ca.pem: "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUZKVENDQXcyZ0F3SUJBZ0lVZmpzeXNXMFY1czJkTXM4SnAvdUFlUy9palFJd0RRWUpLb1pJaHZjTkFRRUwKQlFBd0ZERVNNQkFHQTFVRUF3d0piRzlqWVd4b2IzTjBNQjRYRFRJME1USXdOVEEzTVRnMU1sb1hEVEkxTVRFeQpOakEzTVRnMU1sb3dGREVTTUJBR0ExVUVBd3dKYkc5allXeG9iM04wTUlJQ0lqQU5CZ2txaGtpRzl3MEJBUUVGCkFBT0NBZzhBTUlJQ0NnS0NBZ0VBMTlNZHFGQkhGTjNxbkdBV2czN1ovUDk1MmRjUy9RSXllRTUzZGhQRmhIQzEKRkZ5OWFJeTN2aHJvaHl3NUNrMkg1Y2tROVBhQXdzMHBUdDZ3NmR4Wmt6N0kvaG9UL3F6VURQbE8wLzBRVFh4YwpBckNwWkxVYmpJQjY3ejNmUnBOdHMzZm5xalo1aUZxMFBhNGcvY0lpUUVQalBDeCtJZnVGY3pkb0x3SWo2YzdECkRBU253eFVGNy91ZzBKaWs0dGYzSEl2N2ZCT2ZaSzQ1RTdRdVdXUXJFVUhkUXFWcStNeE9ZbGxSbWdKa3grS1MKQnA4WW9QWTBNWXFwRm81NHhKbnN4YlRPTkFrM0VuajBPQ1ptcGc5cHBYTTBGanpxRlhHeEJvcnUwOEtqOWZFYQoxUHVwT1FSdG9md24xLzZGQ2tpVnRlYUUxZWp0bEt3djJtTGQ1ckQrOXB0U0IxUGs2Vm1YbG1RK0g0Zm5rcElJCkg5bFFUQk5BeUVaRTM2ZHQrb015N1pPS0haVFBSdExkMndmUmdJbm1RTU5sRFE2Qm42NktENk5xckt3V3FudXcKYWxmTkF5TGRWc0crY1RtMTV2VjR2VTl3ZlZBYmJhTkQ0R3Joa1AvT3dhOWZwTzVHa1VDWFhFdmdvS1RCZk1BUgo2UDRTaHAzNjZabzlJaHRwNGdteXQ5b1lOOW9xQkw4QjFtNUVtc0ZqcjFhbDFMbEtXZU9WNHhFOURKSXdUY3NaCjcveG1TK1Qxa3NseWZZcjFSWHF3SG14L1pLMzlIa2dpdkhLNjRsd0xFOHNVSlBiS3AwSkJPZXRVQXJpU1dYUngKNFBXdUk0Z2ZDbVhsRTd3SGxaaThBdkRsc0YvZVQzekN1cW1kTTc1eFJGZjRFZlgrb242T2t4bGtDVmlKVHNVQwpBd0VBQWFOdk1HMHdIUVlEVlIwT0JCWUVGRXFhMEhVemwvc0hVSHZLTjNUc0M5c0N3c1JnTUI4R0ExVWRJd1FZCk1CYUFGRXFhMEhVemwvc0hVSHZLTjNUc0M5c0N3c1JnTUE4R0ExVWRFd0VCL3dRRk1BTUJBZjh3R2dZRFZSMFIKQkJNd0VZSVBjbk41YzJ4dlp5NXljM2x6Ykc5bk1BMEdDU3FHU0liM0RRRUJDd1VBQTRJQ0FRQVJnS29CYkQyQwo2dlZlLzRydnFSWk9ZUEM0Zm1xOVR6NzhwU2YvMzZVcExJM3Vaemp4ZXhWUUIrWmRUdURIUXVUUElzcmczSVRTCmJJSWJ1K2Y0VFNmdzlFMm5Wb1VZOGFOaUk4YlZnT3B4SkM2NDFFN21yOFZXTDAzeU5IVGhRY05PcE9rY05YQTAKM3c1dHVtSVplL2VMOW5KSVhBY29IVi9HK1VyWFVFZDZyZnEwWkkvbktwaUVhNTZjR1BIN3V0RVk1Q3FxY3RlSQpURjNadmVqR1hvQUFhaVdKZ0JQM3lGRFRZMDlhdUlITG5wcFNKbHlhaVJaeENpTFlWb2xmQ0NZOUxzZXlodGpYCmNTWDdUTnpyZStrMWxsb0x6WEdtQjBQSmN1dERsdFFWcHZaVUpSVWovYkwwY2k3TkRHRzdUTTBDbTB3ZENtSWIKY2tJQlhqcm93cytsK2pIY2h2UTJQMG9yTUc4azhBdE80WWgyYnJkMGdyUzU0U1BBNWx6MStzeXREOUpKZE5TNwpURUpZUlVmVWQwOW9tR3BhMVZIWmpHNndhKzhFdTlUVnNzQWVoSk1hV1ZUN0hjclc5TERUWkxDdjlTVTZjLzA4ClgrU2l5OFVRZzFWZ2NlMFVDWjk1REFvWm44WVlNSk1NSnNpWDFJSGE2TmFRa29pVFdEOEYyT3ZPKy94Mjc3U3IKTjBOc0kyU2JySlJRRUVYS2Q3YmJGc1VJQ3R6T1RITFFXQkJTOE91VlQ3MlpkdHRyMUUzdVZiODFjaElaTWszbQo2OXFVaUNBVlhuQ1Y4SkdKZ0k1UTlVWUpKaW1nck5CWGxva2x2Zy9PV21heENMWHp6NCtDOEhjRzlqa05xUmZqCjVWTEZvSUVGUWZuWnk1Z1VveFE1QkRSbGs5aStUTjZNWlE9PQotLS0tLUVORCBDRVJUSUZJQ0FURS0tLS0tCg=="
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: syslog
  labels:
    helm.sh/chart: rsyslog-tls-0.1.1
    app.kubernetes.io/name: rsyslog-tls
    app.kubernetes.io/instance: rysylog
    app.kubernetes.io/version: "0.1.0"
    app.kubernetes.io/managed-by: Helm
data:
  my-syslog.conf:   |-
    *.* /var/log/rsyslog-remote.log
    $RepeatedMsgReduction on
  my-logrotate.conf:   |-
    /var/log/my.log {
        rotate 3
        copytruncate
        size 100M
        missingok
        compress
        daily
    }
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: syslogs
  labels:
    helm.sh/chart: rsyslog-tls-0.1.1
    app.kubernetes.io/name: rsyslog-tls
    app.kubernetes.io/instance: rysylog
    app.kubernetes.io/version: "0.1.0"
    app.kubernetes.io/managed-by: Helm
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 10Gi
---
apiVersion: v1
kind: Service
metadata:
  name: rysylog-rsyslog-tls
  labels:
    helm.sh/chart: rsyslog-tls-0.1.1
    app.kubernetes.io/name: rsyslog-tls
    app.kubernetes.io/instance: rysylog
    app.kubernetes.io/version: "0.1.0"
    app.kubernetes.io/managed-by: Helm
spec:
  type: ClusterIP
  ports:
    - port: 514
      targetPort: syslog
      protocol: TCP
      name: syslog
  selector:
    app.kubernetes.io/name: rsyslog-tls
    app.kubernetes.io/instance: rysylog
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: rysylog-rsyslog-tls
  labels:
    helm.sh/chart: rsyslog-tls-0.1.1
    app.kubernetes.io/name: rsyslog-tls
    app.kubernetes.io/instance: rysylog
    app.kubernetes.io/version: "0.1.0"
    app.kubernetes.io/managed-by: Helm
spec:
  replicas: 1
  selector:
    matchLabels:
      app.kubernetes.io/name: rsyslog-tls
      app.kubernetes.io/instance: rysylog
  template:
    metadata:
      labels:
        app.kubernetes.io/name: rsyslog-tls
        app.kubernetes.io/instance: rysylog
    spec:
      containers:
        - name: rsyslog-tls
          image: "yadavankur95/rsyslog-tls-server:latest"
          imagePullPolicy: IfNotPresent
          env:
            - name: ROTATE_SCHEDULE
              value: "0 * * * *"
            - name: CRON_LOG_LEVEL
              value: "8"
            - name: DO_LOG_ALL
              value: "true"
            - name: DO_DUMP_TO_STDOUT
              value: "true"
            - name: RSYSLOG_PORT
              value: "6514"
          ports:
            - name: syslog
              containerPort: 6514
              protocol: TCP
          livenessProbe:
            tcpSocket:
              port: syslog
          readinessProbe:
            tcpSocket:
              port: syslog
          volumeMounts:
            - name: var
              mountPath: /var/log
            - name: config
              mountPath: /etc/rsyslog.d/my-syslog.conf
              subPath: my-syslog.conf
            - name: config
              mountPath: /etc/logrotate.d/my-logrotate.conf
              subPath: my-logrotate.conf
            - name: rsyslog-ssl-cert
              mountPath: /etc/rsyslog/ssl
          resources:
            {}
      volumes:
        - name: var
          persistentVolumeClaim:
            claimName: syslogs
        - name: config
          configMap:
            name: syslog
        - name: rsyslog-ssl-cert
          secret:
            secretName: rysylog-rsyslog-tls-cert
```