Received: from eggs.gnu.org ([2001:4830:134:3::10]:45838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fdfLB-0003Yb-9d
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 13:25:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fdfLA-0001HL-C6
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 13:25:17 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:32999)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fdfL9-0001GP-Sr
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 13:25:16 -0400
Received: by mail-oi0-x242.google.com with SMTP id l10-v6so10537526oii.0
	for <qemu-devel@nongnu.org>; Thu, 12 Jul 2018 10:25:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180712163152.12521-1-kwolf@redhat.com>
References: <20180712163152.12521-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Jul 2018 18:24:54 +0100
Message-ID: <CAFEAcA_kO75WdOBDj+Qmg_yK8P51ePNBJs-sSOZeP-_C=mzogA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/7] Block layer fixes for 3.0-rc1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 12 July 2018 at 17:31, Kevin Wolf <kwolf@redhat.com> wrote:
> The following changes since commit dc3c89d612252fc461a65f54885a1fe108e9ec05:
>
>   ui/cocoa.m: replace scrollingDeltaY with deltaY (2018-07-12 16:03:50 +0100)
>
> are available in the git repository at:
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to 8dcd3c9b91a300c86e315d7e5427dce1383f7387:
>
>   qemu-img: align result of is_allocated_sectors (2018-07-12 18:24:08 +0200)
>
> ----------------------------------------------------------------
> Block layer patches:
>
> - file-posix: Check correct file type (regular file for 'file',
>   character or block device for 'host_device'/'host_cdrom')
> - scsi-disk: Block Device Characteristics emulation fix
> - qemu-img: Consider required alignment for sparse area detection
> - Documentation and test improvements
>
> ----------------------------------------------------------------


Applied, thanks.

-- PMM
