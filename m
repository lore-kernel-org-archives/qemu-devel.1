Received: from eggs.gnu.org ([2001:4830:134:3::10]:39135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cj3vb-0007Pl-7j
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 08:04:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cj3va-0005I6-8K
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 08:04:23 -0500
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:33344)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cj3va-0005Hx-0e
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 08:04:22 -0500
Received: by mail-wm0-x22b.google.com with SMTP id i17so8225478wmf.0
	for <qemu-devel@nongnu.org>; Wed, 01 Mar 2017 05:04:21 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170228113153.23867-1-cornelia.huck@de.ibm.com>
References: <20170228113153.23867-1-cornelia.huck@de.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 1 Mar 2017 13:04:00 +0000
Message-ID: <CAFEAcA-cn_Cbj8AJ77KaYOfZtoho8SbT-Pa5u9KP_aD6c1DkFg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL for-2.9 0/5] s390x: network boot
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

On 28 February 2017 at 11:31, Cornelia Huck <cornelia.huck@de.ibm.com> wrote:
> The following changes since commit 6181478f6395cdd9d6ffd99623d0c9f39ea53606:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2017-02-28 08:46:03 +0000)
>
> are available in the git repository at:
>
>   git://github.com/cohuck/qemu tags/s390x-20170228
>
> for you to fetch changes up to e8ebf60f6d12aca2a4d6bb1059bbcda94ea0bbeb:
>
>   pc-bios/s390-ccw.img: rebuild image (2017-02-28 12:04:48 +0100)
>
> ----------------------------------------------------------------
> Network boot for s390x. More information (and instructions
> for building a s390-netboot.img) can be found at
> http://wiki.qemu-project.org/Features/S390xNetworkBoot
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
