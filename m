Received: from eggs.gnu.org ([2001:4830:134:3::10]:58054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gB2NN-0004WS-3B
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 14:41:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gB2NE-0001qP-9Z
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 14:41:27 -0400
Received: from mail-sn1nam01on0138.outbound.protection.outlook.com
	([104.47.32.138]:51553
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gB2ND-0001oO-Vg
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 14:41:20 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Fri, 12 Oct 2018 18:41:15 +0000
Message-ID: <BN6PR2201MB1251FA05F90906D93ECDCB93C6E20@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1539362376-12010-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<1539362376-12010-23-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1539362376-12010-23-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v5 22/28] target/mips: Add CP0 Config2 to
 DisasContext
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

> Subject: [PATCH v5 22/28] target/mips: Add CP0 Config2 to DisasContext
>
> From: Stefan Markovic <smarkovic@wavecomp.com>
>
> Add field corresponding to CP0 Config2 to DisasContext. This is
needed for availability control via Config2 bits.
>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>=
