Received: from eggs.gnu.org ([2001:4830:134:3::10]:56344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dongli.zhang@oracle.com>) id 1fXNi3-00028c-FJ
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 05:22:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dongli.zhang@oracle.com>) id 1fXNhy-0004LI-JR
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 05:22:55 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:47932)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dongli.zhang@oracle.com>)
	id 1fXNhy-0004KA-AW
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 05:22:50 -0400
From: Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <bfc0c8da-0563-0115-955a-80f463389fa6@oracle.com>
Date: Mon, 25 Jun 2018 17:22:40 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] Why qom-get is not available in qemu monitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com

Hi,

Would you mind help confirm why qom-get command is not supported by qemu
monitor, but only qapi?

Is this a feature (qom-get in monitor) totally useless for some reason, or it is
still not implemented yet?

Thank you very much!

Dongli Zhang
