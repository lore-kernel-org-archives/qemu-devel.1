Received: from eggs.gnu.org ([2001:4830:134:3::10]:53423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cj4go-00028S-El
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 08:53:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cj4gn-0004Au-Na
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 08:53:10 -0500
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:35072)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cj4gn-0004Ai-Gw
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 08:53:09 -0500
Received: by mail-wm0-x22c.google.com with SMTP id v186so110749671wmd.0
	for <qemu-devel@nongnu.org>; Wed, 01 Mar 2017 05:53:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170228124458.31307-1-famz@redhat.com>
References: <20170228124458.31307-1-famz@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 1 Mar 2017 13:52:47 +0000
Message-ID: <CAFEAcA-RRd1Uyu+fJU+i6BCbB9i9j3Sh8gYrHpf+dvxWiK752w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/2] Docker patches
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

On 28 February 2017 at 12:44, Fam Zheng <famz@redhat.com> wrote:
> The following changes since commit 6181478f6395cdd9d6ffd99623d0c9f39ea536=
06:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request'=
 into staging (2017-02-28 08:46:03 +0000)
>
> are available in the git repository at:
>
>   git://github.com/famz/qemu.git tags/docker-pull-request
>
> for you to fetch changes up to 1ed9251515382a1fc9c6187fee8d7d7bf141dc90:
>
>   .shippable: add s390x-cross target (2017-02-28 20:31:01 +0800)
>
> ----------------------------------------------------------------
>
> Two more test/build automation patches from Alex for the freeze. Theoreti=
cally
> these are okay to merge even after freeze but on the other hand I see no =
reason
> to delay them.
>
> ----------------------------------------------------------------
>
> Alex Benn=C3=A9e (2):
>   new: dockerfiles/debian-s390-cross
>   .shippable: add s390x-cross target
>
>  .shippable.yml                                     |  2 ++
>  tests/docker/dockerfiles/debian-s390x-cross.docker | 22 ++++++++++++++++=
++++++
>  2 files changed, 24 insertions(+)
>  create mode 100644 tests/docker/dockerfiles/debian-s390x-cross.docker

Applied, thanks.

-- PMM
