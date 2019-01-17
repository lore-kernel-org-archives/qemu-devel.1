Received: from eggs.gnu.org ([209.51.188.92]:60943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gkAzf-0008I8-77
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 11:58:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gkAvo-0003K4-F3
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 11:54:17 -0500
Received: from mail-eopbgr710123.outbound.protection.outlook.com
	([40.107.71.123]:12992
	helo=NAM05-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gkAvn-0003Hw-US
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 11:54:16 -0500
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Thu, 17 Jan 2019 16:54:12 +0000
Message-ID: <BN6PR2201MB125149E2135BF8D6E4C5FAF2C6830@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1547643949-10776-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<DM5PR22MB165810CC5E11B5361EE94764D2820@DM5PR22MB1658.namprd22.prod.outlook.com>
In-Reply-To: <DM5PR22MB165810CC5E11B5361EE94764D2820@DM5PR22MB1658.namprd22.prod.outlook.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 0/3] target/mips: Amend CP0 (add
 MemoryMapID, add macros, renaming)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Rikalo <arikalo@wavecomp.com>, Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>

> Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>
>
> Except PATCH 1/3 where CPO should be CP0 (zero instead O) in all defines.

OK, I will correct this while creating the pull request, no need to respin,=
 I hope.

Thanks,
Aleksandar
