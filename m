Received: from eggs.gnu.org ([208.118.235.92]:52210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fs4Ta-0000Ys-Ah
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 07:05:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fs4SR-00041r-AE
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 07:04:22 -0400
Received: from mail-cys01nam02on0102.outbound.protection.outlook.com
	([104.47.37.102]:39520
	helo=NAM02-CY1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fs4SR-000414-1v
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 07:04:19 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Tue, 21 Aug 2018 11:04:15 +0000
Message-ID: <BN7PR08MB4868B88AA1E2B44CD925DB1DC6310@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <1534789014-8310-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<1534789014-8310-25-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1534789014-8310-25-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v11 24/46] target/mips: Add CP0 Config3 and
 Config5 fields to DisasContext structure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "philippe.mathieu.daude@gmail.com" <philippe.mathieu.daude@gmail.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>, "richard.henderson@linaro.org" <richard.henderson@linaro.org>, Dimitrije Nikolic <dnikolic@wavecomp.com>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, Paul Burton <pburton@wavecomp.com>

> From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
> Sent: Monday, August 20, 2018 8:16 PM
>=20
> Subject: [PATCH v11 24/46] target/mips: Add CP0 Config3 and Config5 field=
s to DisasContext structure
>=20
> From: Dimitrije Nikolic <dnikolic@wavecomp.com>
>=20
> Add CP0_Config3 and CP0_Config5 to DisasContext structure. This is
> needed for implementing availability control of various instructions.
>=20
> Signed-off-by: "Aleksandar Markovic <amarkovic@wavecomp.com>"
> ---
> target/mips/translate.c | 4 ++++
> 1 file changed, 4 insertions(+)

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>=
