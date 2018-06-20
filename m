Received: from eggs.gnu.org ([2001:4830:134:3::10]:51173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fVZn6-0000GL-N3
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 05:52:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fVZn5-0001U7-VR
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 05:52:40 -0400
Received: from mail-ot0-x22d.google.com ([2607:f8b0:4003:c0f::22d]:35825)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fVZn5-0001Tx-FO
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 05:52:39 -0400
Received: by mail-ot0-x22d.google.com with SMTP id q17-v6so3044990otg.2
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 02:52:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180619120434.25062-1-cohuck@redhat.com>
References: <20180619120434.25062-1-cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 20 Jun 2018 10:52:18 +0100
Message-ID: <CAFEAcA8NS6t6GeGN-F9_o5Tynig-EAR8ECgmu=MHOVuo-ZyjcQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/12] next round of s390x patches
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

On 19 June 2018 at 13:04, Cornelia Huck <cohuck@redhat.com> wrote:
> The following changes since commit 2ef2f16781af9dee6ba6517755e9073ba5799fa2:
>
>   Merge remote-tracking branch 'remotes/dgilbert/tags/pull-migration-20180615a' into staging (2018-06-15 18:13:35 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/cohuck/qemu tags/s390x-20180619
>
> for you to fetch changes up to 49b67e9440892179c016a7afd33725a50d995ba6:
>
>   Merge tag 'tags/s390x-2018-06-18' into staging (2018-06-18 17:05:39 +0200)
>
> ----------------------------------------------------------------
> - cleanup in virtio-ccw
> - accommodate guests using vfio-ccw without specifying unlimited
>   prefetch, but actually working fine
> - add cpu model for the z14 Model ZR1
> - add support for pxelinux.cfg-style network booting to the s390x
>   firmware
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
