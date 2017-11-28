Received: from eggs.gnu.org ([2001:4830:134:3::10]:45249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eJiXp-0005bT-Uv
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 11:15:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eJiXn-00040Q-Jt
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 11:15:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57018)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eJiXn-0003zk-Do
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 11:15:35 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue, 28 Nov 2017 16:15:27 +0000
Message-Id: <20171128161529.3025-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] qemu-options: document missing memory
 backend items
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Hu Tao <hutao@cn.fujitsu.com>, Stefan Hajnoczi <stefanha@redhat.com>

This series adds several missing items to the QEMU documentation on memory
backends.

Stefan Hajnoczi (2):
  qemu-options: document missing memory-backend-file options
  qemu-options: document memory-backend-ram

 qemu-options.hx | 55 ++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 48 insertions(+), 7 deletions(-)

-- 
2.14.3
