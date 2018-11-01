Received: from eggs.gnu.org ([2001:4830:134:3::10]:52448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gIEX8-0007uB-9U
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 11:05:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gIEX5-0002aO-CF
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 11:05:17 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:46012)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gIEX4-0002Hi-ON
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 11:05:15 -0400
Received: by mail-ot1-x344.google.com with SMTP id g10so6946916otl.12
	for <qemu-devel@nongnu.org>; Thu, 01 Nov 2018 08:04:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181031113651.32430-1-berrange@redhat.com>
References: <20181031113651.32430-1-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Nov 2018 15:04:18 +0000
Message-ID: <CAFEAcA_qUwUUYYVhS_+edTdECL6POaaDqGd7SBieFjv40_ykWw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/2] Misc next patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 31 October 2018 at 11:36, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
> The following changes since commit a2e002ff7913ce93aa0f7dbedd2123dce5f1a9=
cd:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/qemu-trivial-for-3.1=
-pull-request' into staging (2018-10-30 15:49:55 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/berrange/qemu tags/misc-next-pull-request
>
> for you to fetch changes up to f5177798d899a2ee2a2d0babd3f5399d0f786333:
>
>   scripts: report on author emails that are mangled by the mailing list (=
2018-10-31 11:31:08 +0000)
>
> ----------------------------------------------------------------
> Merge misc fixes
>
> ----------------------------------------------------------------
>
> Daniel P. Berrang=C3=A9 (2):
>   block: drop moderated sheepdog mailing list from MAINTAINERS file
>   scripts: report on author emails that are mangled by the mailing list
>
>  MAINTAINERS           | 1 -
>  scripts/checkpatch.pl | 4 ++++
>  2 files changed, 4 insertions(+), 1 deletion(-)

Applied, thanks.

-- PMM
