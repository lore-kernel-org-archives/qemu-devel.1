Received: from eggs.gnu.org ([2001:4830:134:3::10]:34568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fcs3R-0007h2-5m
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 08:47:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fcs3Q-0005lf-89
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 08:47:41 -0400
Received: from mail-cys01nam02on072d.outbound.protection.outlook.com
	([2a01:111:f400:fe45::72d]:1056
	helo=NAM02-CY1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fcs3Q-0005kj-0P
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 08:47:40 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Tue, 10 Jul 2018 12:47:34 +0000
Message-ID: <BN7PR08MB4868E3327C65E100E69C2E4AC65B0@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <1531169431-10772-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<1531169431-10772-5-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1531169431-10772-5-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 04/33] target/mips: Add emulation of
 nanoMIPS 16-bit logic instructions
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

> Subject: [PATCH v2 04/33] target/mips: Add emulation of nanoMIPS 16-bit l=
ogic instructions
>
> From: Yongbok Kim <yongbok.kim@mips.com>
>
> Add emulation of NOT16, AND16, XOR16, OR16 instructions.
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> ---
>  target/mips/translate.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
