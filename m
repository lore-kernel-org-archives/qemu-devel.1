Received: from eggs.gnu.org ([209.51.188.92]:38832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gr5M1-0007As-Km
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:21:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gr5M0-0000Jd-KW
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:21:53 -0500
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f]:46797)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gr5M0-0008O5-FT
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:21:52 -0500
Received: by mail-ot1-x32f.google.com with SMTP id w25so7289941otm.13
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 10:21:22 -0800 (PST)
MIME-Version: 1.0
References: <20190205164109.25413-1-cohuck@redhat.com>
In-Reply-To: <20190205164109.25413-1-cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Feb 2019 18:21:10 +0000
Message-ID: <CAFEAcA9pXNRDRn_EUBt1R-Fgtq9rc8NSobndstgHDqXmnNYueg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/10] s390x update
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

On Tue, 5 Feb 2019 at 16:41, Cornelia Huck <cohuck@redhat.com> wrote:
>
> The following changes since commit a61faa3d02159d24d4fa984733dbc0c905508752:
>
>   Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-4.0-20190204' into staging (2019-02-04 10:33:40 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/cohuck/qemu tags/s390x-20190205
>
> for you to fetch changes up to 2313a88fe68cb970532ba1641ffc35c848daae86:
>
>   s390x/pci: Unplug remaining requested devices on pcihost reset (2019-02-05 10:34:06 +0100)
>
> ----------------------------------------------------------------
> Fixes and improvements in tcg and the zPCI code.
>
> ----------------------------------------------------------------

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
