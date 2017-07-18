Received: from eggs.gnu.org ([2001:4830:134:3::10]:42606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dXYCL-0002Zd-Ew
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 15:30:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dXYCK-0001wq-H5
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 15:30:21 -0400
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:33067)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dXYCK-0001wT-A9
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 15:30:20 -0400
Received: by mail-wr0-x22f.google.com with SMTP id v105so13106701wrb.0
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 12:30:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170717221516.7692-1-eblake@redhat.com>
References: <20170717221516.7692-1-eblake@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Jul 2017 20:29:58 +0100
Message-ID: <CAFEAcA-bBLFfr27m-Q3T-01BMA3PLkcmsodh1tDU2BGAVTbCsA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL for-2.10 0/3] NBD patches for 2.10 soft
 freeze
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 17 July 2017 at 23:15, Eric Blake <eblake@redhat.com> wrote:
> The following changes since commit ca4e667dbf431d4a2a5a619cde79d30dd2ac3eb2:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/usb-20170717-pull-request' into staging (2017-07-17 17:54:17 +0100)
>
> are available in the git repository at:
>
>   git://repo.or.cz/qemu/ericb.git tags/pull-nbd-2017-07-17
>
> for you to fetch changes up to 5f66d060dbc37214c9d70305710c3e34c4531d7c:
>
>   nbd: Fix server reply to NBD_OPT_EXPORT_NAME of older clients (2017-07-17 17:06:46 -0500)
>
> ----------------------------------------------------------------
> nbd patches for 2017-07-17
>
> - Eric Blake: nbd: Fix iotests failure due to changed client error message
> - Eric Blake: [0/2] NBD fixes before softfreeze
>
> ----------------------------------------------------------------
> Eric Blake (3):
>       nbd: Fix iotests failure due to changed client error message
>       nbd: Trace client command being sent
>       nbd: Fix server reply to NBD_OPT_EXPORT_NAME of older clients

Applied, thanks.

-- PMM
