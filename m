Received: from eggs.gnu.org ([2001:4830:134:3::10]:48051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fcwfD-0001Vm-D6
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 13:43:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fcwfA-0007Ug-9S
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 13:42:59 -0400
Received: from mail-sn1nam01on0134.outbound.protection.outlook.com
	([104.47.32.134]:31494
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fcwfA-0007Tq-1M
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 13:42:56 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Tue, 10 Jul 2018 17:42:51 +0000
Message-ID: <BN7PR08MB486830737EE6EC8F3DE806FCC65B0@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <1531169431-10772-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<1531169431-10772-12-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1531169431-10772-12-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 11/33] target/mips: Add emulation of
 misc nanoMIPS instructions (pool p_lsx)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "f4bug@amsat.org" <f4bug@amsat.org>, "aurelien@aurel32.net" <aurelien@aurel32.net>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, Paul Burton <pburton@wavecomp.com>

> Subject: [PATCH v2 11/33] target/mips: Add emulation of misc nanoMIPS ins=
tructions (pool > p_lsx)
>
> From: Yongbok Kim <yongbok.kim@mips.com>
>
> Add emulation of nanoMIPS instructions situated in pool p_lsx, and
> emulation of LSA instruction as well.
>
> Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> ---
>  target/mips/translate.c | 139 ++++++++++++++++++++++++++++++++++++++++++=
+++++-
>  1 file changed, 138 insertions(+), 1 deletion(-)

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
