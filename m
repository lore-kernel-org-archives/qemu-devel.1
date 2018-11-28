Received: from eggs.gnu.org ([2001:4830:134:3::10]:33845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gS0CI-0001Rb-G5
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 08:48:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gS0CH-0004D6-KP
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 08:48:10 -0500
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f]:42416)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gS0CH-0004Cv-Cy
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 08:48:09 -0500
Received: by mail-oi1-x22f.google.com with SMTP id w13so22542543oiw.9
	for <qemu-devel@nongnu.org>; Wed, 28 Nov 2018 05:48:09 -0800 (PST)
MIME-Version: 1.0
References: <1543402390-3754-1-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1543402390-3754-1-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 28 Nov 2018 13:47:57 +0000
Message-ID: <CAFEAcA9Va5eS0A93=UMs0YYMUwewSvkkz2BjXX_gweQ4YnKL9Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v4 00/14] Misc patches for QEMU 3.1.0-rc3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Wed, 28 Nov 2018 at 10:54, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit 4822f1ee9efa8df56e29db0a68323b484bdb03=
35:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/fixes-31-20181127-pul=
l-request' into staging (2018-11-27 11:21:38 +0000)
>
> are available in the git repository at:
>
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 86100290cb6600b3d65e0794b45c1b82ead99411:
>
>   hostmem: no need to check for host_memory_backend_mr_inited() in alloc(=
) (2018-11-28 11:51:24 +0100)
>
> ----------------------------------------------------------------
> * lsi HBA reselection fix (George)
> * Small cleanups (Li Qiang)
> * bugfixes for vhost-user-bridge and hostmem (Marc-Andr=C3=A9)
> * single-thread TCG fix (me)
> * VMX migration blocker (me)
> * target/i386 fix for LOCK (Richard)
> * MAINTAINERS update (Philippe, Thomas)
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
