Received: from eggs.gnu.org ([2001:4830:134:3::10]:48842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dongli.zhang@oracle.com>) id 1gP5Ev-00017I-1o
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 07:34:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dongli.zhang@oracle.com>) id 1gP5Eu-0006Ph-Cg
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 07:34:49 -0500
From: Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <afa43fbb-98e0-f6e7-0d41-e7005501e256@oracle.com>
Date: Tue, 20 Nov 2018 20:34:34 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] When AioHandler->is_external=true?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Qemu-block <qemu-block@nongnu.org>
Cc: qemu-devel@nongnu.org, famz@redhat.com

Hi,

Would you please help explain in which case AioHandler->is_external is true, and
when it is false?

I read about iothread and mainloop and I am little bit confused about it.

Thank you very much!

Dongli Zhang
