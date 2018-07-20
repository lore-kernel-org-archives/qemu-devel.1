Received: from eggs.gnu.org ([2001:4830:134:3::10]:44052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fgWPT-0002G6-8z
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 10:29:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fgWPQ-0002UH-2W
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 10:29:31 -0400
Received: from mail-bl2nam02on0103.outbound.protection.outlook.com
	([104.47.38.103]:48544
	helo=NAM02-BL2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fgWPP-0002U4-Pu
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 10:29:27 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Fri, 20 Jul 2018 14:29:24 +0000
Message-ID: <BN7PR08MB48685307079BF03735F5091AC6510@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <1532004727-13778-1-git-send-email-stefan.markovic@rt-rk.com>
	<1532004727-13778-12-git-send-email-stefan.markovic@rt-rk.com>,
	<8541a994-5ab2-49da-cbe8-a92a53075d7c@linaro.org>,
	<BN7PR08MB4868DB73F3F048397F8C6312C6520@BN7PR08MB4868.namprd08.prod.outlook.com>
In-Reply-To: <BN7PR08MB4868DB73F3F048397F8C6312C6520@BN7PR08MB4868.namprd08.prod.outlook.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 11/11] linux-user: Add availability
 control to some syscalls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, Stefan Markovic <stefan.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "laurent@vivier.eu" <laurent@vivier.eu>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "philippe.mathieu.daude@gmail.com" <philippe.mathieu.daude@gmail.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, Paul Burton <pburton@wavecomp.com>

> > From: Aleksandar Rikalo <arikalo@wavecomp.com>
> >
> > Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> > Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> > ---
> >  linux-user/strace.c  | 14 +++++++++++++-
> >  linux-user/syscall.c | 25 +++++++++++++++++++++++++
> >  2 files changed, 38 insertions(+), 1 deletion(-)

If this patch gets a proper commit message (as described in my response):
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
