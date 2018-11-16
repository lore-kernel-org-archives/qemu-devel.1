Received: from eggs.gnu.org ([2001:4830:134:3::10]:57652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gNV2s-0000j6-5P
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 22:43:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gNV2m-0007ku-K9
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 22:43:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49354)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1gNV2f-0007hz-V6
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 22:43:38 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 16 Nov 2018 11:43:30 +0800
Message-Id: <1542339811-18549-1-git-send-email-jasowang@redhat.com>
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

The following changes since commit d835c6192495dc5b2c3a15a0761eb57d8d310828:

  Merge remote-tracking branch 'remotes/stefanberger/tags/pull-tpm-2018-11-15-1' into staging (2018-11-15 14:18:25 +0000)

are available in the git repository at:

  https://github.com/jasowang/qemu.git tags/net-pull-request

for you to fetch changes up to 013a62020a92f371555c67342424f2f944b62be4:

  net/filter-rewriter.c: Fix coverity static analysis issue (2018-11-16 11:08:26 +0800)

----------------------------------------------------------------

----------------------------------------------------------------
Zhang Chen (1):
      net/filter-rewriter.c: Fix coverity static analysis issue

 net/filter-rewriter.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)
