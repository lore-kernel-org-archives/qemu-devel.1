Received: from eggs.gnu.org ([2001:4830:134:3::10]:33030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eJX5F-0001tF-Ax
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 23:01:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eJX5A-0000Fc-Ii
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 23:01:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34402)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1eJX5A-0000Eu-DU
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 23:01:16 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 28 Nov 2017 12:01:08 +0800
Message-Id: <1511841669-14505-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL] Net patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>

The following changes since commit 5e19aed59ab48ca3c7f1e2da203eed27b91bef2d:

  Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-2.11-20171127' into staging (2017-11-27 11:16:20 +0000)

are available in the git repository at:

  https://github.com/jasowang/qemu.git tags/net-pull-request

for you to fetch changes up to 70e53e6e4da3db4b2c31981191753a7e974936d0:

  virtio-net: don't touch virtqueue if vm is stopped (2017-11-28 11:54:50 +0800)

----------------------------------------------------------------

----------------------------------------------------------------
Jason Wang (1):
      virtio-net: don't touch virtqueue if vm is stopped

 hw/net/virtio-net.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)
