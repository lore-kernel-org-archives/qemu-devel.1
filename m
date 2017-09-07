Received: from eggs.gnu.org ([2001:4830:134:3::10]:58034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dpzz3-0000Hn-P1
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 12:48:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dpzyz-0005go-5s
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 12:48:53 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:33572)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dpzyy-0005gO-UM
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 12:48:49 -0400
Received: by mail-wr0-x22c.google.com with SMTP id a43so544394wrc.0
	for <qemu-devel@nongnu.org>; Thu, 07 Sep 2017 09:48:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1504790904-17018-1-git-send-email-peter.maydell@linaro.org>
References: <1504790904-17018-1-git-send-email-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Sep 2017 17:48:26 +0100
Message-ID: <CAFEAcA8QdJVVmeXVfg8=8Fr3CwwbCwCnA0FQn=L1u5rFYeDm0A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/31] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

On 7 September 2017 at 14:27, Peter Maydell <peter.maydell@linaro.org> wrote:
> Second ARM pull request of this week; this one has my next
> set of v8M patches and a handful of more minor stuff from
> other people.
>
> thanks
> -- PMM
>
> The following changes since commit 8ee5f9b3ecc94e3eb7a8235f4b2c3ec9024807f6:
>
>   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2017-09-07 10:45:18 +0100)
>
> are available in the git repository at:
>
>   git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20170907
>
> for you to fetch changes up to c99a55d38dd5b5131f3fcbbaf41828a09ee62544:
>
>   target/arm: Add Jazelle feature (2017-09-07 13:54:55 +0100)
>
> ----------------------------------------------------------------
> target-arm:
>  * cleanups converting to DEFINE_PROP_LINK
>  * allwinner-a10: mark as not user-creatable
>  * initial patches working towards ARMv8M support
>  * implement generating aborts on memory transaction failures
>  * make BXJ behave correctly (ie not UNDEF) on ARMv6-and-later

Applied, thanks.

-- PMM
