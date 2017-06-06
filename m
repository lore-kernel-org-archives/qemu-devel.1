Received: from eggs.gnu.org ([2001:4830:134:3::10]:38588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dICJQ-0005j8-Ie
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 07:06:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dICJL-0002wa-17
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 07:06:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59538)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dICJK-0002wP-Qz
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 07:06:06 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue,  6 Jun 2017 12:05:54 +0100
Message-Id: <20170606110556.12922-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/2] Document deprecated features & support
 lifecycle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

This is a followup to

  v1: https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg02390.html

The goal is to clarify to users & app developers what they can expect
from QEMU in terms of feature lifecycle & any deprecation policy should
it be neccessary to remove features.

Changed in v2:

 - Split into 2 patches so we can consider each suggested addition
   independantly.

Daniel P. Berrange (2):
  docs: document deprecated features in appendix
  docs: document support lifetime for features

 qemu-doc.texi | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

-- 
2.9.3
