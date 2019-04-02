Received: from eggs.gnu.org ([209.51.188.92]:43026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hBOVo-0008My-7z
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 14:51:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hBOVm-0001jD-Is
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 14:51:56 -0400
Received: from mail-eopbgr710132.outbound.protection.outlook.com
	([40.107.71.132]:48206
	helo=NAM05-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1hBOVk-0001W2-Qr
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 14:51:53 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Tue, 2 Apr 2019 18:51:49 +0000
Message-ID: <BN6PR2201MB1251AB337EE1A659E78D8742C6560@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1554218121-26766-1-git-send-email-mateja.marjanovic@rt-rk.com>,
	<1554218121-26766-3-git-send-email-mateja.marjanovic@rt-rk.com>
In-Reply-To: <1554218121-26766-3-git-send-email-mateja.marjanovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v5 2/2] target/mips: Optimize
 ILVEV.<B|H|W|D> MSA instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>, "richard.henderson@linaro.org" <richard.henderson@linaro.org>, Aleksandar Rikalo <arikalo@wavecomp.com>

> +/*
> + * [MSA] ILVEV.D wd, ws, wt
> + *
> + *   Vector Interleave Even (Double data elements)
> + *
> + */

Double -> Doubleword
