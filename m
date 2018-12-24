Received: from eggs.gnu.org ([208.118.235.92]:35064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zach_turing@outlook.com>) id 1gbGA6-0003eI-VM
	for qemu-devel@nongnu.org; Sun, 23 Dec 2018 21:40:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zach_turing@outlook.com>) id 1gbGA3-00007E-HM
	for qemu-devel@nongnu.org; Sun, 23 Dec 2018 21:40:10 -0500
Received: from mail-oln040092253091.outbound.protection.outlook.com
	([40.92.253.91]:8497
	helo=APC01-SG2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zach_turing@outlook.com>)
	id 1gbGA3-0008Sm-06
	for qemu-devel@nongnu.org; Sun, 23 Dec 2018 21:40:07 -0500
From: ? ? <zach_turing@outlook.com>
Date: Mon, 24 Dec 2018 02:40:02 +0000
Message-ID: <SG2PR03MB3594A9080D305565DE9FB4E380BB0@SG2PR03MB3594.apcprd03.prod.outlook.com>
Content-Language: zh-CN
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] live migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>


Hello, I have a question I would like to ask.
If I add the -incoming parameter when starting the qemu virtual machine, th=
e virtual machine will block all the time, waiting for the migration connec=
tion request to arrive.
I want to modify the time of this blocking wait, how should I modify the so=
urce code?
