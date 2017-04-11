Received: from eggs.gnu.org ([2001:4830:134:3::10]:43722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cxriT-0003dT-QC
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 05:04:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cxriS-0008O1-Kk
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 05:04:01 -0400
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:34646)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cxriS-0008NW-EU
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 05:04:00 -0400
Received: by mail-wr0-x232.google.com with SMTP id z109so24370100wrb.1
	for <qemu-devel@nongnu.org>; Tue, 11 Apr 2017 02:03:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1491834095-6476-1-git-send-email-groug@kaod.org>
References: <1491834095-6476-1-git-send-email-groug@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Apr 2017 10:03:37 +0100
Message-ID: <CAFEAcA84GWe0rfBwnRfisJwgqCW3OLMxmhwY+fRNnBd_O=gSDg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL] 9pfs fix for 2.9 2017-04-10
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 10 April 2017 at 15:21, Greg Kurz <groug@kaod.org> wrote:
> The following changes since commit 5daf9b3025baef10ee7b77daa003d5696b58d5dc:
>
>   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2017-04-07 15:23:48 +0100)
>
> are available in the git repository at:
>
>   https://github.com/gkurz/qemu.git tags/for-upstream
>
> for you to fetch changes up to 4ffcdef4277a91af15a3c09f7d16af072c29f3f2:
>
>   9pfs: xattr: fix memory leak in v9fs_list_xattr (2017-04-10 09:38:05 +0200)
>
> ----------------------------------------------------------------
> Fixes a memory leak.
>
> ----------------------------------------------------------------
> Li Qiang (1):
>       9pfs: xattr: fix memory leak in v9fs_list_xattr
>
>  hw/9pfs/9p-xattr.c | 1 +
>  1 file changed, 1 insertion(+)
> --
> 2.7.4

Applied, thanks.

-- PMM
