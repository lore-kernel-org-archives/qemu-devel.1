Received: from eggs.gnu.org ([2001:4830:134:3::10]:45079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1elYZO-0003CA-35
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 06:16:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1elYZN-0000aN-4y
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 06:16:18 -0500
Received: from mail-oi0-x22d.google.com ([2607:f8b0:4003:c06::22d]:36539)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1elYZM-0000Zx-VV
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 06:16:17 -0500
Received: by mail-oi0-x22d.google.com with SMTP id 24so13611593oij.3
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 03:16:16 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <d23a2730-a103-6336-0658-e12fa9b0193f@lauterbach.com>
References: <d23a2730-a103-6336-0658-e12fa9b0193f@lauterbach.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Feb 2018 11:15:55 +0000
Message-ID: <CAFEAcA-tc+-+KLcMPB=BV0zCmO6t7tuKHM4=kyRf_Xx0aCCidA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH V2] target-arm:Add a dynamic
 XML-description of the cp-registers to GDB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Abdallah Bouassida <abdallah.bouassida@lauterbach.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, Khaled Jmal <khaled.jmal@lauterbach.com>, QEMU Developers <qemu-devel@nongnu.org>

On 30 January 2018 at 11:16, Abdallah Bouassida
<abdallah.bouassida@lauterbach.com> wrote:
> [PATCH V2] target-arm:Add a dynamic XML-description of the cp-registers to
> GDB
>
> This patch offers to GDB the ability to read/write all the coprocessor
> registers for ARM and ARM64 by generating dynamically an XML-description for
> these registers.
>
> Signed-off-by: Abdallah Bouassida <abdallah.bouassida@lauterbach.com>
> ---
>

Hi. I tried applying this patch to review it, but unfortunately your
email client has made a complete mess of it. In particular:
 * it is wrapping long lines
 * it is converting all the leading space characters to unicode
   non-breaking space characters

which means that it won't apply. Can you resend using something that
doesn't mangle plaintext, please?

thanks
-- PMM
