Received: from eggs.gnu.org ([2001:4830:134:3::10]:32856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fTm47-0006G3-Rt
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 06:34:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fTm47-0005hP-6J
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 06:34:47 -0400
Received: from mail-ot0-x229.google.com ([2607:f8b0:4003:c0f::229]:39996)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fTm46-0005hI-Uq
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 06:34:47 -0400
Received: by mail-ot0-x229.google.com with SMTP id w9-v6so10449841otj.7
	for <qemu-devel@nongnu.org>; Fri, 15 Jun 2018 03:34:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180613015641.5667-1-richard.henderson@linaro.org>
References: <20180613015641.5667-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Jun 2018 11:34:25 +0100
Message-ID: <CAFEAcA9nU4Sd3KzamhFTSZsPcC9BrAsgHuO=f7zdRnAvgFhnkg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4b 00/18] target/arm: SVE instructions,
 part 2
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

On 13 June 2018 at 02:56, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Here's the second installment of SVE instructions.
> There are about 25 patches waiting for a third installment;
> this makes a nice break before beginning with the memory ops.
>
> Since v3, r-b tags, comment fixes, and other review feedback.
>
>



Applied to target-arm.next, thanks.

-- PMM
