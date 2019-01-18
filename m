Received: from eggs.gnu.org ([209.51.188.92]:48470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkZHy-0002mq-8N
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 13:54:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkZHw-0005Z5-UZ
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 13:54:46 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:36412)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gkZHw-0005Tn-NV
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 13:54:44 -0500
Received: by mail-ot1-x343.google.com with SMTP id k98so15305662otk.3
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 10:54:36 -0800 (PST)
MIME-Version: 1.0
References: <20190118121925.24468-1-cohuck@redhat.com>
In-Reply-To: <20190118121925.24468-1-cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Jan 2019 18:54:24 +0000
Message-ID: <CAFEAcA9cUmJ=EqP=uBN_r9d2jw-FtNbuL+D+tFDjJCNPojQQhQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/11] s390x updates
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

On Fri, 18 Jan 2019 at 12:19, Cornelia Huck <cohuck@redhat.com> wrote:
>
> The following changes since commit 681d61362d3f766a00806b89d6581869041f73cb:
>
>   Merge remote-tracking branch 'remotes/jnsnow/tags/bitmaps-pull-request' into staging (2019-01-17 12:48:42 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/cohuck/qemu tags/s390x-20190118
>
> for you to fetch changes up to 6e92c70c37547b6a247a206651dfcc583a57f484:
>
>   s390x/pci: add common function measurement block (2019-01-18 11:52:01 +0100)
>
> ----------------------------------------------------------------
> s390x updates:
> - clang compilation fixes
> - fixes in zpci hotplug code
> - handle unimplemented diag 308 subcodes correctly
> - add common fmb in zpci
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
