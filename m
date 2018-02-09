Received: from eggs.gnu.org ([2001:4830:134:3::10]:42438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ek8iT-00034c-2l
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 08:27:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ek8iS-0003oT-DK
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 08:27:49 -0500
Received: from mail-oi0-x231.google.com ([2607:f8b0:4003:c06::231]:46132)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ek8iS-0003nx-7V
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 08:27:48 -0500
Received: by mail-oi0-x231.google.com with SMTP id x21so6093330oie.13
	for <qemu-devel@nongnu.org>; Fri, 09 Feb 2018 05:27:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180209092524.31348-1-cohuck@redhat.com>
References: <20180209092524.31348-1-cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 9 Feb 2018 13:27:26 +0000
Message-ID: <CAFEAcA94xqeQ0X+i=KdGm8Vqto16kK_xmzdN36pZhpU4qyMBBg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/29] s390x: assorted updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-s390x <qemu-s390x@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>

On 9 February 2018 at 09:24, Cornelia Huck <cohuck@redhat.com> wrote:
> The following changes since commit 008a51bbb343972dd8cf09126da8c3b87f4e1c96:
>
>   Merge remote-tracking branch 'remotes/famz/tags/staging-pull-request' into staging (2018-02-08 14:31:51 +0000)
>
> are available in the git repository at:
>
>   git://github.com/cohuck/qemu tags/s390x-20180209
>
> for you to fetch changes up to ced01bb7e5d353a9055743d68d54f3581b29328c:
>
>   MAINTAINERS: add David as additional tcg/s390 maintainer (2018-02-09 09:37:13 +0100)
>
> ----------------------------------------------------------------
> s390x updates:
> - rework interrupt handling for tcg, smp is now considered non-experimental
> - some general improvements in the flic
> - improvements in the pci code, and wiring it up in tcg
> - add PTFF subfunctions for multiple-epoch to the cpu model
> - maintainership updates
> - various other fixes and improvements
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
