Received: from eggs.gnu.org ([209.51.188.92]:45958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1gwKJ9-00082t-2b
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 00:20:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1gwKJ3-0004bX-QX
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 00:20:30 -0500
Received: from mail.ispras.ru ([83.149.199.45]:45770)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1gwKJ3-0004a1-Hf
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 00:20:29 -0500
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <154937205518.29984.9188603364499998604.stgit@pasha-VirtualBox>	<001c01d4c1cb$65a26390$30e72ab0$@ru>	<43520125-e1d5-7ee6-60a8-5efc1dc061fe@redhat.com>,
	<87k1hww82d.fsf@dusky.pond.sub.org>
	<BN6PR2201MB12518EFC0C0F29ACCD7ABBE7C67C0@BN6PR2201MB1251.namprd22.prod.outlook.com>
In-Reply-To: <BN6PR2201MB12518EFC0C0F29ACCD7ABBE7C67C0@BN6PR2201MB1251.namprd22.prod.outlook.com>
Date: Wed, 20 Feb 2019 08:20:27 +0300
Message-ID: <001301d4c8db$fd5de850$f819b8f0$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Language: ru
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
To: 'Aleksandar Markovic' <amarkovic@wavecomp.com>, 'Markus Armbruster' <armbru@redhat.com>, =?iso-8859-1?Q?'Philippe_Mathieu-Daud=E9'?= <philmd@redhat.com>
Cc: 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org, =?iso-8859-1?Q?'Marc-Andr=E9_Lureau'?= <marcandre.lureau@redhat.com>, 'Aleksandar Rikalo' <arikalo@wavecomp.com>, aurelien@aurel32.net, mdroth@linux.vnet.ibm.com, natalia.fursova@ispras.ru

> From: Aleksandar Markovic [mailto:amarkovic@wavecomp.com]
> > From: Markus Armbruster <armbru@redhat.com>
> > Subject: Re: [Qemu-devel] [PATCH] mips: implement qmp query-cpu-definitions command
> 
> > Please rebase.  Let me know if you need help.
> 
> Hi, Markus.
> 
> Pavel was probably busy today, so I took the liberty to rebase the patch,
> and here is the v2:
> 
> https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg05158.html

Thank you!

Pavel Dovgalyuk
