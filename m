Received: from eggs.gnu.org ([2001:4830:134:3::10]:55045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1chKhM-00088U-B5
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 13:34:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1chKhL-0001nm-HV
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 13:34:32 -0500
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:38705)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1chKhL-0001nX-B6
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 13:34:31 -0500
Received: by mail-wm0-x236.google.com with SMTP id r141so21134201wmg.1
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 10:34:31 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170223193048.16909.25661.stgit@gimli.home>
References: <20170223193048.16909.25661.stgit@gimli.home>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Feb 2017 18:34:09 +0000
Message-ID: <CAFEAcA__LEFJAiP3UNsgEUx_1BG3AGw4kH-EAE+Q0bUx3PZYog@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/3] VFIO updates 2017-02-23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 23 February 2017 at 19:32, Alex Williamson
<alex.williamson@redhat.com> wrote:
> The following changes since commit 796b288f7be875045670f963ce99991b3c8e96ac:
>
>   Merge remote-tracking branch 'remotes/cody/tags/block-pull-request' into staging (2017-02-21 15:48:22 +0000)
>
> are available in the git repository at:
>
>
>   git://github.com/awilliam/qemu-vfio.git tags/vfio-updates-20170223.0
>
> for you to fetch changes up to c2b2e158cc7b1cb431bd6039824ec13c3184a775:
>
>   vfio/pci-quirks.c: Disable stolen memory for igd VFIO (2017-02-22 13:19:59 -0700)
>
> ----------------------------------------------------------------
> VFIO updates 2017-02-23
>
>  - Report qdev_unplug errors (Alex Williamson)
>  - Fix ecap ID 0 handling, improve comment (Alex Williamson)
>  - Disable IGD stolen memory in UPT mode too (Xiong Zhang)
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
