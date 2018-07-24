Received: from eggs.gnu.org ([2001:4830:134:3::10]:37704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fi1Gt-0000Zv-9l
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 13:38:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fi1Gp-00056B-Me
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 13:38:51 -0400
Received: from mail-sn1nam02on0114.outbound.protection.outlook.com
	([104.47.36.114]:45079
	helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fi1Gf-0004rv-Az
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 13:38:47 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Tue, 24 Jul 2018 17:38:32 +0000
Message-ID: <BN7PR08MB48682C78A049964E9B868B80C6550@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <1532451888-8958-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<CAFEAcA9=QtQYjCEi22U4hviWx4OuVBkvcQXYeE7MnBO6BLDAQQ@mail.gmail.com>
In-Reply-To: <CAFEAcA9=QtQYjCEi22U4hviWx4OuVBkvcQXYeE7MnBO6BLDAQQ@mail.gmail.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 00/10] Mips maintenance and misc fixes
 and improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paul Burton <pburton@wavecomp.com>, Stefan Markovic <smarkovic@wavecomp.com>, Riku Voipio <riku.voipio@iki.fi>, Richard Henderson <richard.henderson@linaro.org>, Laurent Vivier <laurent@vivier.eu>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philippe.mathieu.daude@gmail.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>

> From: Peter Maydell <peter.maydell@linaro.org>
> Sent: Tuesday, July 24, 2018 7:21 PM
> On 24 July 2018 at 18:04, Aleksandar Markovic
> <aleksandar.markovic@rt-rk.com> wrote:
> > From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> Are you trying to get these into 3.0 or aiming for 3.1?
> Time is running out for the former (and at this point
> in the release cycle "fixes" are OK but "improvements"
> should be postponed til 3.1...)
>
> thanks
> -- PMM

Hello, Peter.

This is all for 3.1, submitted now just for review. I guess review process =
can take place regardless of pending code freeze.

Regards,
Aleksandar
