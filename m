Received: from eggs.gnu.org ([2001:4830:134:3::10]:49626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1f1l6c-0003G9-6W
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 23:53:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1f1l6Z-0000GU-2O
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 23:53:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58292 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1f1l6Y-0000GD-Tw
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 23:53:30 -0400
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 30 Mar 2018 11:53:15 +0800
Message-Id: <1522381996-19462-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL] Net patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: Jason Wang <jasowang@redhat.com>

The following changes since commit 47d3b60858d90ac8a0cc3a72af7f95c96781125a:

  Merge remote-tracking branch 'remotes/riscv/tags/riscv-qemu-2.12-important-fixes' into staging (2018-03-28 22:13:38 +0100)

are available in the git repository at:

  https://github.com/jasowang/qemu.git tags/net-pull-request

for you to fetch changes up to abbbb0350d780e24d2f6a0cf8fc3191badb0329a:

  qemu-doc: Rework the network options chapter to make "-net" less prominent (2018-03-30 11:44:11 +0800)

----------------------------------------------------------------

----------------------------------------------------------------
Thomas Huth (1):
      qemu-doc: Rework the network options chapter to make "-net" less prominent

 qemu-options.hx | 189 ++++++++++++++++++++++++++++----------------------------
 1 file changed, 94 insertions(+), 95 deletions(-)
