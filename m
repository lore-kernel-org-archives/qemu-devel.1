Received: from eggs.gnu.org ([2001:4830:134:3::10]:55098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fJcng-0005k7-Bh
	for qemu-devel@nongnu.org; Fri, 18 May 2018 06:39:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fJcnf-00088V-IN
	for qemu-devel@nongnu.org; Fri, 18 May 2018 06:39:52 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:39297)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fJcnf-00087F-Cq
	for qemu-devel@nongnu.org; Fri, 18 May 2018 06:39:51 -0400
Received: by mail-oi0-x243.google.com with SMTP id n65-v6so6694009oig.6
	for <qemu-devel@nongnu.org>; Fri, 18 May 2018 03:39:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180517224953.11642-1-richard.henderson@linaro.org>
References: <20180517224953.11642-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 May 2018 11:39:30 +0100
Message-ID: <CAFEAcA_ofttPqmKOpm1XJJzV_XEEs0SU97bbaFQLYUNwrE8rMw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 00/28] softfloat patch roundup
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

On 17 May 2018 at 23:49, Richard Henderson <richard.henderson@linaro.org> wrote:
> V2 fixing the two erroneous uses of get_fpstatus_ptr
> within the aa32 translator in patch 9.
>
> Only reposting 9/28 here.
>
>
> r~
>
>
>
> The following changes since commit a4207e3b00e89f934adb231057dcf9a75ac2ae45:
>
>   Merge remote-tracking branch 'remotes/cody/tags/block-pull-request' into staging (2018-05-17 11:59:50 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/rth7680/qemu.git pull-fpu-20180517

Something in your pullreq generation flow is a bit off, this
should have read "tags/pull-fpu-20180517" I think.

> for you to fetch changes up to 377ed92679a2a5f838bc0a095112ea5020720fff:
>
>   fpu/softfloat: Define floatN_silence_nan in terms of parts_silence_nan (2018-05-17 15:27:15 -0700)
>
> ----------------------------------------------------------------
> Roundup of softfloat patches

Applied, thanks.

-- PMM
