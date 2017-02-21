Received: from eggs.gnu.org ([2001:4830:134:3::10]:47554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cgAy3-0002sE-NX
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 08:59:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cgAy3-00045X-5A
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 08:58:59 -0500
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:37544)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cgAy2-00045I-Ul
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 08:58:59 -0500
Received: by mail-wm0-x234.google.com with SMTP id v77so76169670wmv.0
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 05:58:58 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170221115644.28264-1-stefanha@redhat.com>
References: <20170221115644.28264-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Feb 2017 13:58:37 +0000
Message-ID: <CAFEAcA94ETsJjufq9dGq6+QUON2H+vFOyS45mwEtU=gOm0QC3Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL v2 00/24] Block patches
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

On 21 February 2017 at 11:56, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> The following changes since commit 56f9e46b841c7be478ca038d8d4085d776ab4b0d:
>
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-qapi-2017-02-20' into staging (2017-02-20 17:42:47 +0000)
>
> are available in the git repository at:
>
>   git://github.com/stefanha/qemu.git tags/block-pull-request
>
> for you to fetch changes up to a7b91d35bab97a2d3e779d0c64c9b837b52a6cf7:
>
>   coroutine-lock: make CoRwlock thread-safe and fair (2017-02-21 11:39:40 +0000)
>
> ----------------------------------------------------------------
> Pull request
>
> v2:
>  * Rebased to resolve scsi conflicts
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
