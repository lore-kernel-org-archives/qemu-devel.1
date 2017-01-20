Received: from eggs.gnu.org ([2001:4830:134:3::10]:44442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cUcER-0008WJ-Q9
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 11:40:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cUcEQ-0001Nj-Vw
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 11:40:07 -0500
Received: from mail-vk0-x22c.google.com ([2607:f8b0:400c:c05::22c]:33008)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cUcEQ-0001Mb-Oq
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 11:40:06 -0500
Received: by mail-vk0-x22c.google.com with SMTP id k127so53405499vke.0
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 08:40:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170120091553.11013-1-cornelia.huck@de.ibm.com>
References: <20170120091553.11013-1-cornelia.huck@de.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Jan 2017 16:39:45 +0000
Message-ID: <CAFEAcA8QobUVjLkW+qsHMumT6bx33BUR7N=0OdVm1W0N214ung@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL v2 00/12] s390x update
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Jens Freimann <jfrei@linux.vnet.ibm.com>, QEMU Developers <qemu-devel@nongnu.org>

On 20 January 2017 at 09:15, Cornelia Huck <cornelia.huck@de.ibm.com> wrote:
> The following changes since commit 0f6bcf68a99efdc531b209551f2b760b0bdcc554:
>
>   Merge remote-tracking branch 'remotes/artyom/tags/pull-sun4v-20170118' into staging (2017-01-19 18:34:13 +0000)
>
> are available in the git repository at:
>
>   git://github.com/cohuck/qemu tags/s390x-20170120-v2
>
> for you to fetch changes up to 8c797e758ad41b8dd6ea6f72c6f0194dedb30a2f:
>
>   virtio-ccw: fix ring sizing (2017-01-20 10:02:02 +0100)
>
> ----------------------------------------------------------------
> First set of s390x patches for 2.9:
> - rework of the zpci code, giving us proper multibus support
> - introduction of the 2.9 machine
> - fixes and improvements
>

Applied, thanks.

-- PMM
