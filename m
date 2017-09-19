Received: from eggs.gnu.org ([2001:4830:134:3::10]:50726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1duNBn-0002j6-AL
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 14:24:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1duNBm-0004hc-FJ
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 14:24:07 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:55589)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1duNBm-0004cZ-9r
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 14:24:06 -0400
Received: by mail-wr0-x22b.google.com with SMTP id l39so350055wrl.12
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 11:24:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170919164337.18555-1-cohuck@redhat.com>
References: <20170919164337.18555-1-cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Sep 2017 19:23:43 +0100
Message-ID: <CAFEAcA9mietCLhXsOrkN2-B06ZYs53Nw8euop9x9kZQo_W9sqA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 00/38] various s390x patches (+some fixes)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>

On 19 September 2017 at 17:42, Cornelia Huck <cohuck@redhat.com> wrote:
> The following changes since commit 7ec6a364916c0d1eba01128481e503a550a2b466:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2017-09-19 15:44:07 +0100)
>
> are available in the git repository at:
>
>   git://github.com/cohuck/qemu tags/s390x-20170919-v2
>
> for you to fetch changes up to 9d1c4449218d8a2e98a6a11688b09b9137f25c1c:
>
>   MAINTAINERS/s390x: add terminal3270.c (2017-09-19 18:31:32 +0200)
>
> ----------------------------------------------------------------
> Assorted s390x patches:
> - introduce virtio-gpu-ccw, with virtio-gpu endian fixes
> - lots of cleanup in the s390x code
> - make device_add work for s390x cpus
> - enable seccomp on s390x
> - an ivshmem endian fix
> - set the reserved DHCP client architecture id for netboot
> - fixes in the css and pci support
>

Applied, thanks.

-- PMM
