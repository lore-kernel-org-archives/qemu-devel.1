Received: from eggs.gnu.org ([2001:4830:134:3::10]:50241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vfeenstr@redhat.com>) id 1cvIEi-000099-Bd
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 02:46:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vfeenstr@redhat.com>) id 1cvIEe-0007T4-BL
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 02:46:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57836)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vfeenstr@redhat.com>) id 1cvIEe-0007Sb-5j
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 02:46:36 -0400
From: Vinzenz 'evilissimo' Feenstra <vfeenstr@redhat.com>
Date: Tue,  4 Apr 2017 08:46:30 +0200
Message-Id: <20170404064631.16287-1-vfeenstr@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/1] qga: Add 'guest-get-host-name' command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: sameeh@daynix.com, mdroth@linux.vnet.ibm.com, Vinzenz Feenstra <vfeenstr@redhat.com>

From: Vinzenz Feenstra <vfeenstr@redhat.com>

Since v1:
- Renamed from FQDN to hostname and expanded documentation

Vinzenz Feenstra (1):
  qga: Add 'guest-get-host-name' command

 qga/commands.c       | 11 +++++++++++
 qga/qapi-schema.json | 29 +++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

-- 
2.9.3
