Received: from eggs.gnu.org ([2001:4830:134:3::10]:47104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a175818323@gmail.com>) id 1cdg59-0003h4-J8
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 11:36:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a175818323@gmail.com>) id 1cdg58-0001vp-I0
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 11:35:59 -0500
MIME-Version: 1.0
From: Bob Chen <a175818323@gmail.com>
Date: Wed, 15 Feb 2017 00:35:52 +0800
Message-ID: <CAMxP3BSs+y33UtSm5VUjdiGAVYW0wsdd6i=RnMdcZ9xw0LCp5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] How to upgrade QEMU?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-discuss@nongnu.org, qemu-devel@nongnu.org

Hi folks,

I am about to upgrade my QEMU version from an ancient 1.1.2 to the latest.
My plan is to override all the installing files with the new ones. Since I
used to rename all the qemu-xxx binaries under /usr/local/bin with a
specified version suffix, so they are not my concern.

 Just wondering if it is safe to replace those /usr/local/share files (ROM
and keymaps?), while some some of my QEMU guests are still running
in-flight.

Regards,
Bob
