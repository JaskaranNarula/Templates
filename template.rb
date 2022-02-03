<%- report_headers 'Server IP', 'Server Hostname', 'Operating System', 'Current Kernel Version', 'Patch Release Date', 'Erratum ID', 'CVEs' -%>
<%- load_hosts(search: input('Hosts filter'), includes: [:operatingsystem, :subscriptions, :interfaces, :applicable_errata], preload: [:operatingsystem, :lifecycle_environment, :kernel_release, :owner]).each_record do |host| -%>
<%-   host_applicable_errata_filtered(host, input('Errata filter')).each do |erratum| -%>
<%-     report_row(
          'Server IP': host.ip,
          'Server Hostname': host.name,
          'Operating System': host.operatingsystem,
          'Current Kernel Version': host_kernel_release(host),
          'Patch Release Date': erratum.created_at,
          'Erratum ID': erratum.errata_id,
          'CVEs': erratum.cves.map { |c| c.cve_id },
        ) -%>
<%-   end -%>
