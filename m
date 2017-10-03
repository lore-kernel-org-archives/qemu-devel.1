Received: from eggs.gnu.org ([2001:4830:134:3::10]:52049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dzMdd-0006GO-8Z
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 08:49:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dzMdc-0002VP-Kb
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 08:49:29 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:52118)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dzMdc-0002U5-D8
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 08:49:28 -0400
Received: by mail-wm0-x22b.google.com with SMTP id f4so8581320wme.0
	for <qemu-devel@nongnu.org>; Tue, 03 Oct 2017 05:49:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170929031831.10179-1-famz@redhat.com>
References: <20170929031831.10179-1-famz@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Oct 2017 13:49:06 +0100
Message-ID: <CAFEAcA-6bT_eYdzB2aFt7J+-8ZytXycmrDO6geLAdyMYE_qMJg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/5] Docker testing patches
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

On 29 September 2017 at 04:18, Fam Zheng <famz@redhat.com> wrote:
> The following changes since commit ab161529261928ae7f3556e3220829c34b2686=
ec:
>
>   Merge remote-tracking branch 'remotes/dgilbert/tags/pull-migration-2017=
0927a' into staging (2017-09-27 22:44:51 +0100)
>
> are available in the git repository at:
>
>   git://github.com/famz/qemu.git tags/docker-testing-pull-request
>
> for you to fetch changes up to 36ac78e65a0695f0e397865cceaf4ab5c4e52c64:
>
>   docker: Don't mount ccache db if NOUSER=3D1 (2017-09-29 11:14:15 +0800)
>
> ----------------------------------------------------------------
>
> ----------------------------------------------------------------
>
> Alex Benn=C3=A9e (1):
>   tests/docker/run: don't source /etc/profile
>
> Fam Zheng (3):
>   docker: Fix test-mingw
>   docker: test-block: Don't continue if build fails
>   docker: Don't mount ccache db if NOUSER=3D1
>
> Paolo Bonzini (1):
>   docker: add installation to build tests
>

Applied, thanks.

-- PMM
