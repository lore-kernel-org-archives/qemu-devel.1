Received: from eggs.gnu.org ([208.118.235.92]:35828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nt_mahmood@yahoo.com>) id 1gbQQ4-0005AR-UO
	for qemu-devel@nongnu.org; Mon, 24 Dec 2018 08:37:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nt_mahmood@yahoo.com>) id 1gbQQ0-0001Ji-Ps
	for qemu-devel@nongnu.org; Mon, 24 Dec 2018 08:37:20 -0500
Received: from sonic307-2.consmr.mail.bf2.yahoo.com ([74.6.134.41]:45219)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <nt_mahmood@yahoo.com>)
	id 1gbQQ0-00012Z-4z
	for qemu-devel@nongnu.org; Mon, 24 Dec 2018 08:37:16 -0500
Date: Mon, 24 Dec 2018 13:37:09 +0000 (UTC)
From: Mahmood Naderan <nt_mahmood@yahoo.com>
Reply-To: Mahmood Naderan <nt_mahmood@yahoo.com>
Message-ID: <1331563461.8744117.1545658629989@mail.yahoo.com>
MIME-Version: 1.0
References: <1331563461.8744117.1545658629989.ref@mail.yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] How to view guest window with "ssh -Y"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Qemu-discuss <qemu-discuss@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Hi

Without specifying -vnc option, I can view the guest window normally. However, when I use "ssh -Y compute-0-0" where I want to run qemu-system-x86_64 on a node, it gives me a vnc port.


Is that normal? How can I fix it in order to view the the guest window by ssh X11 forwarding?



Regards,
Mahmood
