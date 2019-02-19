Received: from eggs.gnu.org ([209.51.188.92]:35196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gwAvO-0000ji-42
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 14:19:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gwAvL-0002BA-2w
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 14:19:25 -0500
Received: from mail-dm3nam03on071a.outbound.protection.outlook.com
	([2a01:111:f400:fe49::71a]:18396
	helo=NAM03-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gwAvG-00029G-DC
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 14:19:20 -0500
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Tue, 19 Feb 2019 19:19:09 +0000
Message-ID: <BN6PR2201MB12518EFC0C0F29ACCD7ABBE7C67C0@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <154937205518.29984.9188603364499998604.stgit@pasha-VirtualBox>
	<001c01d4c1cb$65a26390$30e72ab0$@ru>
	<43520125-e1d5-7ee6-60a8-5efc1dc061fe@redhat.com>,
	<87k1hww82d.fsf@dusky.pond.sub.org>
In-Reply-To: <87k1hww82d.fsf@dusky.pond.sub.org>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] mips: implement qmp query-cpu-definitions
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>
Cc: Pavel Dovgalyuk <dovgaluk@ispras.ru>, 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>, "mdroth@linux.vnet.ibm.com" <mdroth@linux.vnet.ibm.com>, "natalia.fursova@ispras.ru" <natalia.fursova@ispras.ru>

> From: Markus Armbruster <armbru@redhat.com>
> Subject: Re: [Qemu-devel] [PATCH] mips: implement qmp query-cpu-definitio=
ns command

> Please rebase.  Let me know if you need help.

Hi, Markus.

Pavel was probably busy today, so I took the liberty to rebase the patch,
and here is the v2:

https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg05158.html

I would really appreciate if you, or somebody else knowledgeable in QAPI,
take a look. I did only build tests.

Regards,
Aleksandar
