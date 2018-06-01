Received: from eggs.gnu.org ([2001:4830:134:3::10]:53646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fOgB0-0000oZ-Tm
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 05:16:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fOgB0-0001HS-1Q
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 05:16:50 -0400
Received: from mail-oi0-x235.google.com ([2607:f8b0:4003:c06::235]:36368)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fOgAz-0001HI-SC
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 05:16:49 -0400
Received: by mail-oi0-x235.google.com with SMTP id 14-v6so13912944oie.3
	for <qemu-devel@nongnu.org>; Fri, 01 Jun 2018 02:16:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180531160039.29304-1-peter.maydell@linaro.org>
References: <20180531160039.29304-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Jun 2018 10:16:28 +0100
Message-ID: <CAFEAcA8za=w+hqw-BiFxGSj21xy08AbhrH6NEe0XHpnJEpWffA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/25] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

On 31 May 2018 at 17:00, Peter Maydell <peter.maydell@linaro.org> wrote:
> target-arm queue. This has the "plumb txattrs through various
> bits of exec.c" patches, and a collection of bug fixes from
> various people.
>
> v2: fix compile error on arm hosts...
>
> thanks
> -- PMM
>
>
> The following changes since commit a3ac12fba028df90f7b3dbec924995c126c41022:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/numa-next-pull-request' into staging (2018-05-31 11:12:36 +0100)
>
> are available in the Git repository at:
>
>   git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20180531-1
>
> for you to fetch changes up to 2f15b79280cf71b7991dfd3f0312a1797630e376:
>
>   KVM: GIC: Fix memory leak due to calling kvm_init_irq_routing twice (2018-05-31 16:32:35 +0100)
>

Applied, thanks.

-- PMM
