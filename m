Received: from eggs.gnu.org ([2001:4830:134:3::10]:35423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cl0O3-0003Uo-Oa
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 16:41:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cl0O3-0000zW-2E
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 16:41:47 -0500
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:38385)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cl0O2-0000z9-SS
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 16:41:46 -0500
Received: by mail-wm0-x229.google.com with SMTP id t193so76145338wmt.1
	for <qemu-devel@nongnu.org>; Mon, 06 Mar 2017 13:41:46 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170306170751.jr7cgwsz3yqq2kd2@kozik-lap>
References: <20170305214857.9510-1-krzk@kernel.org>
	<f441f1d9-b312-5f96-0fbf-53a46a8b16a8@redhat.com>
	<20170306170751.jr7cgwsz3yqq2kd2@kozik-lap>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Mar 2017 21:41:25 +0000
Message-ID: <CAFEAcA_w7i6NsHXUL+uGMyJDA7wH8s7=sXjboq_Y9oXxF_iGMw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 1/3] hw/arm/exynos: Convert fprintf to
 error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Eric Blake <eblake@redhat.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 6 March 2017 at 17:07, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On Mon, Mar 06, 2017 at 10:55:12AM -0600, Eric Blake wrote:
>> I don't see a 0/3 cover letter. When sending multiple patches, it's
>> always best to package them in-reply-to the cover letter ('git config
>> format.coverLetter auto' makes it easy to remember).
>
> The patches are trivial cleanups without any dependencies so the cover
> letter would be one sentence of "trivial cleanup". :)
>
> If that's the practice in qemu, I can send them, no problem.

Yeah, cover letter always for multipatch sets, please. We have
automated tooling that relies on this (and also manual humans).

thanks
-- PMM
