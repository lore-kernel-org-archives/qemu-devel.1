Received: from eggs.gnu.org ([2001:4830:134:3::10]:39366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fdc8B-00069w-Eq
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 09:59:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fdc8A-0002iS-Cj
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 09:59:39 -0400
Received: from mail-oi0-x22b.google.com ([2607:f8b0:4003:c06::22b]:34385)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fdc8A-0002ht-8V
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 09:59:38 -0400
Received: by mail-oi0-x22b.google.com with SMTP id 13-v6so55954840ois.1
	for <qemu-devel@nongnu.org>; Thu, 12 Jul 2018 06:59:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180712093301.9343-1-cohuck@redhat.com>
References: <20180712093301.9343-1-cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Jul 2018 14:59:17 +0100
Message-ID: <CAFEAcA_d5BGO_A6eeyWwSZ7Uy9xTUFUZzWo3bpZeEfhYJrm90w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL for-3.0 0/2] s390x changes for 3.0-rc
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

On 12 July 2018 at 10:32, Cornelia Huck <cohuck@redhat.com> wrote:
> The following changes since commit c447afd5783b9237fa51b7a85777007d8d568bfc:
>
>   Update version for v3.0.0-rc0 release (2018-07-10 18:19:50 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/cohuck/qemu tags/s390x-20180712
>
> for you to fetch changes up to 78dcf512efe72e211e6ca7783069364b01a1c05b:
>
>   error: Remove NULL checks on error_propagate() calls (2018-07-11 14:36:54 +0200)
>
> ----------------------------------------------------------------
> - fix confusion around sizes in storage attribute migration
> - remove NULL check on error_propagate() in virtio-ccw
>
> ----------------------------------------------------------------
>

Applied, thanks.

-- PMM
