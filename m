Received: from eggs.gnu.org ([2001:4830:134:3::10]:53067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eEYPR-0001hi-Np
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 05:25:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eEYPQ-0004PY-VI
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 05:25:37 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:39863)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eEYPQ-0004Oz-OE
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 05:25:36 -0500
Received: by mail-wm0-x242.google.com with SMTP id l8so14744909wmg.4
	for <qemu-devel@nongnu.org>; Tue, 14 Nov 2017 02:25:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171110140236.26651-1-kraxel@redhat.com>
References: <20171110140236.26651-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Nov 2017 10:25:14 +0000
Message-ID: <CAFEAcA85r-3GxU2A7baaqPf_x7H-iuAsYEv-etHRt1+-Gq-xwA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/2] Ui 20171110 patches
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

On 10 November 2017 at 14:02, Gerd Hoffmann <kraxel@redhat.com> wrote:
> The following changes since commit b0fbe46ad82982b289a44ee2495b59b0bad8a8=
42:
>
>   Update version for v2.11.0-rc0 release (2017-11-07 16:05:28 +0000)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/ui-20171110-pull-request
>
> for you to fetch changes up to 2e9a8565701c22a0090876cb9e2293db4a6fb205:
>
>   ui: use QEMU_IS_ALIGNED macro (2017-11-10 14:27:29 +0100)
>
> ----------------------------------------------------------------
> ui: fixes for 2.11
>
> ----------------------------------------------------------------
>
> Gerd Hoffmann (1):
>   ui: fix dcl unregister
>
> Philippe Mathieu-Daud=C3=A9 (1):
>   ui: use QEMU_IS_ALIGNED macro
>
>  ui/console-gl.c | 2 +-
>  ui/console.c    | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
>

Applied, thanks.

-- PMM
