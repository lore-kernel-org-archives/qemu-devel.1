Received: from eggs.gnu.org ([2001:4830:134:3::10]:44001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eFPUM-00049i-Du
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 14:06:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eFPUL-00085s-G6
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 14:06:14 -0500
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:43625)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eFPUL-000858-8V
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 14:06:13 -0500
Received: by mail-wr0-x233.google.com with SMTP id u40so31669wrf.10
	for <qemu-devel@nongnu.org>; Thu, 16 Nov 2017 11:06:12 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171116163614.24710-1-stefanha@redhat.com>
References: <20171116163614.24710-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Nov 2017 19:05:50 +0000
Message-ID: <CAFEAcA9WQvLKuZjoqNtNo1pnr9bewrDxE5DCbLh0x2ihkA7m0A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL for-2.11 0/1] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 16 November 2017 at 16:36, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> The following changes since commit 8048082f7a11040a366942a2de8abb4c3d0020c9:
>
>   Merge remote-tracking branch 'remotes/stefanberger/tags/pull-tpm-2017-11-15-1' into staging (2017-11-16 11:34:24 +0000)
>
> are available in the git repository at:
>
>   git://github.com/stefanha/qemu.git tags/block-pull-request
>
> for you to fetch changes up to 341e0b5658681f46680024cdbfc998717d85cc35:
>
>   throttle-groups: forget timer and schedule next TGM on detach (2017-11-16 14:12:57 +0000)
>
> ----------------------------------------------------------------
>
> ----------------------------------------------------------------
>
> Stefan Hajnoczi (1):
>   throttle-groups: forget timer and schedule next TGM on detach
>
>  block/throttle-groups.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Applied, thanks.

-- PMM
