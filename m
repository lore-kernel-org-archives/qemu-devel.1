Received: from eggs.gnu.org ([2001:4830:134:3::10]:35017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gAxQr-0000y8-Iw
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 09:24:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gAxQl-0006b6-8Q
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 09:24:45 -0400
Received: from mail-eopbgr720104.outbound.protection.outlook.com
	([40.107.72.104]:18029
	helo=NAM05-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gAxQk-0006ZT-R0
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 09:24:39 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Fri, 12 Oct 2018 13:24:34 +0000
Message-ID: <BN6PR2201MB1251E9870AB026DF238C0D5CC6E20@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1539256947-22807-1-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1539256947-22807-1-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v4 00/22] Misc MIPS fixes and improvements
 for October 2018
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "laurent@vivier.eu" <laurent@vivier.eu>
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>, "richard.henderson@linaro.org" <richard.henderson@linaro.org>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>

> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>=20
> This series contains support for MIPS ABI flags in elf.h...
>=20
> Stefan Markovic (6):
>  elf: Fix PT_MIPS_XXX constants
>  elf: Add MIPS_ABI_FP_XXX constants
>  elf: Add Mips_elf_abiflags_v0 structure

Hi, Laurent

The three patches above are fairly trivial MIPS-specific additions, and the=
y
have my "Reviewed-by"s. I think I can rightfully include them in my next
MIPS pull request. Please let me know if you have any objections about
that.

Thanks,
Aleksandar
