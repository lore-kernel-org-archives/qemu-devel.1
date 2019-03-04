Received: from eggs.gnu.org ([209.51.188.92]:35317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1h0rUF-0003y1-2Y
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 12:34:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1h0rUE-0004KX-Ct
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 12:34:47 -0500
Received: from mail-co1nam04on070e.outbound.protection.outlook.com
	([2a01:111:f400:fe4d::70e]:38880
	helo=NAM04-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1h0rUD-0004Fl-SD
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 12:34:46 -0500
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Mon, 4 Mar 2019 17:34:40 +0000
Message-ID: <CY4PR2201MB12545FA9A77CE7C2B21D988DC6760@CY4PR2201MB1254.namprd22.prod.outlook.com>
References: <1551185735-17154-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1551185735-17154-10-git-send-email-aleksandar.markovic@rt-rk.com>,
	<07b3eb94-30a5-910b-760a-0058e52d23b3@redhat.com>
In-Reply-To: <07b3eb94-30a5-910b-760a-0058e52d23b3@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v4 9/9] target/mips: Add support for DSPRAM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>, Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, Yongbok Kim <yongbok.kim@mips.com>, Luc Michel <luc.michel@greensocs.com>, Alistair Francis <alistair.francis@wdc.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Aleksandar Rikalo <arikalo@wavecomp.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>, Paul Burton <pburton@wavecomp.com>, Peter Maydell <peter.maydell@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>

> From: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> Subject: Re: [Qemu-devel] [PATCH v4 9/9] target/mips: Add support for DSP=
RAM

> (I believe this is the v6 of this patched, included in a v4 series).

Yes, there was a previous version of this patch in Oct 2028, but it wasn't =
accepted
at that time.

> I made some comments around, but the most important is simply:
>   "please move create_dspram() into mips_cps".

I appreciate your review, Philippe, thanks. I am going to send a new versio=
n of this
patch (or perhaps a small series with equivalent content) in next few days.

Yours,
Aleksandar=
