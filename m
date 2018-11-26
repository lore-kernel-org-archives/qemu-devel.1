Received: from eggs.gnu.org ([2001:4830:134:3::10]:48515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gRGCu-00057D-KL
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 07:41:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gRGCt-0005M4-QK
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 07:41:44 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:41060)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gRGCt-0005Lo-KY
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 07:41:43 -0500
Received: by mail-ot1-x343.google.com with SMTP id u16so16395854otk.8
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 04:41:43 -0800 (PST)
MIME-Version: 1.0
References: <20181126095710.380206-1-groug@kaod.org>
In-Reply-To: <20181126095710.380206-1-groug@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Nov 2018 12:41:31 +0000
Message-ID: <CAFEAcA-egBA0NO_SL-Tyf-dx3QOXjXCs9q03dNUZy3bfYPS6Pw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/1] 9p fixes for v3.1.0-rc3
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

On Mon, 26 Nov 2018 at 09:57, Greg Kurz <groug@kaod.org> wrote:
>
> The following changes since commit 5298f4d67a911dd9cefa4c4185eed242074d64c2:
>
>   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2018-11-23 08:54:52 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/gkurz/qemu.git tags/for-upstream
>
> for you to fetch changes up to 1d20398694a3b67a388d955b7a945ba4aa90a8a8:
>
>   9p: fix QEMU crash when renaming files (2018-11-23 13:28:03 +0100)
>
> ----------------------------------------------------------------
> Fixes a QEMU crash triggerable by guest userspace (CVE-2018-19489).
>
> ----------------------------------------------------------------
> Greg Kurz (1):
>       9p: fix QEMU crash when renaming files
>
>  hw/9pfs/9p.c | 3 +++
>  1 file changed, 3 insertions(+)
> --

Applied, thanks.

-- PMM
