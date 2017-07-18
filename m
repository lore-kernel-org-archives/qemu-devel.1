Received: from eggs.gnu.org ([2001:4830:134:3::10]:42653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dXPoQ-0004r1-P0
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:33:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dXPoM-0005hj-E9
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:33:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56778)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dXPoM-0005gv-8N
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:33:02 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue, 18 Jul 2017 11:32:50 +0100
Message-Id: <20170718103251.20657-1-berrange@redhat.com>
Subject: [Qemu-devel] [PULL v1 0/1] Merge I/O 2017/07/18
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

The following changes since commit 9964e96dc9999cf7f7c936ee854a795415d19b60:

  Merge remote-tracking branch 'jasowang/tags/net-pull-request' into staging (2017-05-23 15:01:31 +0100)

are available in the git repository at:

  git://github.com/berrange/qemu tags/pull-qio-2017-07-18-1

for you to fetch changes up to 8f7168b34323ceec4d5faff797e7bcf1be57e6be:

  io: simplify qio_channel_attach_aio_context (2017-05-26 10:38:08 +0100)

----------------------------------------------------------------
Merge I/O 2017/07/18 v1

----------------------------------------------------------------
Paolo Bonzini (1):
  io: simplify qio_channel_attach_aio_context

 io/channel.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

-- 
2.13.0
