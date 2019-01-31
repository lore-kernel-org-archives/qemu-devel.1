Received: from eggs.gnu.org ([209.51.188.92]:58409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpCis-00077P-Ox
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 08:49:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpCip-0004cT-OA
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 08:49:42 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:38238)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gpCik-0004Wg-2J
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 08:49:36 -0500
Received: by mail-ot1-x342.google.com with SMTP id e12so2831591otl.5
	for <qemu-devel@nongnu.org>; Thu, 31 Jan 2019 05:49:25 -0800 (PST)
MIME-Version: 1.0
References: <20190129143511.12311-1-richard.henderson@linaro.org>
In-Reply-To: <20190129143511.12311-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 Jan 2019 13:49:13 +0000
Message-ID: <CAFEAcA9Brck3P0BYDDDj2cKiRP0Z-P6AX_4MMLMjRL5t-+eN2Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] target/arm: Enable API, APK bits in SCR,
 HCR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On Tue, 29 Jan 2019 at 14:35, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> These bits become writable with the ARMv8.3-PAuth extension.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper.c | 6 ++++++
>  1 file changed, 6 insertions(+)



Applied to target-arm.next, thanks.

-- PMM
