Received: from eggs.gnu.org ([2001:4830:134:3::10]:51855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eJdyp-00028O-QC
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 06:23:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eJdyl-00046g-Sr
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 06:23:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47488)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eJdyl-00046Q-Md
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 06:23:07 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue, 28 Nov 2017 11:23:00 +0000
Message-Id: <20171128112301.5636-1-berrange@redhat.com>
Subject: [Qemu-devel] [PULL (for 2.11) v1 0/1] Merge io 2017/11/28
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Daniel P. Berrange" <berrange@redhat.com>

The following changes since commit 5e19aed59ab48ca3c7f1e2da203eed27b91bef2d:

  Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-2.11-20171127' into staging (2017-11-27 11:16:20 +0000)

are available in the Git repository at:

  git://github.com/berrange/qemu tags/pull-qio-2017-11-28-1

for you to fetch changes up to 2d7ad7c05e762d5b10a57eba9af1bb6b41700854:

  sockets: avoid crash when cleaning up sockets for an invalid FD (2017-11-28 10:48:04 +0000)

----------------------------------------------------------------
Merge qio 2017/11/28 v1

----------------------------------------------------------------

Daniel P. Berrange (1):
  sockets: avoid crash when cleaning up sockets for an invalid FD

 util/qemu-sockets.c | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.14.3
