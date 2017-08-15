Received: from eggs.gnu.org ([2001:4830:134:3::10]:45532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dhYL9-0006N8-6V
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 05:40:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dhYL8-0004Cx-7O
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 05:40:47 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:33012)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dhYL7-00047o-Vp
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 05:40:46 -0400
Received: by mail-wr0-x236.google.com with SMTP id b65so1541557wrd.0
	for <qemu-devel@nongnu.org>; Tue, 15 Aug 2017 02:40:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170815073146.11726-1-cohuck@redhat.com>
References: <20170815073146.11726-1-cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 15 Aug 2017 10:40:22 +0100
Message-ID: <CAFEAcA9U7iMQJ37du-NeUQ4pPNSQN64m6ZxGwUaWMW5+AfRmOg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL for-2.10 0/1] bugfix for s390x
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>

On 15 August 2017 at 08:31, Cornelia Huck <cohuck@redhat.com> wrote:
> The following changes since commit 83c3a1f61673ef554facf4d6d29ed56c5a219f9d:
>
>   xlnx-qspi: add a property for mmio-execution (2017-08-14 14:17:18 +0100)
>
> are available in the git repository at:
>
>   git://github.com/cohuck/qemu tags/s390x-20170815
>
> for you to fetch changes up to 88b3739acdec0b8ccdbb65425b0d31235e2c7ca3:
>
>   pc-bios/s390-ccw: Use rm command during make clean (2017-08-15 09:06:01 +0200)
>
> ----------------------------------------------------------------
> Regression fix for 'make clean' on s390x.
>
> ----------------------------------------------------------------
>
> Eric Farman (1):
>   pc-bios/s390-ccw: Use rm command during make clean
>
>  pc-bios/s390-ccw/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- PMM
