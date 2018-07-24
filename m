Received: from eggs.gnu.org ([2001:4830:134:3::10]:38920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fi2ke-0003VE-CK
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 15:13:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fi2kd-0002Bi-8L
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 15:13:40 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:37291)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fi2kc-0002BK-Pv
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 15:13:39 -0400
Received: by mail-oi0-x241.google.com with SMTP id k81-v6so9498283oib.4
	for <qemu-devel@nongnu.org>; Tue, 24 Jul 2018 12:13:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <BN7PR08MB48682C78A049964E9B868B80C6550@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <1532451888-8958-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<CAFEAcA9=QtQYjCEi22U4hviWx4OuVBkvcQXYeE7MnBO6BLDAQQ@mail.gmail.com>
	<BN7PR08MB48682C78A049964E9B868B80C6550@BN7PR08MB4868.namprd08.prod.outlook.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Jul 2018 20:13:17 +0100
Message-ID: <CAFEAcA_JAM1G66Gs9PhAdDbgmh6LQHd8FvCWfaDDW9Dyt2cz9g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Aleksandar Markovic <amarkovic@wavecomp.com>
Cc: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, QEMU Developers <qemu-devel@nongnu.org>, Paul Burton <pburton@wavecomp.com>, Stefan Markovic <smarkovic@wavecomp.com>, Riku Voipio <riku.voipio@iki.fi>, Richard Henderson <richard.henderson@linaro.org>, Laurent Vivier <laurent@vivier.eu>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philippe.mathieu.daude@gmail.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>

On 24 July 2018 at 18:38, Aleksandar Markovic <amarkovic@wavecomp.com> wrote:
>> From: Peter Maydell <peter.maydell@linaro.org>
>> Sent: Tuesday, July 24, 2018 7:21 PM
>
>> On 24 July 2018 at 18:04, Aleksandar Markovic
>> <aleksandar.markovic@rt-rk.com> wrote:
>> > From: Aleksandar Markovic <amarkovic@wavecomp.com>
>>
>> Are you trying to get these into 3.0 or aiming for 3.1?
>> Time is running out for the former (and at this point
>> in the release cycle "fixes" are OK but "improvements"
>> should be postponed til 3.1...)

> This is all for 3.1, submitted now just for review. I guess
> review process can take place regardless of pending code freeze.

Yep, that's fine (looks like you've got review for most
of this, which is good).

thanks
-- PMM
