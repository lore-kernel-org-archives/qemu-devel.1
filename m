Received: from eggs.gnu.org ([209.51.188.92]:54667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gk5xc-0000yb-PZ
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:35:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gk5xb-0006MM-U9
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:35:48 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:39892)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gk5xb-0006Ik-DO
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:35:47 -0500
Received: by mail-ot1-x344.google.com with SMTP id n8so10801506otl.6
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 03:35:47 -0800 (PST)
MIME-Version: 1.0
References: <20190114225306.21569-1-samuel.thibault@ens-lyon.org>
In-Reply-To: <20190114225306.21569-1-samuel.thibault@ens-lyon.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 Jan 2019 11:35:34 +0000
Message-ID: <CAFEAcA-NMi3PmOpiHRCkaGYyR0e8p6+gWC+k=LAgv1-ZCDVVMg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULLv3 00/65] slirp updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>

On Mon, 14 Jan 2019 at 23:01, Samuel Thibault
<samuel.thibault@ens-lyon.org> wrote:
>
> The following changes since commit 27df21ca3886fff4dd3d70e515517667963a52f1:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/misc-20190111-pull-request' into staging (2019-01-11 16:45:59 +0000)
>
> are available in the Git repository at:
>
>   https://people.debian.org/~sthibault/qemu.git tags/samuel-thibault
>
> for you to fetch changes up to a7104eda7dab99d0cdbd3595c211864cba415905:
>
>   slirp: check data length while emulating ident function (2019-01-14 23:36:38 +0100)
>
> ----------------------------------------------------------------

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
