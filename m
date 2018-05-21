Received: from eggs.gnu.org ([2001:4830:134:3::10]:36479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fKglP-0002WO-Sh
	for qemu-devel@nongnu.org; Mon, 21 May 2018 05:05:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fKglP-0005vk-5N
	for qemu-devel@nongnu.org; Mon, 21 May 2018 05:05:55 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:39694)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fKglO-0005vY-VQ
	for qemu-devel@nongnu.org; Mon, 21 May 2018 05:05:55 -0400
Received: by mail-oi0-x244.google.com with SMTP id n65-v6so12373307oig.6
	for <qemu-devel@nongnu.org>; Mon, 21 May 2018 02:05:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180519092956.15134-6-laurent@vivier.eu>
References: <20180519092956.15134-1-laurent@vivier.eu>
	<20180519092956.15134-6-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 May 2018 10:05:33 +0100
Message-ID: <CAFEAcA8HkxUfCnTdFRSZByE6iWEpBQpyOWR6z9LwsN9MwT3cjw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 5/8] linux-user: move ppc socket.h
 definitions to ppc/sockbits.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Yongbok Kim <yongbok.kim@mips.com>, Riku Voipio <riku.voipio@iki.fi>, Richard Henderson <rth@twiddle.net>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On 19 May 2018 at 10:29, Laurent Vivier <laurent@vivier.eu> wrote:
> Change conditional #ifdef part by #undef of the symbols
> redefined for PPC relative to generic/socket.h
>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
