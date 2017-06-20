Received: from eggs.gnu.org ([2001:4830:134:3::10]:38014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dNLNz-0003Xn-Li
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 11:48:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dNLNy-0002jR-Kd
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 11:48:11 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:33963)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dNLNy-0002iV-F4
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 11:48:10 -0400
Received: by mail-wr0-x22c.google.com with SMTP id 77so96334992wrb.1
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 08:48:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170620154453.fmcixyow3e54u7li@kozik-lap>
References: <20170425180609.11004-1-krzk@kernel.org>
	<CAFEAcA8PjjUk6QrAE6ppgyYsYAyh+0uqd=_EgH-g4K=--utdoA@mail.gmail.com>
	<20170620154453.fmcixyow3e54u7li@kozik-lap>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Jun 2017 16:47:48 +0100
Message-ID: <CAFEAcA-VNkST949KirR_4v+7=1O7vgBsf3wvo_rx=zfqmJyYEA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3] hw/misc: Add Exynos4210 Pseudo Random
 Number Generator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 20 June 2017 at 16:44, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On Tue, Jun 20, 2017 at 04:34:57PM +0100, Peter Maydell wrote:
>> Some of these lines are slightly overlong.
>
> Breaking lines does not make much sense, so I could just get rid of
> EXYNOS4210 prefix. It is a local define so maybe there is no need of
> prefixing it?

I just pulled the indent of the relevant lines in a bit:
https://git.linaro.org/people/peter.maydell/qemu-arm.git/commit/?h=target-arm.next&id=a61a64a322e8cc4a25f023e63b2924cca309e7f3

thanks
-- PMM
