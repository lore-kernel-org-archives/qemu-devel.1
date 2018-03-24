Received: from eggs.gnu.org ([2001:4830:134:3::10]:33515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ezm8S-0005Pk-GE
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 12:36:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ezm7O-0001bR-HL
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 12:35:16 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:35519)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ezm7O-0001b8-CP
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 12:34:10 -0400
Received: by mail-ot0-x244.google.com with SMTP id r30-v6so16454199otr.2
	for <qemu-devel@nongnu.org>; Sat, 24 Mar 2018 09:34:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180323173741.1445744-1-eblake@redhat.com>
References: <20180323173741.1445744-1-eblake@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 24 Mar 2018 16:33:49 +0000
Message-ID: <CAFEAcA8JzkBBpXTMa2RtXu4PesEBMPOfrbyRZCbTmPDK8zVrYw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/4] QAPI patches for 2018-03-23,
 for 2.12-rc1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 23 March 2018 at 17:37, Eric Blake <eblake@redhat.com> wrote:
> The following changes since commit 4c2c1015905fa1d616750dfe024b4c0b35875950:
>
>   Merge remote-tracking branch 'remotes/borntraeger/tags/s390x-20180323' into staging (2018-03-23 10:20:54 +0000)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/ericb.git tags/pull-qapi-2018-03-23
>
> for you to fetch changes up to 39615354fc07af34e04ab5efb5b6d478b0d24e32:
>
>   qapi: Force UTF8 encoding when parsing qapi files (2018-03-23 12:29:07 -0500)
>
> There may be another rc1 pull request on Monday, but let's get
> these in sooner rather than later to minimize the window where
> iotests are broken during bisects.
>
> ----------------------------------------------------------------
> qapi patches for 2018-03-12, 2.12-rc1
>
> - Peter Xu: 0/4 Turn OOB off for 2.12-rc1, revert OOB tests
> - Eric Blake: qapi: Force UTF8 encoding when parsing qapi files
>

Applied, thanks.

-- PMM
