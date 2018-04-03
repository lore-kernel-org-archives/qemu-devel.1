Received: from eggs.gnu.org ([2001:4830:134:3::10]:52804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f3NOi-0007Es-2G
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 10:58:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f3NOh-0007Az-Bo
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 10:58:56 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:41404)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f3NOh-0007Ah-6m
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 10:58:55 -0400
Received: by mail-oi0-x244.google.com with SMTP id 188-v6so16231436oih.8
	for <qemu-devel@nongnu.org>; Tue, 03 Apr 2018 07:58:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180329135730.95774-1-dgilbert@redhat.com>
References: <20180329135730.95774-1-dgilbert@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Apr 2018 15:58:34 +0100
Message-ID: <CAFEAcA8cNbS0wtk+MT52LXj35sPJToJSztbxrGiBvDZjt__ypg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/2] migration queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Juan Quintela <quintela@redhat.com>

On 29 March 2018 at 14:57, Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> The following changes since commit 47d3b60858d90ac8a0cc3a72af7f95c9678112=
5a:
>
>   Merge remote-tracking branch 'remotes/riscv/tags/riscv-qemu-2.12-import=
ant-fixes' into staging (2018-03-28 22:13:38 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/dagrh/qemu.git tags/pull-migration-20180329a
>
> for you to fetch changes up to 0746a92612276aee69e66dfe6782b0f882d221d5:
>
>   migration: Don't activate block devices if using -S (2018-03-29 14:53:1=
6 +0100)
>
> ----------------------------------------------------------------
> Migration pull (small fixes)
>
> A pair of two small fixes for 2.12.
>
> ----------------------------------------------------------------
> Dr. David Alan Gilbert (1):
>       migration: Don't activate block devices if using -S
>
> Marc-Andr=C3=A9 Lureau (1):
>       migration: fix pfd leak
>
>  migration/migration.c    | 22 +++++++++++++++-------
>  migration/postcopy-ram.c |  1 +
>  2 files changed, 16 insertions(+), 7 deletions(-)
>

Applied, thanks.

-- PMM
