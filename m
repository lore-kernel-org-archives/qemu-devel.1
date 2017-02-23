Received: from eggs.gnu.org ([2001:4830:134:3::10]:36004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cgqBa-0006hD-B1
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 04:59:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cgqBZ-0000Xy-In
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 04:59:42 -0500
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:38759)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cgqBZ-0000Xt-D8
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 04:59:41 -0500
Received: by mail-wm0-x22c.google.com with SMTP id r141so6745062wmg.1
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 01:59:41 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170221185527.3901-1-dgilbert@redhat.com>
References: <20170221185527.3901-1-dgilbert@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Feb 2017 09:59:19 +0000
Message-ID: <CAFEAcA-SEmOFmKH=YC+EOiyVLS8GruSZvnE4YHMc4QPhFKYCQg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/3] hmp queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, phrdina@redhat.com

On 21 February 2017 at 18:55, Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> The following changes since commit 796b288f7be875045670f963ce99991b3c8e96ac:
>
>   Merge remote-tracking branch 'remotes/cody/tags/block-pull-request' into staging (2017-02-21 15:48:22 +0000)
>
> are available in the git repository at:
>
>   git://github.com/dagrh/qemu.git tags/pull-hmp-20170221
>
> for you to fetch changes up to 854e67fea6a6f181163a5467fc9ba04de8d181bb:
>
>   monitor: Fix crashes when using HMP commands without CPU (2017-02-21 18:29:01 +0000)
>
> ----------------------------------------------------------------
> HMP pull
>
> Note, I had seen a fail in the vhost-user/flags-mismatch on one
> host in one build, but not others with the same patches; and these patches
> go nowhere near that, so I think that's a separate vhost-user issue.


Applied, thanks.

-- PMM
