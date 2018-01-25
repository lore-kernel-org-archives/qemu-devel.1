Received: from eggs.gnu.org ([2001:4830:134:3::10]:39695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eekKl-0008KN-IB
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 11:25:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eekKk-0007hU-K6
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 11:25:03 -0500
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:39318)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eekKk-0007gs-EE
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 11:25:02 -0500
Received: by mail-oi0-x242.google.com with SMTP id t8so5595941oie.6
	for <qemu-devel@nongnu.org>; Thu, 25 Jan 2018 08:25:02 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180125093455.6356-1-kraxel@redhat.com>
References: <20180125093455.6356-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jan 2018 16:24:41 +0000
Message-ID: <CAFEAcA_-9Q_kK=AzWey=LwouoNZNeiyWpX_A2P87q69PNa4=jQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/1] Vga 20180125 patches
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

On 25 January 2018 at 09:34, Gerd Hoffmann <kraxel@redhat.com> wrote:
> The following changes since commit 834a336eb911db8a8ca00e760ee6a85faca19414:
>
>   Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2018-01-24 19:24:26 +0000)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/vga-20180125-pull-request
>
> for you to fetch changes up to 191f59dc17396bb5a8da50f8c59b6e0a430711a4:
>
>   vga: check the validation of memory addr when draw text (2018-01-25 10:18:39 +0100)
>
> ----------------------------------------------------------------
> vga: fix for CVE-2018-5683
>
> ----------------------------------------------------------------
>
> linzhecheng (1):
>   vga: check the validation of memory addr when draw text
>
>  hw/display/vga.c | 3 +++
>  1 file changed, 3 insertions(+)

Applied, thanks.

-- PMM
