Received: from eggs.gnu.org ([2001:4830:134:3::10]:57857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gB2MS-0003w0-EQ
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 14:40:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gB2MN-0001P6-6X
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 14:40:32 -0400
Received: from mail-bl2nam02on0108.outbound.protection.outlook.com
	([104.47.38.108]:37719
	helo=NAM02-BL2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gB2MN-0001OZ-1t
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 14:40:27 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Fri, 12 Oct 2018 18:40:21 +0000
Message-ID: <BN6PR2201MB1251DEB5C6BD0D47EB51B8E3C6E20@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1539362376-12010-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<1539362376-12010-22-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1539362376-12010-22-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v5 21/28] target/mips: Add opcodes for
 nanoMIPS EVA instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>, "richard.henderson@linaro.org" <richard.henderson@linaro.org>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, "laurent@vivier.eu" <laurent@vivier.eu>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>

> Subject: [PATCH v5 21/28] target/mips: Add opcodes for nanoMIPS EVA instr=
uctions
>
> From: Dimitrije Nikolic <dnikolic@wavecomp.com>
>
> Add opcodes for nanoMIPS EVA instructions: CACHEE, LBE, LBUE, LHE,
LHUE, LLE, LLWPE, LWE, PREFE, SBE, SCE, SCWPE, SHE, SWE.
>
> Signed-off-by: Dimitrije Nikolic <dnikolic@wavecomp.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>=
