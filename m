Received: from eggs.gnu.org ([2001:4830:134:3::10]:37450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cX7DA-0001vx-RC
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 09:09:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cX7D8-00043z-PW
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 09:09:08 -0500
Received: from mail-vk0-x234.google.com ([2607:f8b0:400c:c05::234]:33399)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cX7D8-00043p-Kj
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 09:09:06 -0500
Received: by mail-vk0-x234.google.com with SMTP id k127so175502365vke.0
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 06:09:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170126110315.21759-1-cornelia.huck@de.ibm.com>
References: <20170126110315.21759-1-cornelia.huck@de.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Jan 2017 14:08:45 +0000
Message-ID: <CAFEAcA9x4GtZdVM8-8Hvd6wrUK5hORr3fvfjU5s6myJL6cDPkg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/1] s390x build fix
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

On 26 January 2017 at 11:03, Cornelia Huck <cornelia.huck@de.ibm.com> wrote:
> The following changes since commit c7f1cf01b8245762ca5864e835d84f6677ae8b1f:
>
>   Merge remote-tracking branch 'remotes/gkurz/tags/for-upstream' into staging (2017-01-25 17:54:14 +0000)
>
> are available in the git repository at:
>
>   git://github.com/cohuck/qemu tags/s390x-20170126
>
> for you to fetch changes up to a87adb6685bed1d4dffc55221197ea86ced48361:
>
>   s390x/flic: fix compilation of kvm flic (2017-01-26 10:33:48 +0100)
>
> ----------------------------------------------------------------
> One compile fix for s390x with kvm enabled.
>
> ----------------------------------------------------------------
>
> Cornelia Huck (1):
>   s390x/flic: fix compilation of kvm flic
>
>  hw/intc/s390_flic_kvm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Applied, thanks.

-- PMM
