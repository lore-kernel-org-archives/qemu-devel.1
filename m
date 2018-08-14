Received: from eggs.gnu.org ([2001:4830:134:3::10]:39772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fpYMY-00030I-Pz
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 08:23:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fpYMU-00019L-Rt
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 08:23:50 -0400
Received: from mail-by2nam01on0106.outbound.protection.outlook.com
	([104.47.34.106]:2473
	helo=NAM01-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fpYMU-00018m-IJ
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 08:23:46 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Tue, 14 Aug 2018 12:23:43 +0000
Message-ID: <SN6PR08MB48798AE3858CF3DFA6EC18D4C6380@SN6PR08MB4879.namprd08.prod.outlook.com>
References: <1534182832-554-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<1534182832-554-9-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1534182832-554-9-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v8 08/87] target/mips: Add support for
 availability control via bit XNP
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
> Sent: Monday, August 13, 2018 7:52 PM
>=20
> Subject: [PATCH v8 08/87] target/mips: Add support for availability contr=
ol via bit XNP
>=20
> From: Aleksandar Rikalo <arikalo@wavecomp.com>
>=20
> Add a field in hflags for XNP bit, and a function check_xnp().
>=20
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> ---
>  target/mips/cpu.h       |  3 ++-
>  target/mips/internal.h  |  5 ++++-
>  target/mips/translate.c | 12 ++++++++++++
>  3 files changed, 18 insertions(+), 2 deletions(-)

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>=
