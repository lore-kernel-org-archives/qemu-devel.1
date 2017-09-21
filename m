Received: from eggs.gnu.org ([2001:4830:134:3::10]:51583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dv2fQ-00087Y-Sn
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 10:41:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dv2fL-0000CU-9v
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 10:41:28 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:49923)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dv2fL-0000BT-26
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 10:41:23 -0400
Received: by mail-wr0-x229.google.com with SMTP id u96so4755808wrb.6
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 07:41:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1506001091-8296-1-git-send-email-yongbok.kim@imgtec.com>
References: <1506001091-8296-1-git-send-email-yongbok.kim@imgtec.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 Sep 2017 15:41:01 +0100
Message-ID: <CAFEAcA_fAzQ4Byh-yhh2Z-OkjMadaX1Fg3F0GmtHSCmk_ZDT+g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/7] target-mips queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yongbok Kim <yongbok.kim@imgtec.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 21 September 2017 at 14:38, Yongbok Kim <yongbok.kim@imgtec.com> wrote:
> Hi,
>
> The patch 1 and 2 contain checkpatch.pl errors but patch 1 is relocating a file
> and patch 2 has false positive warnings.
>
> Regards,
> Yongbok
>
> The following changes since commit ff5667ed53c544c4dc88dcd7cb23cc509c9a55e0:
>
>   Merge remote-tracking branch 'remotes/mcayland/tags/qemu-sparc-signed' into staging (2017-09-21 10:56:09 +0100)
>
> are available in the git repository at:
>
>   git://github.com/yongbok/upstream-qemu.git tags/mips-20170921
>
> for you to fetch changes up to 2a2be359c4335607c7f746cf27c412c08ab89aff:
>
>   mips: Improve macro parenthesization (2017-09-21 13:25:41 +0100)
>
> ----------------------------------------------------------------
> MIPS patches 2017-09-21
>
> Changes:
> QOMify MIPS cpu
> Improve macro parenthesization
>

Applied, thanks.

-- PMM
