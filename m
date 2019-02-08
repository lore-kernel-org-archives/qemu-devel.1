Received: from eggs.gnu.org ([209.51.188.92]:53077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gs60h-0008Uc-7N
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 08:16:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gs60g-0007MX-Hd
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 08:16:03 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:33237)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gs60g-0007Ko-4S
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 08:16:02 -0500
Received: by mail-ot1-x343.google.com with SMTP id i20so5787092otl.0
	for <qemu-devel@nongnu.org>; Fri, 08 Feb 2019 05:16:00 -0800 (PST)
MIME-Version: 1.0
References: <20190206101446.6898-1-richard.henderson@linaro.org>
In-Reply-To: <20190206101446.6898-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Feb 2019 13:15:47 +0000
Message-ID: <CAFEAcA_L=kJAoy=XdsZ+OEwUFFMirEnKdKoAqphZyR0Xrhvagw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH RISU 0/2] Do not enable --sve by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Wed, 6 Feb 2019 at 10:14, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> In the process of noticing what the problem was,
> add fp regs to the aarch64 smoke test.
>
>

Applied to risu master, thanks.

-- PMM
