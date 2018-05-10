Received: from eggs.gnu.org ([2001:4830:134:3::10]:52996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fGo38-0005Ci-1M
	for qemu-devel@nongnu.org; Thu, 10 May 2018 12:04:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fGo37-0005da-B9
	for qemu-devel@nongnu.org; Thu, 10 May 2018 12:04:10 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:42584)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fGo37-0005dA-7d
	for qemu-devel@nongnu.org; Thu, 10 May 2018 12:04:09 -0400
Received: by mail-ot0-x242.google.com with SMTP id l13-v6so2882114otk.9
	for <qemu-devel@nongnu.org>; Thu, 10 May 2018 09:04:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180502221552.3873-2-richard.henderson@linaro.org>
References: <20180502221552.3873-1-richard.henderson@linaro.org>
	<20180502221552.3873-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 May 2018 17:03:48 +0100
Message-ID: <CAFEAcA8X6edc0XnZ0u6_zk5UcNhvohFabb200JXnxQjk-u1SmQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 01/14] target/arm: Implement vector
 shifted SCVF/UCVF for fp16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, qemu-stable <qemu-stable@nongnu.org>

On 2 May 2018 at 23:15, Richard Henderson <richard.henderson@linaro.org> wrote:
> While we have some of the scalar paths for *CVF for fp16,
> we failed to decode the fp16 version of these instructions.
>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
