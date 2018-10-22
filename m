Received: from eggs.gnu.org ([2001:4830:134:3::10]:52357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gEjwV-0008ST-GL
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 19:49:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gEjjR-0007nw-Lp
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 19:35:37 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:38517)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gEjjQ-0007lm-F7
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 19:35:33 -0400
Received: by mail-yw1-f66.google.com with SMTP id d126-v6so16722648ywa.5
	for <qemu-devel@nongnu.org>; Mon, 22 Oct 2018 16:35:30 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1540134918.git.noring@nocrew.org>
	<BN6PR2201MB125165723113459889A6EC59C6F40@BN6PR2201MB1251.namprd22.prod.outlook.com>
In-Reply-To: <BN6PR2201MB125165723113459889A6EC59C6F40@BN6PR2201MB1251.namprd22.prod.outlook.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 23 Oct 2018 01:35:18 +0200
Message-ID: <CAAdtpL5tbd-bi+f7OhtLB1Nxrj0tbMQRE+u5Y_TLbrzEoKYBMA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v8 00/38] target/mips: Limited support for
 the R5900
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>
Cc: Fredrik Noring <noring@nocrew.org>, "Maciej W. Rozycki" <macro@linux-mips.org>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, =?UTF-8?Q?J=C3=BCrgen_Urban?= <JuergenUrban@gmx.de>, Petar Jovanovic <pjovanovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>

On Mon, Oct 22, 2018 at 3:34 PM Aleksandar Markovic
<amarkovic@wavecomp.com> wrote:
> > From: Fredrik Noring <noring@nocrew.org>
> > Subject: [PATCH v8 00/38] target/mips: Limited support for the R5900
> >
> I experienced some build errors (see the end of this mail), so I had to exclude some patches, but all others are fine, and had my "Reviewed-by". 32 patches will be included in the next MIPS queue.

Thank you a lot Aleksandar for taking this series!
I appreciate a lot, being backed by a company, you also care about
hobbyist contributions.
This is not always an easy task for maintainers, and from the hobbyist
point of view, this means a lot to me.
Regards,
Phil.
