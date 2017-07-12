Received: from eggs.gnu.org ([2001:4830:134:3::10]:39023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batmanustc@gmail.com>) id 1dVDuL-0005YM-TE
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 05:26:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <batmanustc@gmail.com>) id 1dVDuL-0003cb-5M
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 05:26:09 -0400
MIME-Version: 1.0
From: Sam <batmanustc@gmail.com>
Date: Wed, 12 Jul 2017 17:24:40 +0800
Message-ID: <CAOE=1Z3ve+zQJbjqqfNA1iB_mNgFkoTTXRxyBikSiJ5_AZwpiA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] How to stop `qemu-system-x86_64 ...` instead of `kill
 -9`?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-discuss@nongnu.org, qemu-devel@nongnu.org

hi all,

I'm running `qemu-system-x86_64 ...` to start a guest vm. Now I want to
stop and destroy this vm, I found there is no `qemu-stop` related command,
so I have to `kill -9` this process.

How could I stop `qemu-system-x86_64` instead of `kill -9`? Use `virsh`
command or something?

Thank you~
