Received: from eggs.gnu.org ([2001:4830:134:3::10]:57955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjTlq-00011H-DM
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 11:40:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjTlp-0007zN-LO
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 11:40:02 -0500
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:36149)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cjTlp-0007yz-G0
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 11:40:01 -0500
Received: by mail-wr0-x22b.google.com with SMTP id u108so56537093wrb.3
	for <qemu-devel@nongnu.org>; Thu, 02 Mar 2017 08:40:01 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170301182618.22395-4-krzk@kernel.org>
References: <20170301182618.22395-1-krzk@kernel.org>
	<20170301182618.22395-4-krzk@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 Mar 2017 16:39:39 +0000
Message-ID: <CAFEAcA_1iyE34aSc4SG5cCXG7s8Esr6ZQ6qdj7-OY4N-ufNcHg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 3/5] hw/timer/exynos4210_mct: Cleanup
 indentation and empty new lines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Shannon Zhao <shannon.zhao@linaro.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>

On 1 March 2017 at 18:26, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> Statements under 'case' were in some places wrongly indented bringing
> confusion and making the code less readable.  Remove also few unneeded
> blank lines.  No functional changes.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
