Received: from eggs.gnu.org ([2001:4830:134:3::10]:56355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eLv6E-0007oa-T7
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 13:04:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eLv6D-0001OA-V6
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 13:04:14 -0500
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:44708)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eLv6D-0001No-Q0
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 13:04:13 -0500
Received: by mail-ot0-x241.google.com with SMTP id d27so15512588ote.11
	for <qemu-devel@nongnu.org>; Mon, 04 Dec 2017 10:04:13 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171204170103.13973-1-kwolf@redhat.com>
References: <20171204170103.13973-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Dec 2017 18:03:52 +0000
Message-ID: <CAFEAcA8UmT24ZJNTzwvhFQx_e9r3EXKWpRbFvjc817KfkBDB-A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/1] Block layer patch for 2.11.0-rc4
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, Alberto Garcia <berto@igalia.com>, QEMU Developers <qemu-devel@nongnu.org>

On 4 December 2017 at 17:01, Kevin Wolf <kwolf@redhat.com> wrote:
> The following changes since commit 495566ec38817e6625294e6909cffb4de040c8e7:
>
>   Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-2.11-20171204' into staging (2017-12-04 11:27:53 +0000)
>
> are available in the git repository at:
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to 3d5d319e1221082974711af1d09d82f0755c1698:
>
>   blockjob: Make block_job_pause_all() keep a reference to the jobs (2017-12-04 17:44:51 +0100)
>
> ----------------------------------------------------------------
> Block layer patches for 2.11.0-rc4
>
> ----------------------------------------------------------------
> Alberto Garcia (1):
>       blockjob: Make block_job_pause_all() keep a reference to the jobs
>
>  blockjob.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Applied, thanks.

-- PMM
