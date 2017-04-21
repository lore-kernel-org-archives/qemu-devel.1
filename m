Received: from eggs.gnu.org ([2001:4830:134:3::10]:55760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d1W10-00040p-3S
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 06:42:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d1W0z-0008L2-G1
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 06:42:14 -0400
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:36273)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1d1W0z-0008KQ-9i
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 06:42:13 -0400
Received: by mail-wr0-x234.google.com with SMTP id c55so52201535wrc.3
	for <qemu-devel@nongnu.org>; Fri, 21 Apr 2017 03:42:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170420184705.25018-1-ehabkost@redhat.com>
References: <20170420184705.25018-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Apr 2017 11:41:51 +0100
Message-ID: <CAFEAcA87OExNaDi58O0b_bvRgdcR8Hk17QnXkEXCeO7Q=zspqw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 00/15] Machine queue for 2.10
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Peter Xu <peterx@redhat.com>

On 20 April 2017 at 19:46, Eduardo Habkost <ehabkost@redhat.com> wrote:
> This includes a few IOMMU fixes because Michael is away this
> week.
>
> The following changes since commit da92ada855036c55bd08b0b0c64c7551d56f3586:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20170420' into staging (2017-04-20 17:41:34 +0100)
>
> are available in the git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/machine-pull-request
>
> for you to fetch changes up to be9721f400f7e5395bb2a257c291557df8f3f833:
>
>   qdev: Constify local variable returned by blk_bs (2017-04-20 15:22:41 -0300)
>
> ----------------------------------------------------------------
> Machine queue for 2.10

Applied, thanks.

-- PMM
