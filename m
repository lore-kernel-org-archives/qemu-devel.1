Received: from eggs.gnu.org ([2001:4830:134:3::10]:44645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gNKqA-00005p-IR
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 11:50:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gNKq9-00047t-3g
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 11:50:02 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:39749)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gNKq8-00046g-Lv
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 11:50:00 -0500
Received: by mail-ot1-x342.google.com with SMTP id g27so18624469oth.6
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 08:50:00 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181102134112.26370-2-richard.henderson@linaro.org>
References: <20181102134112.26370-1-richard.henderson@linaro.org>
	<20181102134112.26370-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Nov 2018 16:49:38 +0000
Message-ID: <CAFEAcA_8cgFgCvs6jZ0rb-QPf60YkdPJgpu0SzCh3SfKYD560w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH for-4.0 1/4] target/arm: Move
 id_aa64mmfr* to ARMISARegisters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 2 November 2018 at 13:41, Richard Henderson
<richard.henderson@linaro.org> wrote:
> At the same time, define the fields for these registers,
> and use those defines in arm_pamax().
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
