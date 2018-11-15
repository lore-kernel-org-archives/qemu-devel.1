Received: from eggs.gnu.org ([2001:4830:134:3::10]:43239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gNJ1f-00042F-NI
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:53:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gNJ1f-00089Y-2D
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:53:47 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:43926)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gNJ1e-00088s-UW
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:53:47 -0500
Received: by mail-oi1-x244.google.com with SMTP id j202-v6so16907901oih.10
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 06:53:46 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181113180154.17903-1-richard.henderson@linaro.org>
References: <20181113180154.17903-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Nov 2018 14:53:25 +0000
Message-ID: <CAFEAcA8SEjdH6euMazKkQpPfDWQupZAdUigs+=uxLuEUy5W2Bg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 0/4] target/arm: KVM vs ARMISARegisters
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

On 13 November 2018 at 18:01, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Facepalm.  I managed to not push the v3 changes anywhere,
> so the v4 changes were done on top of v2.  Ho hum.
>
> r~
>

Applied v5 to target-arm.next for 3.1, thanks. (And tested on
both the aarch64 and the aarch32 systems that had problems
with earlier versions of the patchset.)

-- PMM
