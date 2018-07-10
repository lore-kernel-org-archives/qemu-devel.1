Received: from eggs.gnu.org ([2001:4830:134:3::10]:47018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fcwbv-0007rA-Lr
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 13:39:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fcwbs-0005ti-Ie
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 13:39:35 -0400
Received: from mail-bn3nam01on0138.outbound.protection.outlook.com
	([104.47.33.138]:38560
	helo=NAM01-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fcwbs-0005s6-4b
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 13:39:32 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Tue, 10 Jul 2018 17:39:29 +0000
Message-ID: <BN7PR08MB48685FD7E55C9FC058A38813C65B0@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <1531169431-10772-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<1531169431-10772-10-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1531169431-10772-10-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 09/33] target/mips: Add emulation of
 misc nanoMIPS instructions (pool32a0)
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

> Subject: [PATCH v2 09/33] target/mips: Add emulation of misc nanoMIPS ins=
tructions (pool32a0)
>
> From: Yongbok Kim <yongbok.kim@mips.com>
>
> Add emulation of nanoMIPS instructions that are situated in pool32a0.
>
> Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> ---
>  target/mips/translate.c | 190 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 190 insertions(+)

Technically, this covers slightly more than pool pool32a0, but this is real=
ly splitting the hair, so, anyway:

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
