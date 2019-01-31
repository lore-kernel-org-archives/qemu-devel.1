Received: from eggs.gnu.org ([209.51.188.92]:53255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1gpAH6-0005fi-FP
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 06:12:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1gpAH5-0004Ib-TF
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 06:12:52 -0500
From: Programmingkid <programmingkidx@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Message-Id: <56F356E9-04E0-4419-91BD-55CC91C853E1@gmail.com>
Date: Thu, 31 Jan 2019 06:12:23 -0500
Subject: [Qemu-devel] qemu_vga.drv missing 256 colors support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

After testing a recent commit of QEMU I noticed that 256 color support =
is missing in Mac OS 9's color options. A lot of games refuse to run =
without being able to set the monitor to 256 colors. Could we have this =
option added?=20

Thank you.=
