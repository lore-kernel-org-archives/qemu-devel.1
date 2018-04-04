Received: from eggs.gnu.org ([2001:4830:134:3::10]:56987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f3jb7-0006Uc-EO
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 10:41:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f3jb1-0003Ma-TF
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 10:41:13 -0400
Received: from mail-ot0-x231.google.com ([2607:f8b0:4003:c0f::231]:43040)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f3jb1-0003MG-NL
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 10:41:07 -0400
Received: by mail-ot0-x231.google.com with SMTP id m22-v6so23557306otf.10
	for <qemu-devel@nongnu.org>; Wed, 04 Apr 2018 07:41:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180403163400.6307-1-kwolf@redhat.com>
References: <20180403163400.6307-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 4 Apr 2018 15:40:46 +0100
Message-ID: <CAFEAcA9f4JLC=FQ2mjGBnSfaa4wT36e4Awsv4+cHN1hm-qpg_w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/9] Block layer patches for 2.12.0-rc2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 3 April 2018 at 17:33, Kevin Wolf <kwolf@redhat.com> wrote:
> The following changes since commit f184de7553272223d6af731d7d623a7cebf710=
b5:
>
>   Merge remote-tracking branch 'remotes/riscv/tags/riscv-qemu-2.12-critic=
al-fixes' into staging (2018-03-31 09:42:33 +0100)
>
> are available in the git repository at:
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to 9c1386d3ff76c5983529884e3d8420df958c5a29:
>
>   Merge remote-tracking branch 'mreitz/tags/pull-block-2018-04-03' into q=
ueue-block (2018-04-03 17:48:45 +0200)
>
> ----------------------------------------------------------------
> Block layer patches
>
> ----------------------------------------------------------------
> Alberto Garcia (3):
>       iotests: Update 051 and 186 after commit 1454509726719e0933c
>       iotests: Update 186 after commit ac64273c66ab136c44043259162
>       iotests: Test abnormally large size in compressed cluster descripto=
r
>
> Jeff Cody (1):
>       block: handle invalid lseek returns gracefully
>
> Kevin Wolf (2):
>       gluster: Fix blockdev-add with server.N.type=3Dunix
>       Merge remote-tracking branch 'mreitz/tags/pull-block-2018-04-03' in=
to queue-block
>
> Luk=C3=A1=C5=A1 Doktor (1):
>       qemu-iotests: Use ppc64 qemu_arch on ppc64le host
>
> Max Reitz (2):
>       block/file-posix: Fix fully preallocated truncate
>       iotests: Test preallocated truncate of 2G image
>
> Vladimir Sementsov-Ogievskiy (1):
>       iotests: fix 208 for luks format

Applied, thanks.

-- PMM
