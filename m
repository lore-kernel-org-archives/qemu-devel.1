Received: from eggs.gnu.org ([2001:4830:134:3::10]:58464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pradeepkiruvale@gmail.com>) id 1daKxc-0005Xe-Ms
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 07:58:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pradeepkiruvale@gmail.com>) id 1daKxc-0005CA-0V
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 07:58:40 -0400
MIME-Version: 1.0
From: Pradeep Kiruvale <pradeepkiruvale@gmail.com>
Date: Wed, 26 Jul 2017 13:58:36 +0200
Message-ID: <CAJ2SuLnK+E5z5igsA4oCUfysJTmqYYTd3rEnyGCXHANVtOconA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] vsock Vs 9p Vs block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, "qemu-discuss@nongnu.org" <qemu-discuss@nongnu.org>

Hi All,

I am trying to compare nfs-vsock, virtio-9p, block drives to know
which is better in terms of performance to share the files between the
guest and host.

If someone did some kind of a benchmarking of Vsock Vs 9P Vs block,
please share the results/numbers.

Regards,
Pradeep
