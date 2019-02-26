Received: from eggs.gnu.org ([209.51.188.92]:53226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nagarwal@xilinx.com>) id 1gydUV-00017f-Ck
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 09:13:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nagarwal@xilinx.com>) id 1gydUQ-0005MY-R7
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 09:13:48 -0500
Received: from mail-eopbgr770044.outbound.protection.outlook.com
	([40.107.77.44]:23648
	helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nagarwal@xilinx.com>) id 1gydUQ-0005Lg-EK
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 09:13:46 -0500
From: Nikhil Agarwal <nagarwal@xilinx.com>
Date: Tue, 26 Feb 2019 14:13:43 +0000
Message-ID: <MN2PR02MB580680857B3390A2447B512DB67B0@MN2PR02MB5806.namprd02.prod.outlook.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] Virtio-net control queue handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Nikhil Agarwal <nagarwal@xilinx.com>

Hi All,

Is there any option in QEMU to offload virtio device control queue handling=
 to backend instead of deciphering and passing to libvirt via QMP? if not, =
is there any interface in libvirt which passes on these message to applicat=
ion or i directly use QMP interface from QEMU?

Regards
Nikhil

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
