Received: from eggs.gnu.org ([2001:4830:134:3::10]:55273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cjn1S-00047G-HA
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 08:13:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cjn1P-0008NN-DE
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 08:13:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51570)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cjn1P-0008MS-7J
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 08:13:23 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri,  3 Mar 2017 10:13:16 -0300
Message-Id: <20170303131317.23617-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 0/1] NUMA documentation update
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org

Sorry for sending this after soft freeze. I just noticed that it
went through the cracks and I believe the documentation update is
relevant and simple enough to be included in 2.9.

The following changes since commit 508e038a5d725f2aa729f58a1f5209b9be4227de:

  dtc: Revert unintentional submodule downgrade from commit 077dd74239a99 (2017-03-03 12:48:42 +0000)

are available in the git repository at:

  git://github.com/ehabkost/qemu.git tags/numa-pull-request

for you to fetch changes up to 4b9a5dd762ae41acd7df741de3e554b319a2cced:

  qemu-options: Rewrite -numa documentation (2017-03-03 10:08:03 -0300)

----------------------------------------------------------------
NUMA documentation update

----------------------------------------------------------------

Eduardo Habkost (1):
  qemu-options: Rewrite -numa documentation

 qemu-options.hx | 38 ++++++++++++++++++++++++++++----------
 1 file changed, 28 insertions(+), 10 deletions(-)

-- 
2.11.0.259.g40922b1
