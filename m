Received: from eggs.gnu.org ([2001:4830:134:3::10]:42405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXRFN-0006Gj-Cz
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 08:41:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXRFH-0003fa-V4
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 08:41:49 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:39315)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gXRFF-0003Wg-UZ
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 08:41:42 -0500
Received: by mail-oi1-x243.google.com with SMTP id i6so1628966oia.6
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 05:41:41 -0800 (PST)
MIME-Version: 1.0
References: <20181212095519.6390-1-cohuck@redhat.com>
In-Reply-To: <20181212095519.6390-1-cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Dec 2018 13:41:29 +0000
Message-ID: <CAFEAcA-nBVRjPsXH8bweVniyCfqX_WyPSieDgHLNdgHUbExUPg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/6] s390x: first batch of 4.0 changes
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

On Wed, 12 Dec 2018 at 09:55, Cornelia Huck <cohuck@redhat.com> wrote:
>
> The following changes since commit bb9bf94b3e8926553290bc9a7cb84315af422086:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/machine-next-pull-request' into staging (2018-12-11 19:18:58 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/cohuck/qemu tags/s390x-20181212
>
> for you to fetch changes up to c9aacaadeb42076c01b07e59dd94dcf73f751e05:
>
>   hw/s390x/virtio-ccw.c: Don't take address of fields in packed structs (2018-12-12 10:39:28 +0100)
>
> ----------------------------------------------------------------
> s390x patches for 4.0:
> - add 4.0 machine type
> - various fixes and small changes
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
