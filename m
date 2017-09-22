Received: from eggs.gnu.org ([2001:4830:134:3::10]:44149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dvMYr-0002z4-PJ
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 07:56:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dvMYr-0008UE-1D
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 07:56:01 -0400
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:45870)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dvMYq-0008Tm-Qd
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 07:56:00 -0400
Received: by mail-wm0-x22e.google.com with SMTP id q124so3205898wmb.0
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 04:56:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170922074659.30097-1-famz@redhat.com>
References: <20170922074659.30097-1-famz@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Sep 2017 12:55:39 +0100
Message-ID: <CAFEAcA-zqvcOSTi0jTVMH6uhuRdQzANd9pHFO_pm=-=Zsw185w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v5 00/36] Build and test automation patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 22 September 2017 at 08:46, Fam Zheng <famz@redhat.com> wrote:
> The following changes since commit 0a8066f0c068f1e318a1aacd7864fc00e455a37b:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20170921' into staging (2017-09-21 17:42:27 +0100)
>
> are available in the git repository at:
>
>   git://github.com/famz/qemu.git tags/build-and-test-automation-pull-request
>
> for you to fetch changes up to 4f6afe41f2ee3d8170eef7a9122d256588b707b2:
>
>   docker: Drop 'set -e' from run script (2017-09-22 14:51:43 +0800)
>
> ----------------------------------------------------------------
>
> Since v4:
>
> - Drop three iffy -cflags patches from me (for gtk/vnc/curses).
> - Revised VM test scripts after addressing comments.
> - Add Eduardo's small tweak on MAINTAINERS.
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
