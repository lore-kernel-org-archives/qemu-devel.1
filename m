Received: from eggs.gnu.org ([2001:4830:134:3::10]:44920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gJyyA-0004hy-S3
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 05:52:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gJyy8-0007zQ-VL
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 05:52:26 -0500
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230]:45052)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gJyy6-0007k6-Nm
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 05:52:23 -0500
Received: by mail-oi1-x230.google.com with SMTP id k19-v6so10275379oic.11
	for <qemu-devel@nongnu.org>; Tue, 06 Nov 2018 02:52:19 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181105164340.20707-1-cohuck@redhat.com>
References: <20181105164340.20707-1-cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Nov 2018 10:51:58 +0000
Message-ID: <CAFEAcA_qZhJb55d+gV3diFSj3UawhioT5HPBzrFPA9Bga_x7sw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/6] final s390x patches for -rc0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, Collin Walling <walling@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, qemu-s390x <qemu-s390x@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 5 November 2018 at 16:43, Cornelia Huck <cohuck@redhat.com> wrote:
> The following changes since commit 7d56239f159afc2e7bd42623947e56ba48f37836:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20181102' into staging (2018-11-02 17:17:12 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/cohuck/qemu tags/s390x-20181105
>
> for you to fetch changes up to 8e4eb4279fce9a736131b94b6f5f09f0503e4ab3:
>
>   MAINTAINERS: s390/boot: the ipl code and the bios belong together (2018-11-05 09:55:29 +0100)
>
> ----------------------------------------------------------------
> - some changes in s390x maintainership
> - bugfix in vfio-ap
>
> ----------------------------------------------------------------
Applied, thanks.

-- PMM
