Received: from eggs.gnu.org ([2001:4830:134:3::10]:51501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gJggG-0006LT-5B
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 10:20:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gJggD-0001iM-2T
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 10:20:42 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:37844)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gJgg6-0001Yu-Kl
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 10:20:35 -0500
Received: by mail-ot1-x344.google.com with SMTP id 40so8055949oth.4
	for <qemu-devel@nongnu.org>; Mon, 05 Nov 2018 07:20:34 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181102001303.32640-1-f4bug@amsat.org>
References: <20181102001303.32640-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Nov 2018 15:20:12 +0000
Message-ID: <CAFEAcA8kho6tBJMB6qXgKEq_tt5GQm1wHE96mqoM_vx95x44Pw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for 3.2 v2 0/7] hw/arm/bcm2835: Add basic
 support for cprman (clock subsystem)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Guenter Roeck <linux@roeck-us.net>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 2 November 2018 at 00:12, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
> Hi,
>
> This series is a mix of a previous work I had for the raspi, and a patch =
from
> Guenter: https://lists.gnu.org/archive/html/qemu-devel/2018-07/msg03153.h=
tml
>
> The final patch keep Guenter ideas and comments, but is mostly a rewrite.
> I dropped the A2W code from this work, it doesn't seems unuseful to me.
>
> Guenter can you test this series?
>
> I kept Guenter S-o-b and (C), is that OK? (Guenter?, Peter?)

Yes, that's the general approach the project takes. If you've
made changes to the patches yourself you should note those with
something like
[me: changed foo, bar, baz]
after Guenter's signoff and before your own.

thanks
-- PMM
