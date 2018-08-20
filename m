Received: from eggs.gnu.org ([2001:4830:134:3::10]:49852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1frnpp-0000h1-Tf
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 13:19:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1frnpp-0005jt-3K
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 13:19:21 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:43163)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1frnpo-0005iz-U1
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 13:19:21 -0400
Received: by mail-oi0-x243.google.com with SMTP id b15-v6so27104648oib.10
	for <qemu-devel@nongnu.org>; Mon, 20 Aug 2018 10:19:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180820125341.5882-1-cohuck@redhat.com>
References: <20180820125341.5882-1-cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Aug 2018 18:18:59 +0100
Message-ID: <CAFEAcA-r-Op939zBp71z4yVveJStyd+NnHf9oU=BnZS_vFQiEw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/7] s390x patches for 3.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-s390x <qemu-s390x@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 20 August 2018 at 13:53, Cornelia Huck <cohuck@redhat.com> wrote:
> The following changes since commit 627fce617868df87b3757375a2a0318ad2beb381:
>
>   tests/boot-serial-test: Bump timeout to 6 minutes (2018-08-20 10:39:27 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/cohuck/qemu tags/s390x-20180820
>
> for you to fetch changes up to 09c6c754804df4d997f84fd9c17d90c5b4ce948c:
>
>   s390x: Enable KVM huge page backing support (2018-08-20 14:18:49 +0200)
>
> ----------------------------------------------------------------
> First round of s390x patches for 3.1:
> - add compat machine for 3.1
> - remove deprecated 's390-squash-mcss' option
> - cpu models: add "max" cpu model, enhance feature group code
> - kvm: add support for etoken facility and huge page backing
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
