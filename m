Received: from eggs.gnu.org ([2001:4830:134:3::10]:35798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eniN4-0000pZ-BD
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 05:08:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eniN1-0001ID-3n
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 05:08:30 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35422 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1eniN0-0001HH-Vj
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 05:08:27 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon, 19 Feb 2018 11:08:11 +0100
Message-Id: <20180219100812.12860-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 0/1] stable process documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>, Eric Blake <eblake@redhat.com>, Cornelia Huck <cohuck@redhat.com>

The following changes since commit e5ecc287a7bd24a1364e23e263cb60cfc8d21eb5:

  Merge remote-tracking branch 'remotes/dgilbert/tags/pull-hmp-20180216' into staging (2018-02-16 18:39:05 +0000)

are available in the git repository at:

  git://github.com/cohuck/qemu tags/stable-doc-20180219

for you to fetch changes up to 7aa54229cfd24935d5d7bcc48534fe01934f3f52:

  docs: document our stable process (2018-02-19 10:51:16 +0100)

----------------------------------------------------------------
Add some doc for the stable process.

----------------------------------------------------------------

Cornelia Huck (1):
  docs: document our stable process

 docs/devel/stable-process.rst | 69 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 docs/devel/stable-process.rst

-- 
2.13.6
