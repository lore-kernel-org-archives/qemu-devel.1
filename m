Received: from eggs.gnu.org ([2001:4830:134:3::10]:52081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cX9ry-0000IA-HB
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 11:59:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cX9rt-0000xk-My
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 11:59:22 -0500
Received: from mail-ua0-x22c.google.com ([2607:f8b0:400c:c08::22c]:33573)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cX9rt-0000xE-Ie
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 11:59:21 -0500
Received: by mail-ua0-x22c.google.com with SMTP id i68so208932057uad.0
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 08:59:19 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1485524749-118532-1-git-send-email-pbonzini@redhat.com>
References: <1485524749-118532-1-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Jan 2017 16:58:58 +0000
Message-ID: <CAFEAcA9DkvwegJzty5Q-hv-q4rvOYQErrwPywhy8Lj_VjPonsw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 00/41] Misc changes for 2017-01-27
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

On 27 January 2017 at 13:45, Paolo Bonzini <pbonzini@redhat.com> wrote:
> The following changes since commit 3879284d6517dc22529395bdb259f4183b589127:
>
>   Merge remote-tracking branch 'remotes/berrange/tags/pull-qio-2017-01-23-2' into staging (2017-01-23 15:59:09 +0000)
>
> are available in the git repository at:
>
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 0a24326232f7c7f8c5ab9080784312d05d496e47:
>
>   memory: don't sign-extend 32-bit writes (2017-01-26 15:29:49 +0100)
>

Conflict in target/i386/kvm.c which I didn't quite feel
confident of resolving, though I suspect it's mostly
trivial. Can you rebase, please?

thanks
-- PMM
