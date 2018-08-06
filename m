Received: from eggs.gnu.org ([2001:4830:134:3::10]:48309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fmkRE-0004GF-0T
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 14:41:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fmkRB-00038T-91
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 14:41:04 -0400
Received: from mail-eopbgr700123.outbound.protection.outlook.com
	([40.107.70.123]:61568
	helo=NAM04-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fmkRB-00037Y-0j
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 14:41:01 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Mon, 6 Aug 2018 18:40:57 +0000
Message-ID: <BN7PR08MB48680C7BEF255C22A9120921C6200@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <1533574847-19294-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<1533574847-19294-41-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1533574847-19294-41-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v7 40/80] target/mips: Add emulation of DSP
 ASE for nanoMIPS - part 2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "laurent@vivier.eu" <laurent@vivier.eu>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "philippe.mathieu.daude@gmail.com" <philippe.mathieu.daude@gmail.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>, "richard.henderson@linaro.org" <richard.henderson@linaro.org>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, Paul Burton <pburton@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, "thuth@redhat.com" <thuth@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>

> From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
> Sent: Monday, August 6, 2018 7:00 PM
>
> Subject: [PATCH v7 40/80] target/mips: Add emulation of DSP ASE for nanoM=
IPS - part 2
>=20
> From: Stefan Markovic <smarkovic@wavecomp.com>
>=20
> Add emulation of DSP ASE instructions for nanoMIPS - part 2.
>=20
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> ---
> target/mips/translate.c | 10 ++++++++++
> 1 file changed, 10 insertions(+)

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>=
