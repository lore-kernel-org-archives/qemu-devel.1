Received: from eggs.gnu.org ([2001:4830:134:3::10]:55838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1chhJg-00014e-MW
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 13:43:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1chhJg-0002bh-0R
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 13:43:36 -0500
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:35480)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1chhJf-0002bW-PZ
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 13:43:35 -0500
Received: by mail-wr0-x235.google.com with SMTP id g10so29404905wrg.2
	for <qemu-devel@nongnu.org>; Sat, 25 Feb 2017 10:43:35 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170224092259.16483-1-cornelia.huck@de.ibm.com>
References: <20170224092259.16483-1-cornelia.huck@de.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 25 Feb 2017 18:43:13 +0000
Message-ID: <CAFEAcA8z0A-9DX3wkJqEk=OicrnWAxRCSfMY7E5+-XNUmCfr2g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 00/13] s390x patches for 2.9
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

On 24 February 2017 at 09:22, Cornelia Huck <cornelia.huck@de.ibm.com> wrote:
> The following changes since commit 10f25e4844cb9b3f02fb032f88051dd5b65b4206:
>
>   Merge remote-tracking branch 'remotes/yongbok/tags/mips-20170222' into staging (2017-02-23 09:59:40 +0000)
>
> are available in the git repository at:
>
>   git://github.com/cohuck/qemu tags/s390x-20170224
>
> for you to fetch changes up to 9f94f84ce7df633142953806cc4c102765cabc0e:
>
>   s390x/css: handle format-0 TIC CCW correctly (2017-02-24 10:15:18 +0100)
>
> ----------------------------------------------------------------
> A selection of s390x patches:
> - cleanups, fixes and improvements
> - program check loop detection (useful with the corresponding kernel
>   patch)
> - wire up virtio-crypto for ccw
> - and finally support many virtqueues for virtio-ccw
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
