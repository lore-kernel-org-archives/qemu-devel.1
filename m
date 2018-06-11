Received: from eggs.gnu.org ([2001:4830:134:3::10]:58829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fSQiX-0004iz-CU
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:34:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fSQiU-0005PO-Qd
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:34:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40520)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fSQiU-0005PB-JN
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:34:54 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 11 Jun 2018 14:34:51 -0300
Message-Id: <20180611173452.28087-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 0/1] Machine queue, 2018-06-11
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

The following changes since commit 9f55925b8f50a962d1d08d815044db7767ae3838:

  Merge remote-tracking branch 'remotes/vivier/tags/m68k-for-3.0-pull-request' into staging (2018-06-11 12:46:16 +0100)

are available in the Git repository at:

  git://github.com/ehabkost/qemu.git tags/machine-next-pull-request

for you to fetch changes up to 0f5319ea25fb0a05827d512859b7c7d23371ac5d:

  cli: Don't run early event loop if no --preconfig was specified (2018-06-11 14:25:49 -0300)

----------------------------------------------------------------
Machine queue, 2018-06-11

* Fix -daemonize hang caused by --preconfig code

----------------------------------------------------------------

Queue for Machine Core patches


Igor Mammedov (1):
  cli: Don't run early event loop if no --preconfig was specified

 vl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.18.0.rc1.1.g3f1ff2140
