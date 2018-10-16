Received: from eggs.gnu.org ([2001:4830:134:3::10]:60008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gCOIS-0006Rd-Ik
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 08:18:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gCOIM-0001z0-CQ
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 08:17:58 -0400
Received: from mail-sn1nam02on0090.outbound.protection.outlook.com
	([104.47.36.90]:60312
	helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gCOIM-0001t0-4B
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 08:17:54 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Tue, 16 Oct 2018 12:17:47 +0000
Message-ID: <BN6PR2201MB12511C6B7D548260778C9F71C6FE0@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1539362376-12010-1-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1539362376-12010-1-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v5 00/28] Misc MIPS fixes and improvements
 for October 2018
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

> From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
> Subject: [PATCH v5 00/28] Misc MIPS fixes and improvements for October 20=
18

Hi, Laurent

Earlier I mentioned that I intend to include these in my MIPS queue:

  elf: Fix PT_MIPS_XXX constants
  elf: Add MIPS_ABI_FP_XXX constants
  elf: Add Mips_elf_abiflags_v0 structure

I still intend to do that, but I now want to include two more as well:

  linux-user: Add MIPS-specific prctl() options
  linux-user: Add infrastructure for handling MIPS-specific prctl()

They are also very simple MIPS-only specific patches, like the first three.

Please let me know if you have any objections about that.

Thanks,
Aleksandar=
