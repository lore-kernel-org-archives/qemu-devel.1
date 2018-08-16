Received: from eggs.gnu.org ([2001:4830:134:3::10]:43147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fqHRb-0008Ao-9Y
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 08:32:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fqHRW-0001XB-SB
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 08:32:03 -0400
Received: from mail-co1nam03on0715.outbound.protection.outlook.com
	([2a01:111:f400:fe48::715]:44555
	helo=NAM03-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fqHRW-0001W0-AS
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 08:31:58 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Thu, 16 Aug 2018 12:31:54 +0000
Message-ID: <BN7PR08MB48682F320B46E380C205F227C63E0@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <1534182832-554-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<1534182832-554-49-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1534182832-554-49-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v8 48/87] target/mips: Add emulation of DSP
 ASE for nanoMIPS - part 4
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "laurent@vivier.eu" <laurent@vivier.eu>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "philippe.mathieu.daude@gmail.com" <philippe.mathieu.daude@gmail.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>, "richard.henderson@linaro.org" <richard.henderson@linaro.org>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, Paul Burton <pburton@wavecomp.com>

> From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
> Sent: Monday, August 13, 2018 7:53 PM
>=20
> Subject: [PATCH v8 48/87] target/mips: Add emulation of DSP ASE for nanoM=
IPS - part 4
>=20
> From: Stefan Markovic <smarkovic@wavecomp.com>
>=20
> Add emulation of DSP ASE instructions for nanoMIPS - part 4.
>=20
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> ---
>  target/mips/translate.c | 363 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 363 insertions(+)

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
