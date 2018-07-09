Received: from eggs.gnu.org ([2001:4830:134:3::10]:41433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fcZrg-000412-NR
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 13:22:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fcZrc-0005W2-93
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 13:22:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54354)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fcZrc-0005UB-3h
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 13:22:16 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon,  9 Jul 2018 14:22:05 -0300
Message-Id: <20180709172206.6334-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 0/1] x86 fix for -rc0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <rth@twiddle.net>

The following changes since commit 43a473993fd9378bf850dcafa68eb6dee8c300f8:

  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2018-07-06 18:18:08 +0100)

are available in the Git repository at:

  git://github.com/ehabkost/qemu.git tags/x86-next-pull-request

for you to fetch changes up to 97e50dd013fbf2643a3b3f693a72159de5d25b50:

  pc: Fix typo on PC_COMPAT_2_12 (2018-07-09 14:20:57 -0300)

----------------------------------------------------------------
x86 fix for -rc0

* Fix EPYC-IBPB compat code

----------------------------------------------------------------

Eduardo Habkost (1):
  pc: Fix typo on PC_COMPAT_2_12

 include/hw/i386/pc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.18.0.rc1.1.g3f1ff2140
