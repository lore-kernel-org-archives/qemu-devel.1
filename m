Received: from eggs.gnu.org ([2001:4830:134:3::10]:47222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eEO5o-0002KU-Vv
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 18:24:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eEO5o-00043V-7y
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 18:24:40 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:53854)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eEO5o-00043B-0s
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 18:24:40 -0500
Received: by mail-wr0-x242.google.com with SMTP id u40so15899279wrf.10
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 15:24:39 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171110132644.8069-1-kraxel@redhat.com>
References: <20171110132644.8069-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Nov 2017 23:24:18 +0000
Message-ID: <CAFEAcA8Xiqx2Lwiu-y83n3BcmuYB5LPRstw_127CKiXOttEsEA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/3] Vga 20171110 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 10 November 2017 at 13:26, Gerd Hoffmann <kraxel@redhat.com> wrote:
> The following changes since commit b0fbe46ad82982b289a44ee2495b59b0bad8a8=
42:
>
>   Update version for v2.11.0-rc0 release (2017-11-07 16:05:28 +0000)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/vga-20171110-pull-request
>
> for you to fetch changes up to cf7040e284069fc235172c187551b268c66d8553:
>
>   vmsvga: use ARRAY_SIZE macro (2017-11-10 14:25:56 +0100)
>
> ----------------------------------------------------------------
> vga: bugfixes for 2.11
>
> ----------------------------------------------------------------
>
> Gerd Hoffmann (1):
>   vga: fix region checks in wraparound case
>
> Philippe Mathieu-Daud=C3=A9 (1):
>   vmsvga: use ARRAY_SIZE macro
>
> Tao Wu (1):
>   virtio-gpu: fix bug in host memory calculation.
>
>  hw/display/vga.c        |  4 ++--
>  hw/display/virtio-gpu.c | 16 ++++++++++++++--
>  hw/display/vmware_vga.c |  5 ++---
>  3 files changed, 18 insertions(+), 7 deletions(-)
>
Applied, thanks.

-- PMM
