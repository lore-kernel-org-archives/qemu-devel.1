Received: from eggs.gnu.org ([2001:4830:134:3::10]:48950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <robert.hu@intel.com>) id 1dc66s-00019I-7i
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 04:31:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <robert.hu@intel.com>) id 1dc66n-00055T-Bu
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 04:31:30 -0400
From: "Hu, Robert" <robert.hu@intel.com>
Date: Mon, 31 Jul 2017 08:29:32 +0000
Message-ID: <9E79D1C9A97CFD4097BCE431828FDD3115719A01@SHSMSX103.ccr.corp.intel.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] qemu guest agent support 'guest-exec'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-discuss@nongnu.org" <qemu-discuss@nongnu.org>

Hi,

>From $qemu_src/qga/ code, guest-exec should be supported.
But from $qemu_src/scripts/qmp/qemu-ga-client output, it is not supported, =
on client side. Why didn't implement on client side? or any configuration I=
 missed?

Best Regards,
Robert Hoo
