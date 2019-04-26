Received: from eggs.gnu.org ([209.51.188.92]:54984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hK0va-0006EZ-Oc
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 09:30:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hK0vZ-0001S1-Do
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 09:30:10 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236]:45568)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hK0vZ-0001Qi-7n
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 09:30:09 -0400
Received: by mail-oi1-x236.google.com with SMTP id y84so2877462oia.12
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 06:30:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190425132134.2839-1-cohuck@redhat.com>
In-Reply-To: <20190425132134.2839-1-cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Apr 2019 14:29:56 +0100
Message-ID: <CAFEAcA-qj+WqTDi4L9uZZEKD58SYsQ9PHFxM5gJHH0RAApxZJg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/19] first batch of s390x patches for 4.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-s390x <qemu-s390x@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On Thu, 25 Apr 2019 at 14:21, Cornelia Huck <cohuck@redhat.com> wrote:
>
> The following changes since commit 3284aa128153750f14a61e8a96fd085e6f2999b6:
>
>   Merge remote-tracking branch 'remotes/lersek/tags/edk2-pull-2019-04-22' into staging (2019-04-24 13:19:41 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/cohuck/qemu tags/s390x-20190425
>
> for you to fetch changes up to 41c3d4269b1c18d12d33c5bf089dace25d08e82e:
>
>   Merge tag 's390-ccw-bios-2019-04-12' into s390-next-staging (2019-04-25 14:09:20 +0200)
>
> ----------------------------------------------------------------
> - properly detect page size of initial memory
> - support for IPL (boot) from ECKD DASD passed through via vfio-ccw
>
> ----------------------------------------------------------------
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM
