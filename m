Received: from eggs.gnu.org ([2001:4830:134:3::10]:34709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dXNgc-0000RO-3m
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 04:16:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dXNgb-0001gl-71
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 04:16:54 -0400
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:33677)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dXNgb-0001gd-1F
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 04:16:53 -0400
Received: by mail-wr0-x230.google.com with SMTP id a10so17812356wrd.0
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 01:16:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170717121127.25154-1-stefanha@redhat.com>
References: <20170717121127.25154-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Jul 2017 09:16:31 +0100
Message-ID: <CAFEAcA8wgS75DbLsFcFMyB=3EX+AL1Ju2QmF4dpyLMMAgwaAfQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/7] Tracing patches
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

On 17 July 2017 at 13:11, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> The following changes since commit 4871b51b9241b10f4fd8e04bbb21577886795e=
25:
>
>   vmgenid-test: use boot-sector infrastructure (2017-07-14 17:03:03 +0100=
)
>
> are available in the git repository at:
>
>   git://github.com/stefanha/qemu.git tags/tracing-pull-request
>
> for you to fetch changes up to 304187c51cfe1ffda1afc9b86c4ccae1cbac68cb:
>
>   trace: update old trace events in docs (2017-07-17 13:11:13 +0100)
>
> ----------------------------------------------------------------
>
> ----------------------------------------------------------------
>
> Llu=C3=ADs Vilanova (6):
>   trace: Allocate cpu->trace_dstate in place
>   trace: [tcg] Delay changes to dynamic state when translating
>   exec: [tcg] Use different TBs according to the vCPU's dynamic tracing
>     state
>   trace: [tcg] Do not generate TCG code to trace dynamically-disabled
>     events
>   trace: [tcg, trivial] Re-align generated code
>   trace: [trivial] Statically enable all guest events
>
> Stefan Hajnoczi (1):
>   trace: update old trace events in docs
>

Applied, thanks.

-- PMM
