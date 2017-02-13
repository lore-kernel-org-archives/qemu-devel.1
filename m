Received: from eggs.gnu.org ([2001:4830:134:3::10]:45972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cdEvc-00080G-Ll
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 06:36:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cdEvb-0002Bn-GD
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 06:36:20 -0500
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:36715)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cdEvb-0002BA-8m
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 06:36:19 -0500
Received: by mail-wr0-x22a.google.com with SMTP id k90so148107148wrc.3
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 03:36:18 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1486973851-21645-1-git-send-email-kraxel@redhat.com>
References: <1486973851-21645-1-git-send-email-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Feb 2017 11:35:57 +0000
Message-ID: <CAFEAcA8GqHqnm9fRDBTRWXWerqHwoxiUH1TGpXxNbbW1DQ=15w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/6] vga patch queue
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

On 13 February 2017 at 08:17, Gerd Hoffmann <kraxel@redhat.com> wrote:
>   Hi,
>
> Here comes the vga patch queue, bringing bugfixes
> for cirrus and virtio-gpu.
>
> please pull,
>   Gerd
>
> The following changes since commit 33d076ebd05491d9f7cace682b4ed70c33263f12:
>
>   Merge remote-tracking branch 'remotes/stsquad/tags/pull-travis-10022017-1' into staging (2017-02-10 15:05:37 +0000)
>
> are available in the git repository at:
>
>
>   git://git.kraxel.org/qemu tags/pull-vga-20170213-1
>
> for you to fetch changes up to 12e97ec39931e5321645fd483ab761319d48bf16:
>
>   Revert "cirrus: allow zero source pitch in pattern fill rops" (2017-02-10 16:49:45 +0100)
>
> ----------------------------------------------------------------
> vga: bugfixes for cirrus and virtio-gpu
>

Applied, thanks.

-- PMM
