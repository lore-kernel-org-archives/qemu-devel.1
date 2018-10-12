Received: from eggs.gnu.org ([2001:4830:134:3::10]:56516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gB2HB-0000w0-6C
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 14:35:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gB2H5-0006pW-55
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 14:35:05 -0400
Received: from mail-sn1nam02on0106.outbound.protection.outlook.com
	([104.47.36.106]:14583
	helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gB2H3-0006oC-T6
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 14:34:58 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Fri, 12 Oct 2018 18:34:53 +0000
Message-ID: <BN6PR2201MB125171E3BDFF028F4B714E40C6E20@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1539362376-12010-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<1539362376-12010-9-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1539362376-12010-9-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v5 08/28] target/mips: Add CPO PWBase
 register
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

> Subject: [PATCH v5 08/28] target/mips: Add CPO PWBase register
>
> From: Yongbok Kim <yongbok.kim@mips.com>
>
>Add PWBase register (CP0 Register 5, Select 5).

This and several other patches in this series contain letter "O" instead of=
 digit "0" in their title. This should be corrected.

Aleksandar=
