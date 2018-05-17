Received: from eggs.gnu.org ([2001:4830:134:3::10]:52405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fJL31-0002dR-Mz
	for qemu-devel@nongnu.org; Thu, 17 May 2018 11:42:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fJL30-0002Aw-Of
	for qemu-devel@nongnu.org; Thu, 17 May 2018 11:42:31 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:33000)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fJL30-0002Al-JW
	for qemu-devel@nongnu.org; Thu, 17 May 2018 11:42:30 -0400
Received: by mail-ot0-x244.google.com with SMTP id l22-v6so5569229otj.0
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 08:42:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180516205543.29305-5-laurent@vivier.eu>
References: <20180516205543.29305-1-laurent@vivier.eu>
	<20180516205543.29305-5-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 May 2018 16:42:09 +0100
Message-ID: <CAFEAcA85hb6dHF+i-MOnPNVsNv+s_mi5xSsesuYjwghJkqgWtw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 4/8] linux-user: move socket.h generic
 definitions to generic/sockbits.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Richard Henderson <rth@twiddle.net>, Yongbok Kim <yongbok.kim@mips.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

On 16 May 2018 at 21:55, Laurent Vivier <laurent@vivier.eu> wrote:
> and include the file from architectures without specific definitions
>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
