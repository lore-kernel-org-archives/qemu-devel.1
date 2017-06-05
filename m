Received: from eggs.gnu.org ([2001:4830:134:3::10]:37059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1dHuMR-0003ty-4B
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 11:56:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1dHuMN-0008Sr-VQ
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 11:56:07 -0400
Received: from [62.254.189.133] (port=14394 helo=centos.localdomain)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1dHuMN-0007ur-C4
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 11:56:03 -0400
From: Felipe Franciosi <felipe@nutanix.com>
Date: Mon,  5 Jun 2017 16:55:17 +0100
Message-Id: <1496678118-27350-1-git-send-email-felipe@nutanix.com>
Subject: [Qemu-devel] [PATCH v2] spapr: Allow boot from vhost-*-scsi backends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Alexey Kardashevskiy <aik@ozlabs.ru>, Alexander Graf <agraf@suse.de>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Mike Cui <cui@nutanix.com>, Felipe Franciosi <felipe@nutanix.com>

v1->v2: Elaborate commit message further.

Felipe Franciosi (1):
  spapr: Allow boot from vhost-*-scsi backends

 hw/ppc/spapr.c | 8 ++++++++
 1 file changed, 8 insertions(+)

-- 
1.9.5
