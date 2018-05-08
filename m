Received: from eggs.gnu.org ([2001:4830:134:3::10]:40511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fG3Ya-0003iJ-Mc
	for qemu-devel@nongnu.org; Tue, 08 May 2018 10:25:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fG3YV-0004G0-0r
	for qemu-devel@nongnu.org; Tue, 08 May 2018 10:25:32 -0400
Received: from mail-oi0-x234.google.com ([2607:f8b0:4003:c06::234]:33156)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fG3YU-0004Fr-Rc
	for qemu-devel@nongnu.org; Tue, 08 May 2018 10:25:26 -0400
Received: by mail-oi0-x234.google.com with SMTP id k5-v6so21680622oiw.0
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 07:25:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180507095225.11659-1-kraxel@redhat.com>
References: <20180507095225.11659-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 May 2018 15:25:05 +0100
Message-ID: <CAFEAcA9DTs8dhc4=jvmDHXXba86v3K0PZD8Cv9MBsMXn03PJEQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/1] Vga 20180507 patches
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

On 7 May 2018 at 10:52, Gerd Hoffmann <kraxel@redhat.com> wrote:
> The following changes since commit c8b7e627b4269a3bc3ae41d9f420547a47e6d9b9:
>
>   Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2018-05-04' into staging (2018-05-04 14:42:46 +0100)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/vga-20180507-pull-request
>
> for you to fetch changes up to 5bd5c27c7d284d01477c5cc022ce22438c46bf9f:
>
>   qxl: fix local renderer crash (2018-05-07 11:47:57 +0200)
>
> ----------------------------------------------------------------
> qxl: fix local renderer crash
>
> ----------------------------------------------------------------
>
> Gerd Hoffmann (1):
>   qxl: fix local renderer crash
>
>  hw/display/qxl-render.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied, thanks.

-- PMM
