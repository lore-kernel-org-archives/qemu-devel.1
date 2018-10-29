Received: from eggs.gnu.org ([2001:4830:134:3::10]:60642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gH9GI-0003fk-Uk
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:15:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gH9GD-0008Au-3o
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:15:26 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234]:43685)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gH9GC-0008Ah-UZ
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:15:21 -0400
Received: by mail-oi1-x234.google.com with SMTP id j202-v6so6945241oih.10
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 08:15:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181029124703.11123-1-kraxel@redhat.com>
References: <20181029124703.11123-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Oct 2018 15:14:58 +0000
Message-ID: <CAFEAcA_v_Rw9WuMuFNG4-_kYT32r-fMUz0pPE9OA8HFhMo94JQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/2] Vga 20181029 patches
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

On 29 October 2018 at 12:47, Gerd Hoffmann <kraxel@redhat.com> wrote:
> The following changes since commit b312532fd03413d0e6ae6767ec793a3e30f487b8:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2018-10-19 19:01:07 +0100)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/vga-20181029-pull-request
>
> for you to fetch changes up to e69a10f468d8f6aa6c00a4308f5a8e1f2fd6b3a1:
>
>   vga_int: remove unused function protype (2018-10-29 10:43:48 +0100)
>
> ----------------------------------------------------------------
> vga: two fixes.
>
> ----------------------------------------------------------------
>
> Gerd Hoffmann (1):
>   qxl: store channel id in qxl->id
>
> yuchenlin (1):
>   vga_int: remove unused function protype
>
>  hw/display/qxl.h     |  1 +
>  hw/display/vga_int.h |  1 -
>  hw/display/qxl.c     | 19 ++++++++++++-------
>  3 files changed, 13 insertions(+), 8 deletions(-)

Applied, thanks.

-- PMM
