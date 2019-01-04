Received: from eggs.gnu.org ([208.118.235.92]:49426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nt_mahmood@yahoo.com>) id 1gfM3d-0002TL-6u
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 04:46:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nt_mahmood@yahoo.com>) id 1gfM3X-0004bY-L0
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 04:46:23 -0500
Received: from sonic307-2.consmr.mail.bf2.yahoo.com ([74.6.134.41]:46307)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <nt_mahmood@yahoo.com>)
	id 1gfM3V-0004YY-Tq
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 04:46:18 -0500
Date: Fri, 4 Jan 2019 09:46:14 +0000 (UTC)
From: Mahmood Naderan <nt_mahmood@yahoo.com>
Reply-To: Mahmood Naderan <nt_mahmood@yahoo.com>
Message-ID: <644741810.12894899.1546595174906@mail.yahoo.com>
MIME-Version: 1.0
References: <644741810.12894899.1546595174906.ref@mail.yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] Memory limit of a windows guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Qemu-discuss <qemu-discuss@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

Hi
Is there any limitation for the guest memory? I have defined "-m 40000" for a windows guest while the host have 64GB of memory. However, in the windows, I see only 16GB of physical memory.
Any thought?

Regards,
Mahmood
