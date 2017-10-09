Received: from eggs.gnu.org ([2001:4830:134:3::10]:50591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gugnani.2@buckeyemail.osu.edu>) id 1e1dSf-0004TZ-5K
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 15:11:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gugnani.2@buckeyemail.osu.edu>) id 1e1dSc-0002GY-09
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 15:11:33 -0400
Received: from mail-bl2nam02on0132.outbound.protection.outlook.com
	([104.47.38.132]:22848
	helo=NAM02-BL2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <gugnani.2@buckeyemail.osu.edu>)
	id 1e1dSb-0002G5-Mu
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 15:11:29 -0400
From: "Gugnani, Shashank" <gugnani.2@buckeyemail.osu.edu>
Date: Mon, 9 Oct 2017 19:11:27 +0000
Message-ID: <CY4PR0101MB291815E29308B3C75D26876FE9740@CY4PR0101MB2918.prod.exchangelabs.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] Co-routine re-entered recursively
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Hi,


I'm trying to modify the NVMe emulator in QEMU to use multiple threads.

After making necessary changes, I see this error: 'Co-routine re-entered re=
cursively'

Can anybody tell me the reason for this error? Is there anything I can do t=
o fix this issue?


Thanks,

Shashank
