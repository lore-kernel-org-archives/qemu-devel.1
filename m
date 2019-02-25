Received: from eggs.gnu.org ([209.51.188.92]:33684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arikalo@wavecomp.com>) id 1gyJMW-000181-JR
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 11:44:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arikalo@wavecomp.com>) id 1gyJMV-0005BF-Jp
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 11:44:16 -0500
Received: from mail-eopbgr690117.outbound.protection.outlook.com
	([40.107.69.117]:4000
	helo=NAM04-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <arikalo@wavecomp.com>)
	id 1gyJMV-0005AA-4u
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 11:44:15 -0500
From: Aleksandar Rikalo <arikalo@wavecomp.com>
Date: Mon, 25 Feb 2019 16:44:11 +0000
Message-ID: <DM5PR22MB1658D01A8E0EF07170375FCCD27A0@DM5PR22MB1658.namprd22.prod.outlook.com>
References: <1551111037-23411-1-git-send-email-mateja.marjanovic@rt-rk.com>
In-Reply-To: <1551111037-23411-1-git-send-email-mateja.marjanovic@rt-rk.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/3] target/mips: Add emulation of three
 MMI instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>, Aleksandar Markovic <amarkovic@wavecomp.com>

> From: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>

> Subject: [PATCH 0/3] target/mips: Add emulation of three MMI instructions
>
> From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>
>
> This series adds emulation of PCPYH, PCPYLD, and PCPYUD MMI
> instructions.
>
> Mateja Marjanovic (3):
>  target/mips: Add emulation of MMI instruction PCPYH
>  target/mips: Add emulation of MMI instruction PCPYLD
>  target/mips: Add emulation of MMI instruction PCPYUD
>
> target/mips/translate.c | 199 +++++++++++++++++++++++++++++++++++++++++++=
+++--
>  1 file changed, 194 insertions(+), 5 deletions(-)
>

> From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
> Sent: Friday, February 22, 2019 8:26 PM
> To: qemu-devel@nongnu.org
> Cc: aurelien@aurel32.net; Aleksandar Markovic; Aleksandar Rikalo
> Subject: [PATCH v3 0/8] Misc target/mips fixes and improvements
>
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> A collection of misc target/mips fixes and improvements for
> February 2019.
>

For all the patches in this series:

Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>

Aleksandar Rikalo
