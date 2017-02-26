Received: from eggs.gnu.org ([2001:4830:134:3::10]:53339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1chxHr-0000SF-5D
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 06:46:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1chxHq-0001KR-7A
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 06:46:47 -0500
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:37940)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1chxHq-0001KH-0s
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 06:46:46 -0500
Received: by mail-wm0-x22d.google.com with SMTP id r141so43718531wmg.1
	for <qemu-devel@nongnu.org>; Sun, 26 Feb 2017 03:46:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1487937300-33744-1-git-send-email-yongbok.kim@imgtec.com>
References: <1487937300-33744-1-git-send-email-yongbok.kim@imgtec.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 26 Feb 2017 11:46:24 +0000
Message-ID: <CAFEAcA_a_umYo+8X69XmeAR2GUs+=1t+-0b3dLVipZd0JVx0dQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL] target-mips queue
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

On 24 February 2017 at 11:54, Yongbok Kim <yongbok.kim@imgtec.com> wrote:
> The following changes since commit 2d896b454a0e19ec4c1ddbb0e0b65b7e54fcedf3:
>
>   Revert "hw/mips: MIPS Boston board support" (2017-02-23 18:04:45 +0000)
>
> are available in the git repository at:
>
>   git://github.com/yongbok/upstream-qemu.git tags/mips-20170224-2
>
> for you to fetch changes up to df1d8a1f29f567567b9d20be685a4241282e7005:
>
>   hw/mips: MIPS Boston board support (2017-02-24 10:37:21 +0000)
>
> ----------------------------------------------------------------
> MIPS patches 2017-02-24-2
>
> CHanges:
> * Add the Boston board with fixing the make check issue on 32-bit hosts.
>

Applied, thanks.

-- PMM
